import 'package:drift/drift.dart';

class HealthProfilesTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get healthConditions => text().withDefault(const Constant(''))();
  TextColumn get medications => text().withDefault(const Constant(''))();
  TextColumn get allergies => text().withDefault(const Constant(''))();
  TextColumn get notes => text().nullable()();
  IntColumn get checkInCadenceHours =>
      integer().withDefault(const Constant(8))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
