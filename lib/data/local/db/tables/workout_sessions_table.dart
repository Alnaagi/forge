import 'package:drift/drift.dart';
import 'package:forge/data/local/db/tables/workout_templates_table.dart';

class WorkoutSessionsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get templateId => text().nullable().references(
    WorkoutTemplatesTable,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
