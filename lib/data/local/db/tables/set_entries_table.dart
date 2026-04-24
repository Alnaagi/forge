import 'package:drift/drift.dart';
import 'package:forge/data/local/db/tables/workout_exercise_entries_table.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class SetEntriesTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get exerciseEntryId => text().references(
    WorkoutExerciseEntriesTable,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get setType => textEnum<SetType>()();
  IntColumn get orderIndex => integer()();
  IntColumn get reps => integer()();
  RealColumn get originalWeightValue => real().nullable()();
  TextColumn get originalWeightUnit => textEnum<WeightUnit>().nullable()();
  RealColumn get canonicalWeightKilograms => real().nullable()();
  RealColumn get rpe => real().nullable()();
  TextColumn get tempo => text().withLength(min: 1, max: 32).nullable()();
  IntColumn get restSeconds => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'UNIQUE(exercise_entry_id, order_index)',
  ];
}
