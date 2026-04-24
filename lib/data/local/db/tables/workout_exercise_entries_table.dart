import 'package:drift/drift.dart';
import 'package:forge/data/local/db/tables/exercises_table.dart';
import 'package:forge/data/local/db/tables/workout_sessions_table.dart';

class WorkoutExerciseEntriesTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get sessionId => text().references(
    WorkoutSessionsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get exerciseId =>
      text().references(ExercisesTable, #id, onDelete: KeyAction.restrict)();
  IntColumn get orderIndex => integer()();
  TextColumn get notes => text().nullable()();
  TextColumn get supersetGroupId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(session_id, order_index)'];
}
