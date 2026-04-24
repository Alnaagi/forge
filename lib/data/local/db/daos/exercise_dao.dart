import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class ExerciseDao {
  const ExerciseDao(this.database);

  final AppDatabase database;

  Future<List<ExercisesTableData>> getAll({String? query}) {
    final statement = database.select(database.exercisesTable)
      ..orderBy([(table) => OrderingTerm.asc(table.name)]);

    if (query != null && query.trim().isNotEmpty) {
      statement.where((table) => table.name.like('%${query.trim()}%'));
    }

    return statement.get();
  }

  Future<ExercisesTableData?> getById(String exerciseId) {
    return (database.select(
      database.exercisesTable,
    )..where((table) => table.id.equals(exerciseId))).getSingleOrNull();
  }

  Future<void> upsert(ExercisesTableCompanion companion) {
    return database
        .into(database.exercisesTable)
        .insertOnConflictUpdate(companion);
  }
}
