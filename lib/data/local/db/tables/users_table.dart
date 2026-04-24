import 'package:drift/drift.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class UsersTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get displayName => text().withLength(min: 1, max: 80)();
  TextColumn get preferredWeightUnit => textEnum<WeightUnit>()();
  TextColumn get preferredBodyMetricUnit => textEnum<BodyMetricUnit>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
