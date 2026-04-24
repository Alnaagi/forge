import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class SettingsDao {
  const SettingsDao(this.database);

  final AppDatabase database;

  Future<List<AppSettingsTableData>> getAll() {
    return (database.select(
      database.appSettingsTable,
    )..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])).get();
  }

  Future<AppSettingsTableData?> getByKey(String key) {
    return (database.select(
      database.appSettingsTable,
    )..where((table) => table.key.equals(key))).getSingleOrNull();
  }

  Future<void> upsert(AppSettingsTableCompanion companion) {
    return database
        .into(database.appSettingsTable)
        .insertOnConflictUpdate(companion);
  }
}
