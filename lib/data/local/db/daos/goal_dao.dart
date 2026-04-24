import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class GoalDao {
  const GoalDao(this.database);

  final AppDatabase database;

  Future<List<GoalsTableData>> getGoals() {
    return (database.select(
      database.goalsTable,
    )..orderBy([(table) => OrderingTerm.desc(table.startedAt)])).get();
  }

  Future<GoalsTableData?> getActiveGoal() {
    return (database.select(database.goalsTable)
          ..where((table) => table.isActive.equals(true))
          ..orderBy([(table) => OrderingTerm.desc(table.startedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> upsertGoal(GoalsTableCompanion companion) async {
    await database.transaction(() async {
      if (companion.isActive.present && companion.isActive.value) {
        await (database.update(database.goalsTable)
              ..where((table) => table.isActive.equals(true)))
            .write(const GoalsTableCompanion(isActive: Value(false)));
      }
      await database
          .into(database.goalsTable)
          .insertOnConflictUpdate(companion);
    });
  }
}
