import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class HealthTrackingDao {
  const HealthTrackingDao(this.database);

  final AppDatabase database;

  Future<HealthProfilesTableData?> getHealthProfile() {
    return database.select(database.healthProfilesTable).getSingleOrNull();
  }

  Future<void> upsertHealthProfile(HealthProfilesTableCompanion companion) {
    return database
        .into(database.healthProfilesTable)
        .insertOnConflictUpdate(companion);
  }

  Future<List<HealthStatusLogsTableData>> getHealthStatusLogs() {
    return (database.select(database.healthStatusLogsTable)..orderBy([
          (table) => OrderingTerm.desc(table.loggedAt),
          (table) => OrderingTerm.desc(table.updatedAt),
        ]))
        .get();
  }

  Future<void> upsertHealthStatusLog(HealthStatusLogsTableCompanion companion) {
    return database
        .into(database.healthStatusLogsTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> deleteHealthStatusLog(String logId) {
    return (database.delete(
      database.healthStatusLogsTable,
    )..where((table) => table.id.equals(logId))).go();
  }
}
