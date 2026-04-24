import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge/application/services/cloud_backup_client.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/daos/profile_dao.dart';
import 'package:forge/data/local/db/daos/settings_dao.dart';
import 'package:forge/data/local/db/daos/sync_queue_dao.dart';
import 'package:forge/data/repositories/profile_repository_impl.dart';
import 'package:forge/data/repositories/settings_repository_impl.dart';
import 'package:forge/data/repositories/sync_repository_impl.dart';
import 'package:forge/domain/entities/app_setting.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/enums/sync_domain.dart';
import 'package:forge/shared/enums/sync_queue_status.dart';
import 'package:forge/shared/enums/sync_source.dart';
import 'package:forge/shared/enums/weight_unit.dart';

void main() {
  late AppDatabase database;
  late SyncRepositoryImpl repository;
  late ProfileRepositoryImpl profileRepository;
  late _FakeCloudBackupClient backupClient;
  late SyncQueueDao queueDao;

  setUp(() {
    database = AppDatabase.test(NativeDatabase.memory());
    queueDao = SyncQueueDao(database);
    backupClient = _FakeCloudBackupClient();
    repository = SyncRepositoryImpl(
      database: database,
      queueDao: queueDao,
      settingsRepository: SettingsRepositoryImpl(SettingsDao(database)),
      cloudBackupClient: backupClient,
    );
    profileRepository = ProfileRepositoryImpl(ProfileDao(database));
  });

  tearDown(() async {
    await database.close();
  });

  test('linking an account preserves existing local profile data', () async {
    final now = DateTime(2026, 4, 22, 14);
    await ProfileDao(database).upsertProfile(
      UsersTableCompanion.insert(
        id: 'user-1',
        displayName: 'Mohamed',
        preferredWeightUnit: WeightUnit.kilograms,
        preferredBodyMetricUnit: BodyMetricUnit.centimeters,
        createdAt: now,
        updatedAt: now,
      ),
    );

    final linked = await repository.linkLocalDataToAccount(
      accountId: 'account-1',
      email: 'forge@example.com',
    );
    final profile = await profileRepository.getProfile();
    final queue = await repository.getPendingQueue();

    expect(linked.accountId, 'account-1');
    expect(profile, isNotNull);
    expect(profile!.displayName, 'Mohamed');
    expect(queue, hasLength(SyncDomain.values.length));
  });

  test(
    're-enqueueing local changes does not duplicate queue entries',
    () async {
      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );

      final firstCount = await repository.enqueueLocalChanges();
      final secondCount = await repository.enqueueLocalChanges();
      final queue = await repository.getPendingQueue();

      expect(firstCount, SyncDomain.values.length);
      expect(secondCount, SyncDomain.values.length);
      expect(queue, hasLength(SyncDomain.values.length));
    },
  );

  test(
    'uploadPendingBatches uploads queued snapshot batches and marks them synced',
    () async {
      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );

      final result = await repository.uploadPendingBatches();
      final queueRows = await queueDao.getQueueForAccount('account-1');

      expect(result.attemptedCount, SyncDomain.values.length);
      expect(result.uploadedCount, SyncDomain.values.length);
      expect(result.failedCount, 0);
      expect(backupClient.uploads, hasLength(SyncDomain.values.length));
      expect(
        queueRows.every((row) => row.status == SyncQueueStatus.synced),
        isTrue,
      );
    },
  );

  test(
    'uploadPendingBatches marks failed rows and keeps them retryable',
    () async {
      backupClient.failDomains = {SyncDomain.nutrition.name};
      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );

      final result = await repository.uploadPendingBatches();
      final queueRows = await queueDao.getQueueForAccount('account-1');
      final failedRow = queueRows.firstWhere(
        (row) => row.domain == SyncDomain.nutrition,
      );

      expect(result.failedCount, 1);
      expect(failedRow.status, SyncQueueStatus.failed);
      expect(failedRow.retryCount, 1);

      backupClient.failDomains = {};
      final retryResult = await repository.uploadPendingBatches();
      final retriedRows = await queueDao.getQueueForAccount('account-1');
      final recoveredRow = retriedRows.firstWhere(
        (row) => row.domain == SyncDomain.nutrition,
      );

      expect(retryResult.uploadedCount, 1);
      expect(recoveredRow.status, SyncQueueStatus.synced);
    },
  );

  test(
    'uploadPendingBatches rejects upload when no linked account exists',
    () async {
      expect(repository.uploadPendingBatches(), throwsA(isA<StateError>()));
    },
  );

  test(
    'uploadPendingBatches rejects upload when the remote session is gone',
    () async {
      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );
      backupClient.currentSignedInAccountId = null;

      expect(repository.uploadPendingBatches(), throwsA(isA<StateError>()));
    },
  );

  test(
    'uploadPendingBatches excludes built-in exercises and internal settings metadata',
    () async {
      final settingsRepository = SettingsRepositoryImpl(SettingsDao(database));
      final now = DateTime(2026, 4, 22, 16);
      await database
          .into(database.exercisesTable)
          .insert(
            ExercisesTableCompanion.insert(
              id: 'built-in-bench',
              name: 'Bench Press',
              primaryMuscleGroup: 'chest',
              isBuiltIn: const Value(true),
              createdAt: now,
              updatedAt: now,
            ),
          );
      await database
          .into(database.exercisesTable)
          .insert(
            ExercisesTableCompanion.insert(
              id: 'custom-pull',
              name: 'Custom Pull',
              primaryMuscleGroup: 'back',
              isBuiltIn: const Value(false),
              createdAt: now,
              updatedAt: now,
            ),
          );
      await settingsRepository.save(
        AppSetting(key: 'theme_mode', value: 'dark', updatedAt: now),
      );
      await settingsRepository.save(
        AppSetting(
          key: 'health_connect_last_sync_at',
          value: now.toIso8601String(),
          updatedAt: now,
        ),
      );

      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );
      await repository.uploadPendingBatches();

      final workoutUpload = backupClient.uploads.firstWhere(
        (upload) => upload.domainKey == SyncDomain.workouts.name,
      );
      final workoutTables =
          workoutUpload.payloadJson['tables']! as Map<String, Object?>;
      final uploadedExercises =
          workoutTables[database.exercisesTable.actualTableName]!
              as List<Object?>;
      final settingsUpload = backupClient.uploads.firstWhere(
        (upload) => upload.domainKey == SyncDomain.settings.name,
      );
      final settingsTables =
          settingsUpload.payloadJson['tables']! as Map<String, Object?>;
      final uploadedSettings =
          settingsTables[database.appSettingsTable.actualTableName]!
              as List<Object?>;
      final uploadedSettingKeys = uploadedSettings
          .cast<Map<String, Object?>>()
          .map((row) => row['key'])
          .toSet();

      expect(
        uploadedExercises.cast<Map<String, Object?>>().map((row) => row['id']),
        ['custom-pull'],
      );
      expect(uploadedSettingKeys, contains('theme_mode'));
      expect(
        uploadedSettingKeys,
        isNot(contains('health_connect_last_sync_at')),
      );
      expect(uploadedSettingKeys, isNot(contains('auth_installation_id')));
      expect(uploadedSettingKeys, isNot(contains('sync_last_success_at')));
    },
  );

  test(
    'uploadPendingBatches excludes raw health sync records from cloud payloads',
    () async {
      final now = DateTime(2026, 4, 22, 16);
      await database
          .into(database.healthSyncRecordsTable)
          .insert(
            HealthSyncRecordsTableCompanion.insert(
              id: 'hc-step-1',
              source: SyncSource.healthConnect,
              recordType: 'steps',
              externalId: const Value('remote-step-1'),
              payloadJson: '{"steps":4321}',
              recordedAt: now,
              createdAt: now,
            ),
          );

      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );
      await repository.uploadPendingBatches();

      final healthUpload = backupClient.uploads.firstWhere(
        (upload) => upload.domainKey == SyncDomain.health.name,
      );
      final healthTables =
          healthUpload.payloadJson['tables']! as Map<String, Object?>;

      expect(
        healthTables.containsKey(
          database.healthSyncRecordsTable.actualTableName,
        ),
        isFalse,
      );
    },
  );

  test(
    'getRemoteBackups groups batches by installation and marks the current device',
    () async {
      final now = DateTime(2026, 4, 23, 9);
      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );
      final installationId = await repository.getOrCreateInstallationId();
      backupClient.remoteBatches = [
        _remoteBatch(
          installationId: installationId,
          domain: SyncDomain.bodyProgress,
          uploadedAt: now,
          payloadJson: {
            'tables': {
              database.bodyLogsTable.actualTableName: [
                {'id': 'body-1'},
              ],
            },
          },
        ),
        _remoteBatch(
          installationId: 'forge-local-other',
          domain: SyncDomain.nutrition,
          uploadedAt: now.add(const Duration(hours: 1)),
          payloadJson: {
            'tables': {
              database.savedMealsTable.actualTableName: [
                {'id': 'saved-1'},
              ],
            },
          },
        ),
      ];

      final backups = await repository.getRemoteBackups();

      expect(backups, hasLength(2));
      expect(backups.first.installationId, 'forge-local-other');
      expect(backups.first.isCurrentDevice, isFalse);
      expect(backups.last.installationId, installationId);
      expect(backups.last.isCurrentDevice, isTrue);
    },
  );

  test(
    'getRemoteBackupPreview reports supported, partial, and deferred domains honestly',
    () async {
      final now = DateTime(2026, 4, 23, 9);
      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );
      backupClient.remoteBatches = [
        _remoteBatch(
          installationId: 'forge-local-other',
          domain: SyncDomain.bodyProgress,
          uploadedAt: now,
          payloadJson: {
            'tables': {
              database.bodyLogsTable.actualTableName: [
                {'id': 'body-1', 'logged_at': now.toIso8601String()},
              ],
            },
          },
        ),
        _remoteBatch(
          installationId: 'forge-local-other',
          domain: SyncDomain.workouts,
          uploadedAt: now,
          payloadJson: {
            'tables': {
              database.exercisesTable.actualTableName: [
                {'id': 'exercise-1'},
              ],
              database.workoutTemplatesTable.actualTableName: [
                {'id': 'template-1'},
              ],
              database.workoutSessionsTable.actualTableName: [
                {'id': 'session-1'},
              ],
            },
          },
        ),
        _remoteBatch(
          installationId: 'forge-local-other',
          domain: SyncDomain.health,
          uploadedAt: now,
          payloadJson: {
            'tables': {
              database.healthProfilesTable.actualTableName: [
                {'id': 'health-1'},
              ],
            },
          },
        ),
      ];

      final preview = await repository.getRemoteBackupPreview(
        'forge-local-other',
      );

      expect(preview.hasImportableDomains, isTrue);
      expect(
        preview.domains
            .firstWhere((domain) => domain.domain == SyncDomain.bodyProgress)
            .supportLevel
            .name,
        'supported',
      );
      expect(
        preview.domains
            .firstWhere((domain) => domain.domain == SyncDomain.workouts)
            .supportLevel
            .name,
        'partial',
      );
      expect(
        preview.domains
            .firstWhere((domain) => domain.domain == SyncDomain.health)
            .supportLevel
            .name,
        'deferred',
      );
    },
  );

  test(
    'importRemoteBackup additively imports supported domains and skips duplicates on repeat',
    () async {
      final now = DateTime(2026, 4, 23, 9);
      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );
      backupClient.remoteBatches = [
        _remoteBatch(
          installationId: 'forge-local-other',
          domain: SyncDomain.bodyProgress,
          uploadedAt: now,
          payloadJson: {
            'tables': {
              database.bodyLogsTable.actualTableName: [
                {
                  'id': 'body-1',
                  'logged_at': now.toIso8601String(),
                  'original_weight_value': 80.0,
                  'original_weight_unit': WeightUnit.kilograms.name,
                  'canonical_weight_kilograms': 80.0,
                  'created_at': now.toIso8601String(),
                  'updated_at': now.toIso8601String(),
                },
              ],
            },
          },
        ),
        _remoteBatch(
          installationId: 'forge-local-other',
          domain: SyncDomain.workouts,
          uploadedAt: now,
          payloadJson: {
            'tables': {
              database.exercisesTable.actualTableName: [
                {
                  'id': 'exercise-1',
                  'name': 'Custom Pull',
                  'primary_muscle_group': 'back',
                  'created_at': now.toIso8601String(),
                  'updated_at': now.toIso8601String(),
                },
              ],
              database.workoutTemplatesTable.actualTableName: [
                {
                  'id': 'template-1',
                  'name': 'Pull Day',
                  'created_at': now.toIso8601String(),
                  'updated_at': now.toIso8601String(),
                },
              ],
              database.workoutTemplateItemsTable.actualTableName: [
                {
                  'id': 'template-item-1',
                  'template_id': 'template-1',
                  'exercise_id': 'exercise-1',
                  'order_index': 0,
                  'target_sets': 4,
                  'target_reps': '8-10',
                  'created_at': now.toIso8601String(),
                  'updated_at': now.toIso8601String(),
                },
              ],
            },
          },
        ),
        _remoteBatch(
          installationId: 'forge-local-other',
          domain: SyncDomain.nutrition,
          uploadedAt: now,
          payloadJson: {
            'tables': {
              database.foodsTable.actualTableName: [
                {
                  'id': 'food-1',
                  'name': 'Greek Yogurt',
                  'brand_name': 'Forge',
                  'calories_per100g': 100,
                  'protein_per100g': 10.0,
                  'carbs_per100g': 5.0,
                  'fat_per100g': 0.0,
                  'source': SyncSource.local.name,
                  'is_user_edited': true,
                  'created_at': now.toIso8601String(),
                  'updated_at': now.toIso8601String(),
                },
              ],
              database.savedMealsTable.actualTableName: [
                {
                  'id': 'saved-meal-1',
                  'name': 'Breakfast Bowl',
                  'created_at': now.toIso8601String(),
                  'updated_at': now.toIso8601String(),
                },
              ],
              database.savedMealItemsTable.actualTableName: [
                {
                  'id': 'saved-meal-item-1',
                  'saved_meal_id': 'saved-meal-1',
                  'food_id': 'food-1',
                  'original_quantity_value': 150.0,
                  'original_quantity_unit': FoodQuantityUnit.grams.name,
                  'canonical_quantity_grams': 150.0,
                  'order_index': 0,
                  'created_at': now.toIso8601String(),
                  'updated_at': now.toIso8601String(),
                },
              ],
            },
          },
        ),
        _remoteBatch(
          installationId: 'forge-local-other',
          domain: SyncDomain.settings,
          uploadedAt: now,
          payloadJson: {
            'tables': {
              database.appSettingsTable.actualTableName: [
                {
                  'key': 'theme_mode',
                  'value': 'dark',
                  'updated_at': now.toIso8601String(),
                },
              ],
            },
          },
        ),
      ];

      final firstResult = await repository.importRemoteBackup(
        'forge-local-other',
      );
      final secondResult = await repository.importRemoteBackup(
        'forge-local-other',
      );
      final bodyLogs = await database.select(database.bodyLogsTable).get();
      final exercises = await database.select(database.exercisesTable).get();
      final templates = await database
          .select(database.workoutTemplatesTable)
          .get();
      final savedMeals = await database.select(database.savedMealsTable).get();
      final themeMode = await SettingsRepositoryImpl(
        SettingsDao(database),
      ).getByKey('theme_mode');

      expect(firstResult.importedCount, greaterThan(0));
      expect(secondResult.skippedCount, greaterThan(0));
      expect(bodyLogs, hasLength(1));
      expect(exercises.map((row) => row.name), contains('Custom Pull'));
      expect(templates.map((row) => row.name), contains('Pull Day'));
      expect(savedMeals.map((row) => row.name), contains('Breakfast Bowl'));
      expect(themeMode?.value, 'dark');
    },
  );

  test(
    'getRemoteBackups rejects restore browsing when remote session is gone',
    () async {
      await repository.linkLocalDataToAccount(
        accountId: 'account-1',
        email: 'forge@example.com',
      );
      backupClient.currentSignedInAccountId = null;

      expect(repository.getRemoteBackups(), throwsA(isA<StateError>()));
    },
  );
}

