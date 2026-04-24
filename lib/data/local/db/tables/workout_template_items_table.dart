import 'package:drift/drift.dart';
import 'package:forge/data/local/db/tables/exercises_table.dart';
import 'package:forge/data/local/db/tables/workout_templates_table.dart';

class WorkoutTemplateItemsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get templateId => text().references(
    WorkoutTemplatesTable,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get exerciseId =>
      text().references(ExercisesTable, #id, onDelete: KeyAction.restrict)();
  IntColumn get orderIndex => integer()();
  IntColumn get targetSets => integer()();
  TextColumn get targetReps => text().withLength(min: 1, max: 32)();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(template_id, order_index)'];
}
