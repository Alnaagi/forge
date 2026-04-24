import 'package:drift/drift.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class BodyLogsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  DateTimeColumn get loggedAt => dateTime()();
  RealColumn get originalWeightValue => real().nullable()();
  TextColumn get originalWeightUnit => textEnum<WeightUnit>().nullable()();
  RealColumn get canonicalWeightKilograms => real().nullable()();
  RealColumn get bodyFatPercentage => real().nullable()();
  RealColumn get originalWaistValue => real().nullable()();
  TextColumn get originalWaistUnit => textEnum<BodyMetricUnit>().nullable()();
  RealColumn get canonicalWaistCentimeters => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
