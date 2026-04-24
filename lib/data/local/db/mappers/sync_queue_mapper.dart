import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/sync_queue_item.dart';

extension SyncQueueMapper on SyncQueueTableData {
  SyncQueueItem toDomain() {
    return SyncQueueItem(
      accountId: accountId,
      domain: domain,
      operation: operation,
      status: status,
      queuedAt: queuedAt,
      updatedAt: updatedAt,
      lastAttemptAt: lastAttemptAt,
      lastSuccessAt: lastSuccessAt,
      lastError: lastError,
      retryCount: retryCount,
    );
  }
}
