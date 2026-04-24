import 'package:drift/drift.dart';

class ExercisesTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get primaryMuscleGroup => text().withLength(min: 1, max: 64)();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(name)'];
}
