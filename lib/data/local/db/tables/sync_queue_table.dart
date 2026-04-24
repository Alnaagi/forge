import 'package:drift/drift.dart';
import 'package:forge/shared/enums/sync_domain.dart';
import 'package:forge/shared/enums/sync_queue_operation.dart';
import 'package:forge/shared/enums/sync_queue_status.dart';

class SyncQueueTable extends Table {
  TextColumn get accountId => text().withLength(min: 1, max: 128)();
  TextColumn get domain => textEnum<SyncDomain>()();
  TextColumn get operation => textEnum<SyncQueueOperation>()();
  TextColumn get status =>
      textEnum<SyncQueueStatus>().withDefault(
        const Constant('pending'),
      )();
  DateTimeColumn get queuedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  DateTimeColumn get lastSuccessAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {accountId, domain, operation};
}
