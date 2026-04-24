import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/migrations/migration_v4.dart';

class MigrationV5 {
  const MigrationV5._();

  static const version = 5;

  static const _indexStatements = <String>[
    ...MigrationV4.indexStatements,
    'CREATE INDEX IF NOT EXISTS sync_queue_account_status_updated_idx ON sync_queue_table (account_id, status, updated_at DESC)',
  ];

  static Future<void> onUpgrade(
    AppDatabase database,
    Migrator migrator,
    int from,
    int to,
  ) async {
    await MigrationV4.onUpgrade(database, migrator, from, to);
    if (from < 5) {
      await migrator.createTable(database.syncQueueTable);
    }
    await createIndexes(database);
  }

  static Future<void> createIndexes(AppDatabase database) async {
    for (final statement in _indexStatements) {
      await database.customStatement(statement);
    }
  }
}
