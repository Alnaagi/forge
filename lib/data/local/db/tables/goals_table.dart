import 'package:drift/drift.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class GoalsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get type => textEnum<GoalType>()();
  TextColumn get title => text().withLength(min: 1, max: 120).nullable()();
  RealColumn get originalTargetWeightValue => real().nullable()();
  TextColumn get originalTargetWeightUnit =>
      textEnum<WeightUnit>().nullable()();
  RealColumn get canonicalTargetWeightKilograms => real().nullable()();
  IntColumn get targetCalories => integer()();
  RealColumn get targetProteinGrams => real()();
  RealColumn get targetCarbsGrams => real()();
  RealColumn get targetFatGrams => real()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
