import 'package:forge/domain/entities/remote_backup_preview.dart';
import 'package:forge/domain/entities/remote_backup_summary.dart';
import 'package:forge/domain/entities/linked_account_state.dart';
import 'package:forge/domain/entities/sync_import_run_result.dart';
import 'package:forge/domain/entities/sync_queue_item.dart';
import 'package:forge/domain/entities/sync_upload_run_result.dart';

abstract class SyncRepository {
  Future<String> getOrCreateInstallationId();
  Future<LinkedAccountState?> getLinkedAccountState();
  Future<LinkedAccountState> linkLocalDataToAccount({
    required String accountId,
    String? email,
  });
  Future<List<SyncQueueItem>> getPendingQueue();
  Future<List<SyncQueueItem>> getUploadQueue();
  Future<int> enqueueLocalChanges();
  Future<SyncUploadRunResult> uploadPendingBatches();
  Future<List<RemoteBackupSummary>> getRemoteBackups();
  Future<RemoteBackupPreview> getRemoteBackupPreview(String installationId);
  Future<SyncImportRunResult> importRemoteBackup(String installationId);
  Future<DateTime?> getLastPreparedAt();
  Future<DateTime?> getLastSyncAttemptAt();
  Future<DateTime?> getLastSyncSuccessAt();
  Future<String?> getLastSyncError();
}
