import 'package:drift/drift.dart';
import 'package:forge/shared/enums/activity_level.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class UsersTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get displayName => text().withLength(min: 1, max: 80)();
  TextColumn get preferredWeightUnit => textEnum<WeightUnit>()();
  TextColumn get preferredBodyMetricUnit => textEnum<BodyMetricUnit>()();
  RealColumn get originalHeightValue => real().nullable()();
  TextColumn get originalHeightUnit => textEnum<BodyMetricUnit>().nullable()();
  RealColumn get canonicalHeightCentimeters => real().nullable()();
  TextColumn get activityLevel => textEnum<ActivityLevel>().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
