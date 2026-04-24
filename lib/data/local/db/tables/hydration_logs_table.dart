import 'package:drift/drift.dart';
import 'package:forge/shared/enums/volume_unit.dart';

class HydrationLogsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  RealColumn get originalAmountValue => real()();
  TextColumn get originalAmountUnit => textEnum<VolumeUnit>()();
  RealColumn get canonicalMilliliters => real()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
