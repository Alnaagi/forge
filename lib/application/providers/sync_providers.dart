import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/auth_providers.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/sync_queue_dao.dart';
import 'package:forge/data/repositories/sync_repository_impl.dart';
import 'package:forge/domain/entities/remote_backup_preview.dart';
import 'package:forge/domain/entities/remote_backup_summary.dart';
import 'package:forge/domain/entities/sync_overview.dart';
import 'package:forge/domain/repositories/sync_repository.dart';
import 'package:forge/application/providers/settings_providers.dart';

final syncQueueDaoProvider = Provider<SyncQueueDao>((ref) {
  return SyncQueueDao(ref.watch(appDatabaseProvider));
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepositoryImpl(
    database: ref.watch(appDatabaseProvider),
    queueDao: ref.watch(syncQueueDaoProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
    cloudBackupClient: ref.watch(cloudBackupClientProvider),
  );
});

final syncOverviewProvider = FutureProvider<SyncOverview>((ref) async {
  final sessionAsync = ref.watch(authSessionStateProvider);
  final sessionState =
      sessionAsync.valueOrNull ??
      await ref.watch(authRepositoryProvider).getSessionState();
  final repository = ref.watch(syncRepositoryProvider);
  final linkedAccount = await repository.getLinkedAccountState();
  final uploadableItems = await repository.getUploadQueue();
  final lastPreparedAt = await repository.getLastPreparedAt();
  final lastSyncAttemptAt = await repository.getLastSyncAttemptAt();
  final lastSyncSuccessAt = await repository.getLastSyncSuccessAt();
  final lastSyncError = await repository.getLastSyncError();

  return SyncOverview(
    sessionState: sessionState,
    linkedAccount: linkedAccount,
    uploadableItems: uploadableItems,
    lastPreparedAt: lastPreparedAt,
    lastSyncAttemptAt: lastSyncAttemptAt,
    lastSyncSuccessAt: lastSyncSuccessAt,
    lastSyncError: lastSyncError,
  );
});

final remoteBackupSummariesProvider =
    FutureProvider.autoDispose<List<RemoteBackupSummary>>((ref) async {
      return ref.watch(syncRepositoryProvider).getRemoteBackups();
    });

final remoteBackupPreviewProvider = FutureProvider.autoDispose
    .family<RemoteBackupPreview, String>((ref, installationId) async {
      return ref
          .watch(syncRepositoryProvider)
          .getRemoteBackupPreview(installationId);
    });
