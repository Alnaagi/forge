import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/migrations/migration_v5.dart';

class MigrationV6 {
  const MigrationV6._();

  static const version = 6;

  static Future<void> onUpgrade(
    AppDatabase database,
    Migrator migrator,
    int from,
    int to,
  ) async {
    await MigrationV5.onUpgrade(database, migrator, from, to);
    if (from < 6) {
      await migrator.addColumn(
        database.usersTable,
        database.usersTable.originalHeightValue,
      );
      await migrator.addColumn(
        database.usersTable,
        database.usersTable.originalHeightUnit,
      );
      await migrator.addColumn(
        database.usersTable,
        database.usersTable.canonicalHeightCentimeters,
      );
      await migrator.addColumn(
        database.usersTable,
        database.usersTable.activityLevel,
      );
    }
    await createIndexes(database);
  }

  static Future<void> createIndexes(AppDatabase database) {
    return MigrationV5.createIndexes(database);
  }
}
