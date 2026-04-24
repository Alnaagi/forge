import 'package:forge/domain/entities/auth_session_state.dart';
import 'package:forge/domain/entities/linked_account_state.dart';
import 'package:forge/domain/entities/sync_queue_item.dart';
import 'package:forge/shared/enums/sync_queue_status.dart';

class SyncOverview {
  const SyncOverview({
    required this.sessionState,
    required this.linkedAccount,
    required this.uploadableItems,
    this.lastPreparedAt,
    this.lastSyncAttemptAt,
    this.lastSyncSuccessAt,
    this.lastSyncError,
  });

  final AuthSessionState sessionState;
  final LinkedAccountState? linkedAccount;
  final List<SyncQueueItem> uploadableItems;
  final DateTime? lastPreparedAt;
  final DateTime? lastSyncAttemptAt;
  final DateTime? lastSyncSuccessAt;
  final String? lastSyncError;

  int get uploadableItemCount => uploadableItems.length;

  int get failedItemCount => uploadableItems
      .where((item) => item.status == SyncQueueStatus.failed)
      .length;
}
