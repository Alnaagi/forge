import 'package:forge/shared/enums/sync_domain.dart';
import 'package:forge/shared/enums/sync_queue_operation.dart';
import 'package:forge/shared/enums/sync_queue_status.dart';

class SyncQueueItem {
  const SyncQueueItem({
    required this.accountId,
    required this.domain,
    required this.operation,
    required this.status,
    required this.queuedAt,
    required this.updatedAt,
    this.lastAttemptAt,
    this.lastSuccessAt,
    this.lastError,
    required this.retryCount,
  });

  final String accountId;
  final SyncDomain domain;
  final SyncQueueOperation operation;
  final SyncQueueStatus status;
  final DateTime queuedAt;
  final DateTime updatedAt;
  final DateTime? lastAttemptAt;
  final DateTime? lastSuccessAt;
  final String? lastError;
  final int retryCount;
}