class _FakeCloudBackupClient implements CloudBackupClient {
  List<CloudBackupBatchUpload> uploads = <CloudBackupBatchUpload>[];
  List<CloudBackupBatchRecord> remoteBatches = <CloudBackupBatchRecord>[];
  Set<String> failDomains = <String>{};
  String? currentSignedInAccountId = 'account-1';

  @override
  bool get isConfigured => true;

  @override
  String? get currentAccountId => currentSignedInAccountId;

  @override
  Future<void> uploadBatch(CloudBackupBatchUpload batch) async {
    if (failDomains.contains(batch.domainKey)) {
      throw StateError('Upload failed for ${batch.domainKey}.');
    }
    uploads.add(batch);
  }

  @override
  Future<List<CloudBackupBatchRecord>> listBatches() async {
    if (currentSignedInAccountId == null) {
      throw StateError('Sign in before browsing remote backups.');
    }
    return remoteBatches;
  }
}

CloudBackupBatchRecord _remoteBatch({
  required String installationId,
  required SyncDomain domain,
  required DateTime uploadedAt,
  required Map<String, Object?> payloadJson,
}) {
  return CloudBackupBatchRecord(
    accountId: 'account-1',
    installationId: installationId,
    batchKey: '$installationId:${domain.name}:upsertSnapshot',
    domainKey: domain.name,
    operationKey: 'upsertSnapshot',
    payloadVersion: 1,
    snapshotPreparedAt: uploadedAt,
    uploadedAt: uploadedAt,
    updatedAt: uploadedAt,
    payloadJson: payloadJson,
  );
}
