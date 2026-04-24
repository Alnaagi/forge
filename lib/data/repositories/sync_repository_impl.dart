import 'package:drift/drift.dart';
import 'package:forge/application/services/cloud_backup_client.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/daos/nutrition_dao.dart';
import 'package:forge/data/local/db/daos/sync_queue_dao.dart';
import 'package:forge/data/local/db/mappers/sync_queue_mapper.dart';
import 'package:forge/domain/entities/app_setting.dart';
import 'package:forge/domain/entities/linked_account_state.dart';
import 'package:forge/domain/entities/remote_backup_preview.dart';
import 'package:forge/domain/entities/remote_backup_summary.dart';
import 'package:forge/domain/entities/restore_support_level.dart';
import 'package:forge/domain/entities/sync_import_run_result.dart';
import 'package:forge/domain/entities/sync_queue_item.dart';
import 'package:forge/domain/entities/sync_upload_run_result.dart';
import 'package:forge/domain/repositories/settings_repository.dart';
import 'package:forge/domain/repositories/sync_repository.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/enums/sync_domain.dart';
import 'package:forge/shared/enums/sync_queue_operation.dart';
import 'package:forge/shared/enums/sync_queue_status.dart';
import 'package:forge/shared/enums/sync_source.dart';
import 'package:forge/shared/enums/weight_unit.dart';

const _installationIdKey = 'auth_installation_id';
const _linkedAccountIdKey = 'auth_linked_account_id';
const _linkedAccountEmailKey = 'auth_linked_account_email';
const _linkedAccountAtKey = 'auth_linked_account_at';
const _syncQueuePreparedAtKey = 'sync_queue_prepared_at';
const _syncLastAttemptAtKey = 'sync_last_attempt_at';
const _syncLastSuccessAtKey = 'sync_last_success_at';
const _syncLastErrorKey = 'sync_last_error';
const _safeImportedSettingKeys = <String>{
  'theme_mode',
  'dashboard_section_order',
};

class SyncRepositoryImpl implements SyncRepository {
  static const _uuidService = UuidService();

  const SyncRepositoryImpl({
    required AppDatabase database,
    required SyncQueueDao queueDao,
    required SettingsRepository settingsRepository,
    required CloudBackupClient cloudBackupClient,
  }) : _database = database,
       _queueDao = queueDao,
       _cloudBackupClient = cloudBackupClient,
       _settingsRepository = settingsRepository;

  final AppDatabase _database;
  final SyncQueueDao _queueDao;
  final CloudBackupClient _cloudBackupClient;
  final SettingsRepository _settingsRepository;

  @override
  Future<int> enqueueLocalChanges() async {
    final linkedAccount = await getLinkedAccountState();
    if (linkedAccount == null) {
      return 0;
    }

    final now = DateTime.now();
    for (final domain in SyncDomain.values) {
      await _queueDao.upsert(
        SyncQueueTableCompanion.insert(
          accountId: linkedAccount.accountId,
          domain: domain,
          operation: SyncQueueOperation.upsertSnapshot,
          status: const Value(SyncQueueStatus.pending),
          queuedAt: now,
          updatedAt: now,
          lastAttemptAt: const Value.absent(),
          lastSuccessAt: const Value.absent(),
          lastError: const Value.absent(),
          retryCount: const Value(0),
        ),
      );
    }

    await _saveSetting(_syncQueuePreparedAtKey, now.toUtc().toIso8601String());
    await _saveSetting(_syncLastErrorKey, '');
    final queue = await _queueDao.getQueueForAccount(linkedAccount.accountId);
    return queue.length;
  }

  @override
  Future<String> getOrCreateInstallationId() async {
    final existing = await _settingsRepository.getByKey(_installationIdKey);
    final currentValue = existing?.value.trim() ?? '';
    if (currentValue.isNotEmpty) {
      return currentValue;
    }

    final installationId = 'forge-local-${_uuidService.next()}';
    await _saveSetting(_installationIdKey, installationId);
    return installationId;
  }

  @override
  Future<DateTime?> getLastPreparedAt() async {
    return _readDateTimeSetting(_syncQueuePreparedAtKey);
  }

  @override
  Future<String?> getLastSyncError() async {
    final setting = await _settingsRepository.getByKey(_syncLastErrorKey);
    final value = setting?.value.trim();
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }

  @override
  Future<DateTime?> getLastSyncAttemptAt() {
    return _readDateTimeSetting(_syncLastAttemptAtKey);
  }

  @override
  Future<DateTime?> getLastSyncSuccessAt() {
    return _readDateTimeSetting(_syncLastSuccessAtKey);
  }

  @override
  Future<LinkedAccountState?> getLinkedAccountState() async {
    final installationId = await getOrCreateInstallationId();
    final accountId = (await _settingsRepository.getByKey(
      _linkedAccountIdKey,
    ))?.value.trim();
    if (accountId == null || accountId.isEmpty) {
      return null;
    }

    final linkedAt =
        await _readDateTimeSetting(_linkedAccountAtKey) ?? DateTime.now();
    final email = (await _settingsRepository.getByKey(
      _linkedAccountEmailKey,
    ))?.value.trim();

    return LinkedAccountState(
      installationId: installationId,
      accountId: accountId,
      email: email == null || email.isEmpty ? null : email,
      linkedAt: linkedAt,
    );
  }

  @override
  Future<LinkedAccountState> linkLocalDataToAccount({
    required String accountId,
    String? email,
  }) async {
    final installationId = await getOrCreateInstallationId();
    final linkedAt = DateTime.now();
    await _saveSetting(_linkedAccountIdKey, accountId);
    await _saveSetting(_linkedAccountEmailKey, email?.trim() ?? '');
    await _saveSetting(_linkedAccountAtKey, linkedAt.toUtc().toIso8601String());
    await enqueueLocalChanges();
    return LinkedAccountState(
      installationId: installationId,
      accountId: accountId,
      email: email?.trim().isEmpty ?? true ? null : email?.trim(),
      linkedAt: linkedAt,
    );
  }

  @override
  Future<List<SyncQueueItem>> getPendingQueue() async {
    final linkedAccount = await getLinkedAccountState();
    if (linkedAccount == null) {
      return const [];
    }
    final rows = await _queueDao.getQueueForAccount(linkedAccount.accountId);
    return rows
        .where((row) => row.status == SyncQueueStatus.pending)
        .map((row) => row.toDomain())
        .toList(growable: false);
  }

