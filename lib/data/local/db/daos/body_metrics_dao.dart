import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class BodyMetricsDao {
  const BodyMetricsDao(this.database);

  final AppDatabase database;

  Future<List<BodyLogsTableData>> getBodyLogs() {
    return (database.select(
      database.bodyLogsTable,
    )..orderBy([(table) => OrderingTerm.desc(table.loggedAt)])).get();
  }

  Future<BodyLogsTableData?> getLatestBodyLog() {
    return (database.select(database.bodyLogsTable)
          ..orderBy([(table) => OrderingTerm.desc(table.loggedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> upsert(BodyLogsTableCompanion companion) {
    return database
        .into(database.bodyLogsTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> delete(String bodyLogId) {
    return (database.delete(
      database.bodyLogsTable,
    )..where((table) => table.id.equals(bodyLogId))).go();
  }
}
