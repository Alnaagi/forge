import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/shared/enums/sync_queue_status.dart';

class SyncQueueDao {
  const SyncQueueDao(this.database);

  final AppDatabase database;

  Future<List<SyncQueueTableData>> getQueueForAccount(String accountId) {
    return (database.select(database.syncQueueTable)
          ..where((table) => table.accountId.equals(accountId))
          ..orderBy([
            (table) => OrderingTerm.asc(table.status),
            (table) => OrderingTerm.desc(table.updatedAt),
          ]))
        .get();
  }

  Future<List<SyncQueueTableData>> getUploadQueueForAccount(String accountId) {
    return (database.select(database.syncQueueTable)
          ..where(
            (table) =>
                table.accountId.equals(accountId) &
                (table.status.equals(SyncQueueStatus.pending.name) |
                    table.status.equals(SyncQueueStatus.failed.name)),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.status),
            (table) => OrderingTerm.desc(table.updatedAt),
          ]))
        .get();
  }

  Future<void> upsert(SyncQueueTableCompanion companion) {
    return database.into(database.syncQueueTable).insertOnConflictUpdate(companion);
  }

  Future<void> updateStatus({
    required String accountId,
    required String domainName,
    required String operationName,
    required SyncQueueStatus status,
    required DateTime updatedAt,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? lastSuccessAt,
    Value<String?>? lastError,
    Value<int>? retryCount,
  }) {
    return (database.update(database.syncQueueTable)
          ..where(
            (table) =>
                table.accountId.equals(accountId) &
                table.domain.equals(domainName) &
                table.operation.equals(operationName),
          ))
        .write(
          SyncQueueTableCompanion(
            status: Value(status),
            updatedAt: Value(updatedAt),
            lastAttemptAt: lastAttemptAt ?? const Value.absent(),
            lastSuccessAt: lastSuccessAt ?? const Value.absent(),
            lastError: lastError ?? const Value.absent(),
            retryCount: retryCount ?? const Value.absent(),
          ),
        );
  }

  Future<int> countByStatus({
    required String accountId,
    required SyncQueueStatus status,
  }) async {
    final countExpression = database.syncQueueTable.accountId.count();
    final query = database.selectOnly(database.syncQueueTable)
      ..addColumns([countExpression])
      ..where(
        database.syncQueueTable.accountId.equals(accountId) &
            database.syncQueueTable.status.equals(status.name),
      );
    final row = await query.getSingleOrNull();
    return row?.read(countExpression) ?? 0;
  }
}
