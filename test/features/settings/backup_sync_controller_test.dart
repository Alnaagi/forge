import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge/application/providers/auth_providers.dart';
import 'package:forge/application/providers/sync_providers.dart';
import 'package:forge/application/services/cloud_backup_client.dart';
import 'package:forge/application/services/cloud_auth_client.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/profile_dao.dart';
import 'package:forge/data/repositories/auth_repository_impl.dart';
import 'package:forge/features/settings/presentation/controllers/backup_sync_controller.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.test(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'signing in after local usage links local data without wiping it',
    () async {
      final now = DateTime(2026, 4, 22, 16);
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

      final authRepository = AuthRepositoryImpl(
        _MutableFakeCloudAuthClient(
          isConfigured: true,
          signInAccount: const CloudAuthAccount(
            id: 'account-1',
            email: 'forge@example.com',
          ),
        ),
      );

      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          authRepositoryProvider.overrideWithValue(authRepository),
          cloudBackupClientProvider.overrideWithValue(_FakeCloudBackupClient()),
        ],
      );
      addTearDown(container.dispose);

      final message = await container
          .read(backupSyncControllerProvider.notifier)
          .signIn(email: 'forge@example.com', password: 'secret123');

      final linked = await container
          .read(syncRepositoryProvider)
          .getLinkedAccountState();
      final queue = await container
          .read(syncRepositoryProvider)
          .getPendingQueue();
      final profile = await ProfileDao(database).getProfile();

      expect(message, contains('Signed in'));
      expect(linked, isNotNull);
      expect(linked!.accountId, 'account-1');
      expect(profile, isNotNull);
      expect(profile!.displayName, 'Mohamed');
      expect(queue, isNotEmpty);
    },
  );

  test('uploadNow reports a real backup upload after linking', () async {
    final now = DateTime(2026, 4, 22, 16);
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

    final authRepository = AuthRepositoryImpl(
      _MutableFakeCloudAuthClient(
        isConfigured: true,
        signInAccount: const CloudAuthAccount(
          id: 'account-1',
          email: 'forge@example.com',
        ),
      ),
    );
    final backupClient = _FakeCloudBackupClient();

    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        authRepositoryProvider.overrideWithValue(authRepository),
        cloudBackupClientProvider.overrideWithValue(backupClient),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(backupSyncControllerProvider.notifier)
        .signIn(email: 'forge@example.com', password: 'secret123');

    final uploadMessage = await container
        .read(backupSyncControllerProvider.notifier)
        .uploadNow();
    final overview = await container.read(syncOverviewProvider.future);

    expect(uploadMessage, contains('uploaded'));
    expect(backupClient.uploads, isNotEmpty);
    expect(overview.uploadableItemCount, 0);
    expect(overview.lastSyncSuccessAt, isNotNull);
  });
}

class _MutableFakeCloudAuthClient implements CloudAuthClient {
  _MutableFakeCloudAuthClient({required this.isConfigured, this.signInAccount});

  @override
  final bool isConfigured;

  final StreamController<CloudAuthAccount?> _controller =
      StreamController<CloudAuthAccount?>.broadcast();
  final CloudAuthAccount? signInAccount;
  CloudAuthAccount? _currentAccount;

  @override
  CloudAuthAccount? get currentAccount => _currentAccount;

  @override
  Stream<CloudAuthAccount?> authStateChanges() {
    return _controller.stream;
  }

  @override
  Future<CloudAuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _currentAccount = signInAccount;
    _controller.add(_currentAccount);
    return CloudAuthResult(account: _currentAccount);
  }

  @override
  Future<CloudAuthResult> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    _currentAccount = signInAccount;
    _controller.add(_currentAccount);
    return CloudAuthResult(account: _currentAccount);
  }

  @override
  Future<void> signOut() async {
    _currentAccount = null;
    _controller.add(null);
  }

  @override
  Future<void> updateUserMetadata(Map<String, dynamic> data) async {}
}

class _FakeCloudBackupClient implements CloudBackupClient {
  final List<CloudBackupBatchUpload> uploads = <CloudBackupBatchUpload>[];

  @override
  bool get isConfigured => true;

  @override
  String? get currentAccountId => 'account-1';

  @override
  Future<void> uploadBatch(CloudBackupBatchUpload batch) async {
    uploads.add(batch);
  }

  @override
  Future<List<CloudBackupBatchRecord>> listBatches() async {
    return const <CloudBackupBatchRecord>[];
  }
}