  @override
  Future<List<SyncQueueItem>> getUploadQueue() async {
    final linkedAccount = await getLinkedAccountState();
    if (linkedAccount == null) {
      return const [];
    }
    final rows = await _queueDao.getUploadQueueForAccount(
      linkedAccount.accountId,
    );
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<SyncUploadRunResult> uploadPendingBatches() async {
    final linkedAccount = await getLinkedAccountState();
    if (linkedAccount == null) {
      throw StateError(
        'Sign in and link this device before uploading backup snapshots.',
      );
    }
    if (!_cloudBackupClient.isConfigured) {
      throw StateError('Cloud backup is not configured in this build yet.');
    }
    final currentAccountId = _cloudBackupClient.currentAccountId;
    if (currentAccountId == null ||
        currentAccountId != linkedAccount.accountId) {
      throw StateError('Sign in again before uploading backup snapshots.');
    }

    final queueRows = await _queueDao.getUploadQueueForAccount(
      linkedAccount.accountId,
    );
    if (queueRows.isEmpty) {
      final completedAt = DateTime.now();
      await _saveSetting(
        _syncLastAttemptAtKey,
        completedAt.toUtc().toIso8601String(),
      );
      await _saveSetting(_syncLastErrorKey, '');
      return SyncUploadRunResult(
        attemptedCount: 0,
        uploadedCount: 0,
        failedCount: 0,
        skippedCount: 0,
        completedAt: completedAt,
      );
    }

    final attemptedAt = DateTime.now();
    await _saveSetting(
      _syncLastAttemptAtKey,
      attemptedAt.toUtc().toIso8601String(),
    );

    var uploadedCount = 0;
    var failedCount = 0;
    String? lastError;

    for (final row in queueRows) {
      final queueItem = row.toDomain();
      await _queueDao.updateStatus(
        accountId: row.accountId,
        domainName: row.domain.name,
        operationName: row.operation.name,
        status: SyncQueueStatus.syncing,
        updatedAt: attemptedAt,
        lastAttemptAt: Value(attemptedAt),
        lastError: const Value(null),
      );

      try {
        final payload = await _buildDomainSnapshotPayload(queueItem.domain);
        final uploadedAt = DateTime.now();
        await _cloudBackupClient.uploadBatch(
          CloudBackupBatchUpload(
            accountId: linkedAccount.accountId,
            installationId: linkedAccount.installationId,
            batchKey:
                '${linkedAccount.installationId}:${queueItem.domain.name}:${queueItem.operation.name}',
            domainKey: queueItem.domain.name,
            operationKey: queueItem.operation.name,
            payloadVersion: 1,
            snapshotPreparedAt: row.queuedAt,
            uploadedAt: uploadedAt,
            payloadJson: payload,
          ),
        );
        uploadedCount += 1;
        await _queueDao.updateStatus(
          accountId: row.accountId,
          domainName: row.domain.name,
          operationName: row.operation.name,
          status: SyncQueueStatus.synced,
          updatedAt: uploadedAt,
          lastAttemptAt: Value(uploadedAt),
          lastSuccessAt: Value(uploadedAt),
          lastError: const Value(null),
        );
      } catch (error) {
        failedCount += 1;
        lastError = error.toString();
        final failedAt = DateTime.now();
        await _queueDao.updateStatus(
          accountId: row.accountId,
          domainName: row.domain.name,
          operationName: row.operation.name,
          status: SyncQueueStatus.failed,
          updatedAt: failedAt,
          lastAttemptAt: Value(failedAt),
          lastError: Value(lastError),
          retryCount: Value(row.retryCount + 1),
        );
      }
    }

    final completedAt = DateTime.now();
    if (uploadedCount > 0) {
      await _saveSetting(
        _syncLastSuccessAtKey,
        completedAt.toUtc().toIso8601String(),
      );
    }
    await _saveSetting(_syncLastErrorKey, lastError ?? '');

    return SyncUploadRunResult(
      attemptedCount: queueRows.length,
      uploadedCount: uploadedCount,
      failedCount: failedCount,
      skippedCount: 0,
      lastError: lastError,
      completedAt: completedAt,
    );
  }

  @override
  Future<List<RemoteBackupSummary>> getRemoteBackups() async {
    final rows = await _getRemoteBackupRows();
    final localInstallationId = await getOrCreateInstallationId();
    final grouped = <String, List<CloudBackupBatchRecord>>{};
    for (final row in rows) {
      grouped.putIfAbsent(row.installationId, () => []).add(row);
    }

    final summaries = grouped.entries
        .map(
          (entry) =>
              _buildRemoteBackupSummary(entry.value, localInstallationId),
        )
        .toList(growable: false);
    summaries.sort(
      (left, right) => right.lastUpdatedAt.compareTo(left.lastUpdatedAt),
    );
    return summaries;
  }

  @override
  Future<RemoteBackupPreview> getRemoteBackupPreview(
    String installationId,
  ) async {
    final rows = await _getInstallationBackupRows(installationId);
    final localInstallationId = await getOrCreateInstallationId();
    final summary = _buildRemoteBackupSummary(rows, localInstallationId);
    final domains =
        rows.map(_buildRemoteBackupDomainPreview).toList(growable: false)..sort(
          (left, right) => SyncDomain.values
              .indexOf(left.domain)
              .compareTo(SyncDomain.values.indexOf(right.domain)),
        );

    return RemoteBackupPreview(
      backup: summary,
      domains: domains,
      notice:
          'Import is manual and additive. Forge will only import the safest supported data from this backup, preserve existing local data, and skip duplicates where it can detect them safely.',
    );
  }

  @override
  Future<SyncImportRunResult> importRemoteBackup(String installationId) async {
    final rows = await _getInstallationBackupRows(installationId);
    final domainResults = <SyncDomainImportResult>[];

    for (final row in rows) {
      final domain = _tryParseSyncDomain(row.domainKey);
      if (domain == null) {
        continue;
      }

      final preview = _buildRemoteBackupDomainPreview(row);
      if (!preview.canImport) {
        domainResults.add(
          SyncDomainImportResult(
            domain: domain,
            importedCount: 0,
            skippedCount: preview.availableRecordCount,
            summary: preview.summary,
          ),
        );
        continue;
      }

      final result = switch (domain) {
        SyncDomain.bodyProgress => await _importBodyProgress(row),
        SyncDomain.workouts => await _importWorkoutAssets(row),
        SyncDomain.nutrition => await _importSavedMealAssets(row),
        SyncDomain.settings => await _importSafeSettings(row),
        _ => SyncDomainImportResult(
          domain: domain,
          importedCount: 0,
          skippedCount: preview.availableRecordCount,
          summary: preview.summary,
        ),
      };
      domainResults.add(result);
    }

    return SyncImportRunResult(
      domainResults: domainResults,
      completedAt: DateTime.now(),
    );
  }

  Future<DateTime?> _readDateTimeSetting(String key) async {
    final setting = await _settingsRepository.getByKey(key);
    final raw = setting?.value.trim() ?? '';
    if (raw.isEmpty) {
      return null;
    }
    return DateTime.tryParse(raw);
  }

  Future<void> _saveSetting(String key, String value) {
    return _settingsRepository.save(
      AppSetting(key: key, value: value, updatedAt: DateTime.now()),
    );
  }

  Future<List<CloudBackupBatchRecord>> _getRemoteBackupRows() async {
    if (!_cloudBackupClient.isConfigured) {
      throw StateError('Cloud backup is not configured in this build yet.');
    }
    final accountId = _cloudBackupClient.currentAccountId;
    if (accountId == null || accountId.isEmpty) {
      throw StateError('Sign in before browsing cloud backups.');
    }
    return _cloudBackupClient.listBatches();
  }

  Future<List<CloudBackupBatchRecord>> _getInstallationBackupRows(
    String installationId,
  ) async {
    final rows = await _getRemoteBackupRows();
    final matches = rows
        .where((row) => row.installationId == installationId)
        .toList(growable: false);
    if (matches.isEmpty) {
      throw StateError('No remote backup batches were found for this device.');
    }
    return matches;
  }

  RemoteBackupSummary _buildRemoteBackupSummary(
    List<CloudBackupBatchRecord> rows,
    String localInstallationId,
  ) {
    final first = rows.first;
    final domains =
        rows
            .map((row) => _tryParseSyncDomain(row.domainKey))
            .whereType<SyncDomain>()
            .toSet()
            .toList(growable: false)
          ..sort(
            (left, right) => SyncDomain.values
                .indexOf(left)
                .compareTo(SyncDomain.values.indexOf(right)),
          );
    final lastUploadedAt = rows
        .map((row) => row.uploadedAt)
        .reduce((left, right) => left.isAfter(right) ? left : right);
    final lastUpdatedAt = rows
        .map((row) => row.updatedAt)
        .reduce((left, right) => left.isAfter(right) ? left : right);
    final payloadVersion = rows
        .map((row) => row.payloadVersion)
        .reduce((left, right) => left > right ? left : right);

    return RemoteBackupSummary(
      installationId: first.installationId,
      isCurrentDevice: first.installationId == localInstallationId,
      lastUploadedAt: lastUploadedAt,
      lastUpdatedAt: lastUpdatedAt,
      availableDomains: domains,
      payloadVersion: payloadVersion,
    );
  }

  RemoteBackupDomainPreview _buildRemoteBackupDomainPreview(
    CloudBackupBatchRecord row,
  ) {
    final domain = _tryParseSyncDomain(row.domainKey);
    final tableRows = _readAllTableRows(row);
    final availableCount = tableRows.values.fold<int>(
      0,
      (sum, rows) => sum + rows.length,
    );
    if (domain == null) {
      return const RemoteBackupDomainPreview(
        domain: SyncDomain.settings,
        supportLevel: RestoreSupportLevel.deferred,
        availableRecordCount: 0,
        importableRecordCount: 0,
        summary:
            'This backup contains an unknown domain that Forge does not import yet.',
      );
    }
    if (row.payloadVersion != 1) {
      return RemoteBackupDomainPreview(
        domain: domain,
        supportLevel: RestoreSupportLevel.deferred,
        availableRecordCount: availableCount,
        importableRecordCount: 0,
        summary:
            'Payload version ${row.payloadVersion} is newer than the current importer supports.',
      );
    }

    switch (domain) {
      case SyncDomain.bodyProgress:
        final bodyLogCount = _tableRows(
          row,
          _database.bodyLogsTable.actualTableName,
        ).length;
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.supported,
          availableRecordCount: bodyLogCount,
          importableRecordCount: bodyLogCount,
          summary:
              'Imports body logs additively and skips any check-ins Forge can already match locally.',
        );
      case SyncDomain.workouts:
        final exerciseCount = _tableRows(
          row,
          _database.exercisesTable.actualTableName,
        ).length;
        final templateCount = _tableRows(
          row,
          _database.workoutTemplatesTable.actualTableName,
        ).length;
        final sessionCount = _tableRows(
          row,
          _database.workoutSessionsTable.actualTableName,
        ).length;
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.partial,
          availableRecordCount: exerciseCount + templateCount + sessionCount,
          importableRecordCount: exerciseCount + templateCount,
          summary:
              'Imports custom exercises and workout templates only. Session history, logged exercises, and set logs stay deferred.',
        );
      case SyncDomain.nutrition:
        final savedMealCount = _tableRows(
          row,
          _database.savedMealsTable.actualTableName,
        ).length;
        final savedMealItemRows = _tableRows(
          row,
          _database.savedMealItemsTable.actualTableName,
        );
        final referencedFoodIds = savedMealItemRows
            .map((item) => _asString(item['food_id']))
            .whereType<String>()
            .toSet();
        final mealEntryCount = _tableRows(
          row,
          _database.mealEntriesTable.actualTableName,
        ).length;
        final hydrationCount = _tableRows(
          row,
          _database.hydrationLogsTable.actualTableName,
        ).length;
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.partial,
          availableRecordCount:
              savedMealCount +
              referencedFoodIds.length +
              mealEntryCount +
              hydrationCount,
          importableRecordCount: savedMealCount + referencedFoodIds.length,
          summary:
              'Imports saved meals and the foods they depend on. Logged meals and hydration history stay deferred.',
        );
      case SyncDomain.settings:
        final safeSettingCount =
            _tableRows(row, _database.appSettingsTable.actualTableName).where((
              setting,
            ) {
              final key = _asString(setting['key']);
              return key != null && _safeImportedSettingKeys.contains(key);
            }).length;
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.partial,
          availableRecordCount: availableCount,
          importableRecordCount: safeSettingCount,
          summary:
              'Imports only missing appearance and dashboard layout settings. Existing local settings are never overwritten automatically.',
        );
      case SyncDomain.profile:
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.deferred,
          availableRecordCount: availableCount,
          importableRecordCount: 0,
          summary:
              'Profile import is deferred because replacing identity and unit preferences needs a more careful merge design.',
        );
      case SyncDomain.goals:
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.deferred,
          availableRecordCount: availableCount,
          importableRecordCount: 0,
          summary:
              'Goal import is deferred until Forge can preview and reconcile competing active goals safely.',
        );
      case SyncDomain.health:
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.deferred,
          availableRecordCount: availableCount,
          importableRecordCount: 0,
          summary:
              'Health history stays deferred for now because symptom timelines and imported-device records need stricter provenance controls.',
        );
      case SyncDomain.reminders:
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.deferred,
          availableRecordCount: availableCount,
          importableRecordCount: 0,
          summary:
              'Reminders stay deferred because device delivery state should not be imported blindly across installs.',
        );
      case SyncDomain.insights:
        return RemoteBackupDomainPreview(
          domain: domain,
          supportLevel: RestoreSupportLevel.deferred,
          availableRecordCount: availableCount,
          importableRecordCount: 0,
          summary:
              'Insight history stays deferred because it should be regenerated from local data instead of imported as authoritative state.',
        );
    }
  }

  Future<Map<String, Object?>> _buildDomainSnapshotPayload(
    SyncDomain domain,
  ) async {
    final generatedAt = DateTime.now().toUtc();
    return {
      'domain': domain.name,
      'generated_at': generatedAt.toIso8601String(),
      'tables': switch (domain) {
        SyncDomain.profile => {
          _database.usersTable.actualTableName: await _dumpTable(
            _database.usersTable.actualTableName,
          ),
        },
        SyncDomain.goals => {
          _database.goalsTable.actualTableName: await _dumpTable(
            _database.goalsTable.actualTableName,
          ),
        },
        SyncDomain.workouts => {
          _database.exercisesTable.actualTableName:
              await _dumpCustomExercises(),
          _database.workoutTemplatesTable.actualTableName: await _dumpTable(
            _database.workoutTemplatesTable.actualTableName,
          ),
          _database.workoutTemplateItemsTable.actualTableName: await _dumpTable(
            _database.workoutTemplateItemsTable.actualTableName,
          ),
          _database.workoutSessionsTable.actualTableName: await _dumpTable(
            _database.workoutSessionsTable.actualTableName,
          ),
          _database.workoutExerciseEntriesTable.actualTableName:
              await _dumpTable(
                _database.workoutExerciseEntriesTable.actualTableName,
              ),
          _database.setEntriesTable.actualTableName: await _dumpTable(
            _database.setEntriesTable.actualTableName,
          ),
        },
        SyncDomain.nutrition => {
          _database.foodsTable.actualTableName: await _dumpTable(
            _database.foodsTable.actualTableName,
          ),
          _database.foodPortionsTable.actualTableName: await _dumpTable(
            _database.foodPortionsTable.actualTableName,
          ),
          _database.mealEntriesTable.actualTableName: await _dumpTable(
            _database.mealEntriesTable.actualTableName,
          ),
          _database.hydrationLogsTable.actualTableName: await _dumpTable(
            _database.hydrationLogsTable.actualTableName,
          ),
          _database.savedMealsTable.actualTableName: await _dumpTable(
            _database.savedMealsTable.actualTableName,
          ),
          _database.savedMealItemsTable.actualTableName: await _dumpTable(
            _database.savedMealItemsTable.actualTableName,
          ),
        },
        SyncDomain.bodyProgress => {
          _database.bodyLogsTable.actualTableName: await _dumpTable(
            _database.bodyLogsTable.actualTableName,
          ),
        },
        SyncDomain.health => {
          _database.healthProfilesTable.actualTableName: await _dumpTable(
            _database.healthProfilesTable.actualTableName,
          ),
          _database.healthStatusLogsTable.actualTableName: await _dumpTable(
            _database.healthStatusLogsTable.actualTableName,
          ),
        },
        SyncDomain.reminders => {
          _database.remindersTable.actualTableName: await _dumpTable(
            _database.remindersTable.actualTableName,
          ),
        },
        SyncDomain.insights => {
          _database.insightsTable.actualTableName: await _dumpTable(
            _database.insightsTable.actualTableName,
          ),
        },
        SyncDomain.settings => {
          _database.appSettingsTable.actualTableName:
              await _dumpFilteredSettings(),
        },
      },
    };
  }

  Future<SyncDomainImportResult> _importBodyProgress(
    CloudBackupBatchRecord row,
  ) async {
    final bodyLogRows = _tableRows(
      row,
      _database.bodyLogsTable.actualTableName,
    );
    if (bodyLogRows.isEmpty) {
      return const SyncDomainImportResult(
        domain: SyncDomain.bodyProgress,
        importedCount: 0,
        skippedCount: 0,
        summary: 'No body logs were available in this backup.',
      );
    }

    final existingLogs = await _database.select(_database.bodyLogsTable).get();
    final seenSignatures = {
      for (final log in existingLogs) _bodyLogSignatureFromLocalRow(log),
    };
    var imported = 0;
    var skipped = 0;

    for (final record in bodyLogRows) {
      final signature = _bodyLogSignatureFromBackupRow(record);
      if (signature == null || seenSignatures.contains(signature)) {
        skipped += 1;
        continue;
      }

      final loggedAt = _asDateTime(record['logged_at']);
      if (loggedAt == null) {
        skipped += 1;
        continue;
      }

      final originalWeightValue = _asDouble(record['original_weight_value']);
      final originalWeightUnit = _asEnum(
        WeightUnit.values,
        _asString(record['original_weight_unit']),
      );
      final canonicalWeightKilograms = _asDouble(
        record['canonical_weight_kilograms'],
      );
      final originalWaistValue = _asDouble(record['original_waist_value']);
      final originalWaistUnit = _asEnum(
        BodyMetricUnit.values,
        _asString(record['original_waist_unit']),
      );
      final canonicalWaistCentimeters = _asDouble(
        record['canonical_waist_centimeters'],
      );

      await _database
          .into(_database.bodyLogsTable)
          .insert(
            BodyLogsTableCompanion.insert(
              id: 'body-log-import-${_uuidService.next()}',
              loggedAt: loggedAt,
              originalWeightValue: Value(originalWeightValue),
              originalWeightUnit: Value(originalWeightUnit),
              canonicalWeightKilograms: Value(canonicalWeightKilograms),
              bodyFatPercentage: Value(
                _asDouble(record['body_fat_percentage']),
              ),
              originalWaistValue: Value(originalWaistValue),
              originalWaistUnit: Value(originalWaistUnit),
              canonicalWaistCentimeters: Value(canonicalWaistCentimeters),
              notes: Value(_asString(record['notes'])),
              createdAt: _asDateTime(record['created_at']) ?? DateTime.now(),
              updatedAt: _asDateTime(record['updated_at']) ?? DateTime.now(),
            ),
          );
      seenSignatures.add(signature);
      imported += 1;
    }

    return SyncDomainImportResult(
      domain: SyncDomain.bodyProgress,
      importedCount: imported,
      skippedCount: skipped,
      summary:
          'Imported $imported body log${imported == 1 ? '' : 's'} and skipped $skipped duplicate or invalid check-in${skipped == 1 ? '' : 's'}.',
    );
  }

  Future<SyncDomainImportResult> _importWorkoutAssets(
    CloudBackupBatchRecord row,
  ) async {
    final exerciseRows = _tableRows(
      row,
      _database.exercisesTable.actualTableName,
    );
    final templateRows = _tableRows(
      row,
      _database.workoutTemplatesTable.actualTableName,
    );
    final templateItemRows = _tableRows(
      row,
      _database.workoutTemplateItemsTable.actualTableName,
    );
    if (exerciseRows.isEmpty && templateRows.isEmpty) {
      return const SyncDomainImportResult(
        domain: SyncDomain.workouts,
        importedCount: 0,
        skippedCount: 0,
        summary: 'No importable workout assets were available in this backup.',
      );
    }

    final localExercises = await _database
        .select(_database.exercisesTable)
        .get();
    final localTemplates = await _database
        .select(_database.workoutTemplatesTable)
        .get();
    final exerciseIdByName = {
      for (final exercise in localExercises)
        _normalizeKey(exercise.name): exercise.id,
    };
    final templateNames = {
      for (final template in localTemplates) _normalizeKey(template.name),
    };
    final remoteExerciseToLocalId = <String, String>{};
    var importedExercises = 0;
    var skippedExercises = 0;

    for (final record in exerciseRows) {
      final remoteId = _asString(record['id']);
      final name = _asString(record['name']);
      final primaryMuscleGroup = _asString(record['primary_muscle_group']);
      if (remoteId == null ||
          name == null ||
          name.trim().isEmpty ||
          primaryMuscleGroup == null ||
          primaryMuscleGroup.trim().isEmpty) {
        skippedExercises += 1;
        continue;
      }

      final normalizedName = _normalizeKey(name);
      final existingId = exerciseIdByName[normalizedName];
      if (existingId != null) {
        remoteExerciseToLocalId[remoteId] = existingId;
        skippedExercises += 1;
        continue;
      }

      final newId = 'exercise-import-${_uuidService.next()}';
      await _database
          .into(_database.exercisesTable)
          .insert(
            ExercisesTableCompanion.insert(
              id: newId,
              name: name.trim(),
              primaryMuscleGroup: primaryMuscleGroup.trim(),
              isBuiltIn: const Value(false),
              notes: Value(_asString(record['notes'])),
              createdAt: _asDateTime(record['created_at']) ?? DateTime.now(),
              updatedAt: _asDateTime(record['updated_at']) ?? DateTime.now(),
            ),
          );
      exerciseIdByName[normalizedName] = newId;
      remoteExerciseToLocalId[remoteId] = newId;
      importedExercises += 1;
    }

    final itemsByTemplateId = <String, List<Map<String, Object?>>>{};
    for (final item in templateItemRows) {
      final templateId = _asString(item['template_id']);
      if (templateId == null) {
        continue;
      }
      itemsByTemplateId.putIfAbsent(templateId, () => []).add(item);
    }

    for (final items in itemsByTemplateId.values) {
      items.sort(
        (left, right) => (_asInt(left['order_index']) ?? 0).compareTo(
          _asInt(right['order_index']) ?? 0,
        ),
      );
    }

    var importedTemplates = 0;
    var skippedTemplates = 0;
    for (final record in templateRows) {
      final remoteTemplateId = _asString(record['id']);
      final name = _asString(record['name']);
      if (remoteTemplateId == null || name == null || name.trim().isEmpty) {
        skippedTemplates += 1;
        continue;
      }
      final normalizedName = _normalizeKey(name);
      if (templateNames.contains(normalizedName)) {
        skippedTemplates += 1;
        continue;
      }

      final remoteItems = itemsByTemplateId[remoteTemplateId] ?? const [];
      final importedItems = <WorkoutTemplateItemsTableCompanion>[];
      for (final item in remoteItems) {
        final remoteExerciseId = _asString(item['exercise_id']);
        final localExerciseId = remoteExerciseId == null
            ? null
            : remoteExerciseToLocalId[remoteExerciseId];
        if (localExerciseId == null) {
          continue;
        }
        importedItems.add(
          WorkoutTemplateItemsTableCompanion.insert(
            id: 'template-item-import-${_uuidService.next()}',
            templateId: 'template-import-pending',
            exerciseId: localExerciseId,
            orderIndex: _asInt(item['order_index']) ?? importedItems.length,
            targetSets: _asInt(item['target_sets']) ?? 3,
            targetReps: _asString(item['target_reps']) ?? '8-12',
            notes: Value(_asString(item['notes'])),
            createdAt: _asDateTime(item['created_at']) ?? DateTime.now(),
            updatedAt: _asDateTime(item['updated_at']) ?? DateTime.now(),
          ),
        );
      }
      if (importedItems.isEmpty) {
        skippedTemplates += 1;
        continue;
      }

      final newTemplateId = 'template-import-${_uuidService.next()}';
      await _database
          .into(_database.workoutTemplatesTable)
          .insert(
            WorkoutTemplatesTableCompanion.insert(
              id: newTemplateId,
              name: name.trim(),
              notes: Value(_asString(record['notes'])),
              createdAt: _asDateTime(record['created_at']) ?? DateTime.now(),
              updatedAt: _asDateTime(record['updated_at']) ?? DateTime.now(),
            ),
          );
      for (final item in importedItems) {
        await _database
            .into(_database.workoutTemplateItemsTable)
            .insert(item.copyWith(templateId: Value(newTemplateId)));
      }
      templateNames.add(normalizedName);
      importedTemplates += 1;
    }

    return SyncDomainImportResult(
      domain: SyncDomain.workouts,
      importedCount: importedExercises + importedTemplates,
      skippedCount: skippedExercises + skippedTemplates,
      summary:
          'Imported $importedExercises custom exercise${importedExercises == 1 ? '' : 's'} and $importedTemplates workout template${importedTemplates == 1 ? '' : 's'}. Skipped $skippedExercises duplicate exercise${skippedExercises == 1 ? '' : 's'} and $skippedTemplates template${skippedTemplates == 1 ? '' : 's'} that Forge could not import safely.',
    );
  }

  Future<SyncDomainImportResult> _importSavedMealAssets(
    CloudBackupBatchRecord row,
  ) async {
    final savedMealRows = _tableRows(
      row,
      _database.savedMealsTable.actualTableName,
    );
    final savedMealItemRows = _tableRows(
      row,
      _database.savedMealItemsTable.actualTableName,
    );
    final foodRows = _tableRows(row, _database.foodsTable.actualTableName);
    final foodPortionRows = _tableRows(
      row,
      _database.foodPortionsTable.actualTableName,
    );
    if (savedMealRows.isEmpty) {
      return const SyncDomainImportResult(
        domain: SyncDomain.nutrition,
        importedCount: 0,
        skippedCount: 0,
        summary: 'No saved meals were available in this backup.',
      );
    }

    final localFoods = await _database.select(_database.foodsTable).get();
    final barcodeToFoodId = <String, String>{
      for (final food in localFoods)
        if ((food.barcode ?? '').trim().isNotEmpty)
          food.barcode!.trim(): food.id,
    };
    final nameBrandToFoodId = <String, String>{
      for (final food in localFoods)
        _foodNameBrandKey(food.name, food.brandName): food.id,
    };
    final portionRowsByFoodId = <String, List<Map<String, Object?>>>{};
    for (final portion in foodPortionRows) {
      final foodId = _asString(portion['food_id']);
      if (foodId == null) {
        continue;
      }
      portionRowsByFoodId.putIfAbsent(foodId, () => []).add(portion);
    }

    final savedMealItemsByMealId = <String, List<Map<String, Object?>>>{};
    for (final item in savedMealItemRows) {
      final savedMealId = _asString(item['saved_meal_id']);
      if (savedMealId == null) {
        continue;
      }
      savedMealItemsByMealId.putIfAbsent(savedMealId, () => []).add(item);
    }
    for (final items in savedMealItemsByMealId.values) {
      items.sort(
        (left, right) => (_asInt(left['order_index']) ?? 0).compareTo(
          _asInt(right['order_index']) ?? 0,
        ),
      );
    }

    final referencedFoodIds = savedMealItemRows
        .map((row) => _asString(row['food_id']))
        .whereType<String>()
        .toSet();
    final remoteFoodRowsById = {
      for (final food in foodRows)
        if (_asString(food['id']) case final id?) id: food,
    };
    final remoteFoodToLocalId = <String, String>{};
    var importedFoods = 0;
    var skippedFoods = 0;

    for (final remoteFoodId in referencedFoodIds) {
      final record = remoteFoodRowsById[remoteFoodId];
      if (record == null) {
        continue;
      }
      final barcode = _asString(record['barcode']);
      final name = _asString(record['name']);
      if (name == null || name.trim().isEmpty) {
        skippedFoods += 1;
        continue;
      }

      final existingId =
          (barcode != null && barcodeToFoodId.containsKey(barcode))
          ? barcodeToFoodId[barcode]
          : nameBrandToFoodId[_foodNameBrandKey(
              name,
              _asString(record['brand_name']),
            )];
      if (existingId != null) {
        remoteFoodToLocalId[remoteFoodId] = existingId;
        skippedFoods += 1;
        continue;
      }

      final newFoodId = 'food-import-${_uuidService.next()}';
      final source = _asEnum(SyncSource.values, _asString(record['source']));
      await _database
          .into(_database.foodsTable)
          .insert(
            FoodsTableCompanion.insert(
              id: newFoodId,
              name: name.trim(),
              brandName: Value(_asString(record['brand_name'])),
              barcode: Value(barcode),
              caloriesPer100g: _asInt(record['calories_per100g']) ?? 0,
              proteinPer100g: _asDouble(record['protein_per100g']) ?? 0,
              carbsPer100g: _asDouble(record['carbs_per100g']) ?? 0,
              fatPer100g: _asDouble(record['fat_per100g']) ?? 0,
              source: source ?? SyncSource.local,
              isUserEdited: Value(_asBool(record['is_user_edited']) ?? false),
              createdAt: _asDateTime(record['created_at']) ?? DateTime.now(),
              updatedAt: _asDateTime(record['updated_at']) ?? DateTime.now(),
            ),
          );
      final remotePortions = portionRowsByFoodId[remoteFoodId] ?? const [];
      for (var index = 0; index < remotePortions.length; index += 1) {
        final portion = remotePortions[index];
        final unit = _asEnum(
          FoodQuantityUnit.values,
          _asString(portion['unit']),
        );
        if (unit == null) {
          continue;
        }
        await _database
            .into(_database.foodPortionsTable)
            .insert(
              FoodPortionsTableCompanion.insert(
                id: 'food-portion-import-${_uuidService.next()}',
                foodId: newFoodId,
                unit: unit,
                label: _asString(portion['label']) ?? unit.symbol,
                referenceAmount: _asDouble(portion['reference_amount']) ?? 1,
                canonicalGrams: Value(_asDouble(portion['canonical_grams'])),
                canonicalMilliliters: Value(
                  _asDouble(portion['canonical_milliliters']),
                ),
                sortOrder: index,
                createdAt: _asDateTime(portion['created_at']) ?? DateTime.now(),
                updatedAt: _asDateTime(portion['updated_at']) ?? DateTime.now(),
              ),
            );
      }

      remoteFoodToLocalId[remoteFoodId] = newFoodId;
      if (barcode != null && barcode.isNotEmpty) {
        barcodeToFoodId[barcode] = newFoodId;
      }
      nameBrandToFoodId[_foodNameBrandKey(
            name,
            _asString(record['brand_name']),
          )] =
          newFoodId;
      importedFoods += 1;
    }

    final existingSignatures = await _loadSavedMealSignatures();
    var importedMeals = 0;
    var skippedMeals = 0;

    for (final meal in savedMealRows) {
      final remoteMealId = _asString(meal['id']);
      final name = _asString(meal['name']);
      if (remoteMealId == null || name == null || name.trim().isEmpty) {
        skippedMeals += 1;
        continue;
      }
      final remoteItems = savedMealItemsByMealId[remoteMealId] ?? const [];
      final importedItems = <_ImportedSavedMealItem>[];
      for (final item in remoteItems) {
        final remoteFoodId = _asString(item['food_id']);
        final localFoodId = remoteFoodId == null
            ? null
            : remoteFoodToLocalId[remoteFoodId];
        final unit = _asEnum(
          FoodQuantityUnit.values,
          _asString(item['original_quantity_unit']),
        );
        final quantityValue = _asDouble(item['original_quantity_value']);
        if (localFoodId == null || unit == null || quantityValue == null) {
          continue;
        }
        importedItems.add(
          _ImportedSavedMealItem(
            foodId: localFoodId,
            originalValue: quantityValue,
            originalUnit: unit,
            canonicalGrams: _asDouble(item['canonical_quantity_grams']),
            canonicalMilliliters: _asDouble(
              item['canonical_quantity_milliliters'],
            ),
            notes: _asString(item['notes']),
            createdAt: _asDateTime(item['created_at']) ?? DateTime.now(),
            updatedAt: _asDateTime(item['updated_at']) ?? DateTime.now(),
          ),
        );
      }
      if (importedItems.isEmpty) {
        skippedMeals += 1;
        continue;
      }

      final signature = _savedMealSignature(name, importedItems);
      if (existingSignatures.contains(signature)) {
        skippedMeals += 1;
        continue;
      }

      final newMealId = 'saved-meal-import-${_uuidService.next()}';
      await _database
          .into(_database.savedMealsTable)
          .insert(
            SavedMealsTableCompanion.insert(
              id: newMealId,
              name: name.trim(),
              notes: Value(_asString(meal['notes'])),
              createdAt: _asDateTime(meal['created_at']) ?? DateTime.now(),
              updatedAt: _asDateTime(meal['updated_at']) ?? DateTime.now(),
            ),
          );
      for (var index = 0; index < importedItems.length; index += 1) {
        final item = importedItems[index];
        await _database
            .into(_database.savedMealItemsTable)
            .insert(
              SavedMealItemsTableCompanion.insert(
                id: 'saved-meal-item-import-${_uuidService.next()}',
                savedMealId: newMealId,
                foodId: item.foodId,
                originalQuantityValue: item.originalValue,
                originalQuantityUnit: item.originalUnit,
                canonicalQuantityGrams: Value(item.canonicalGrams),
                canonicalQuantityMilliliters: Value(item.canonicalMilliliters),
                orderIndex: index,
                notes: Value(item.notes),
                createdAt: item.createdAt,
                updatedAt: item.updatedAt,
              ),
            );
      }
      existingSignatures.add(signature);
      importedMeals += 1;
    }

    return SyncDomainImportResult(
      domain: SyncDomain.nutrition,
      importedCount: importedFoods + importedMeals,
      skippedCount: skippedFoods + skippedMeals,
      summary:
          'Imported $importedFoods referenced food${importedFoods == 1 ? '' : 's'} and $importedMeals saved meal${importedMeals == 1 ? '' : 's'}. Logged meals and hydration history were intentionally left alone.',
    );
  }

  Future<SyncDomainImportResult> _importSafeSettings(
    CloudBackupBatchRecord row,
  ) async {
    final settingRows =
        _tableRows(row, _database.appSettingsTable.actualTableName)
            .where((record) {
              final key = _asString(record['key']);
              return key != null && _safeImportedSettingKeys.contains(key);
            })
            .toList(growable: false);
    if (settingRows.isEmpty) {
      return const SyncDomainImportResult(
        domain: SyncDomain.settings,
        importedCount: 0,
        skippedCount: 0,
        summary: 'No supported settings were available to import.',
      );
    }

    var imported = 0;
    var skipped = 0;
    for (final record in settingRows) {
      final key = _asString(record['key']);
      final value = _asString(record['value']);
      if (key == null || value == null) {
        skipped += 1;
        continue;
      }
      final existing = await _settingsRepository.getByKey(key);
      if (existing != null && existing.value.trim().isNotEmpty) {
        skipped += 1;
        continue;
      }
      await _settingsRepository.save(
        AppSetting(
          key: key,
          value: value,
          updatedAt: _asDateTime(record['updated_at']) ?? DateTime.now(),
        ),
      );
      imported += 1;
    }

    return SyncDomainImportResult(
      domain: SyncDomain.settings,
      importedCount: imported,
      skippedCount: skipped,
      summary:
          'Imported $imported safe setting${imported == 1 ? '' : 's'} and left $skipped existing local setting${skipped == 1 ? '' : 's'} untouched.',
    );
  }

  Future<List<Map<String, Object?>>> _dumpFilteredSettings() async {
    final rows = await _dumpTable(_database.appSettingsTable.actualTableName);
    return rows
        .where((row) {
          final key = (row['key'] ?? '').toString();
          return !key.startsWith('auth_') &&
              !key.startsWith('sync_') &&
              !key.startsWith('health_connect_');
        })
        .toList(growable: false);
  }

  Future<List<Map<String, Object?>>> _dumpCustomExercises() async {
    final tableName = _database.exercisesTable.actualTableName;
    final rows = await _database
        .customSelect('SELECT * FROM $tableName WHERE is_built_in = 0')
        .get();
    return rows
        .map((row) => _sanitizeMap(Map<String, Object?>.from(row.data)))
        .toList(growable: false);
  }

  Future<List<Map<String, Object?>>> _dumpTable(String tableName) async {
    final rows = await _database.customSelect('SELECT * FROM $tableName').get();
    return rows
        .map((row) => _sanitizeMap(Map<String, Object?>.from(row.data)))
        .toList(growable: false);
  }

  Future<Set<String>> _loadSavedMealSignatures() async {
    final rows = await NutritionDao(_database).getSavedMealDetailRows();
    final mealsById = <String, _ExistingSavedMealAccumulator>{};
    for (final row in rows) {
      final accumulator = mealsById.putIfAbsent(
        row.savedMeal.id,
        () => _ExistingSavedMealAccumulator(name: row.savedMeal.name),
      );
      final item = row.item;
      if (item != null) {
        accumulator.items.add(
          _ImportedSavedMealItem(
            foodId: item.foodId,
            originalValue: item.originalQuantityValue,
            originalUnit: item.originalQuantityUnit,
            canonicalGrams: item.canonicalQuantityGrams,
            canonicalMilliliters: item.canonicalQuantityMilliliters,
            notes: item.notes,
            createdAt: item.createdAt,
            updatedAt: item.updatedAt,
          ),
        );
      }
    }

    return mealsById.values
        .map((meal) => _savedMealSignature(meal.name, meal.items))
        .toSet();
  }

  String? _bodyLogSignatureFromBackupRow(Map<String, Object?> row) {
    final loggedAt = _asDateTime(row['logged_at']);
    if (loggedAt == null) {
      return null;
    }
    final weight = _formatDouble(_asDouble(row['canonical_weight_kilograms']));
    final bodyFat = _formatDouble(_asDouble(row['body_fat_percentage']));
    final waist = _formatDouble(_asDouble(row['canonical_waist_centimeters']));
    if (weight == null && bodyFat == null && waist == null) {
      return null;
    }
    return '${loggedAt.toUtc().millisecondsSinceEpoch}|$weight|$bodyFat|$waist';
  }

  String? _bodyLogSignatureFromLocalRow(BodyLogsTableData row) {
    final weight = _formatDouble(row.canonicalWeightKilograms);
    final bodyFat = _formatDouble(row.bodyFatPercentage);
    final waist = _formatDouble(row.canonicalWaistCentimeters);
    if (weight == null && bodyFat == null && waist == null) {
      return null;
    }
    return '${row.loggedAt.toUtc().millisecondsSinceEpoch}|$weight|$bodyFat|$waist';
  }

  String _savedMealSignature(String name, List<_ImportedSavedMealItem> items) {
    final normalizedItems = items
        .map(
          (item) =>
              '${item.foodId}|${_formatDouble(item.originalValue)}|${item.originalUnit.name}|${_formatDouble(item.canonicalGrams)}|${_formatDouble(item.canonicalMilliliters)}|${(item.notes ?? '').trim().toLowerCase()}',
        )
        .join('||');
    return '${_normalizeKey(name)}::$normalizedItems';
  }

  Map<String, List<Map<String, Object?>>> _readAllTableRows(
    CloudBackupBatchRecord row,
  ) {
    final rawTables = row.payloadJson['tables'];
    if (rawTables is! Map) {
      return const <String, List<Map<String, Object?>>>{};
    }
    final tables = <String, List<Map<String, Object?>>>{};
    for (final entry in rawTables.entries) {
      tables[entry.key.toString()] = _toTableRowList(entry.value);
    }
    return tables;
  }

  List<Map<String, Object?>> _tableRows(
    CloudBackupBatchRecord row,
    String tableName,
  ) {
    return _readAllTableRows(row)[tableName] ?? const [];
  }

  List<Map<String, Object?>> _toTableRowList(Object? rawValue) {
    if (rawValue is! List) {
      return const [];
    }
    return rawValue
        .map(
          (row) => Map<String, Object?>.from(
            (row as Map).map((key, value) {
              return MapEntry(key.toString(), value);
            }),
          ),
        )
        .toList(growable: false);
  }

  SyncDomain? _tryParseSyncDomain(String rawValue) {
    for (final domain in SyncDomain.values) {
      if (domain.name == rawValue) {
        return domain;
      }
    }
    return null;
  }

  T? _asEnum<T extends Enum>(List<T> values, String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) {
      return null;
    }
    for (final value in values) {
      if (value.name == rawValue) {
        return value;
      }
    }
    return null;
  }

  String? _asString(Object? value) {
    if (value == null) {
      return null;
    }
    final stringValue = value.toString();
    return stringValue.trim().isEmpty ? null : stringValue;
  }

  int? _asInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }

  double? _asDouble(Object? value) {
    if (value is double) {
      return value;
    }
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '');
  }

  bool? _asBool(Object? value) {
    if (value is bool) {
      return value;
    }
    final raw = value?.toString().toLowerCase();
    if (raw == 'true' || raw == '1') {
      return true;
    }
    if (raw == 'false' || raw == '0') {
      return false;
    }
    return null;
  }

  DateTime? _asDateTime(Object? value) {
    if (value is DateTime) {
      return value;
    }
    if (value == null) {
      return null;
    }
    return DateTime.tryParse(value.toString());
  }

  String _normalizeKey(String value) {
    return value.trim().toLowerCase();
  }

  String _foodNameBrandKey(String name, String? brandName) {
    final normalizedBrand = brandName?.trim().toLowerCase() ?? '';
    return '${name.trim().toLowerCase()}|$normalizedBrand';
  }

  String? _formatDouble(double? value) {
    if (value == null) {
      return null;
    }
    return value.toStringAsFixed(3);
  }

  Map<String, Object?> _sanitizeMap(Map<String, Object?> source) {
    return source.map((key, value) => MapEntry(key, _sanitizeValue(value)));
  }

  Object? _sanitizeValue(Object? value) {
    if (value == null || value is String || value is num || value is bool) {
      return value;
    }
    if (value is DateTime) {
      return value.toUtc().toIso8601String();
    }
    if (value is Uint8List) {
      return value.toList(growable: false);
    }
    if (value is List) {
      return value.map(_sanitizeValue).toList(growable: false);
    }
    if (value is Map) {
      return value.map(
        (key, nestedValue) =>
            MapEntry(key.toString(), _sanitizeValue(nestedValue)),
      );
    }
    return value.toString();
  }
}

class _ImportedSavedMealItem {
  const _ImportedSavedMealItem({
    required this.foodId,
    required this.originalValue,
    required this.originalUnit,
    required this.canonicalGrams,
    required this.canonicalMilliliters,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String foodId;
  final double originalValue;
  final FoodQuantityUnit originalUnit;
  final double? canonicalGrams;
  final double? canonicalMilliliters;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class _ExistingSavedMealAccumulator {
  _ExistingSavedMealAccumulator({required this.name});

  final String name;
  final List<_ImportedSavedMealItem> items = <_ImportedSavedMealItem>[];
}
