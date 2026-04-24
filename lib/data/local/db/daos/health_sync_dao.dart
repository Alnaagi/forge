import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class HealthSyncDao {
  const HealthSyncDao(this.database);

  final AppDatabase database;

  Future<List<HealthSyncRecordsTableData>> getAll() {
    return (database.select(
      database.healthSyncRecordsTable,
    )..orderBy([(table) => OrderingTerm.desc(table.recordedAt)])).get();
  }

  Future<void> upsertMany(List<HealthSyncRecordsTableCompanion> companions) {
    return database.batch((batch) {
      batch.insertAllOnConflictUpdate(
        database.healthSyncRecordsTable,
        companions,
      );
    });
  }
}
