import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class ReminderDao {
  const ReminderDao(this.database);

  final AppDatabase database;

  Future<List<RemindersTableData>> getAll() {
    return (database.select(
      database.remindersTable,
    )..orderBy([(table) => OrderingTerm.asc(table.timeOfDay)])).get();
  }

  Future<void> upsert(RemindersTableCompanion companion) {
    return database
        .into(database.remindersTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> deleteById(String reminderId) {
    return (database.delete(
      database.remindersTable,
    )..where((table) => table.id.equals(reminderId))).go();
  }
}
