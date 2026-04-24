import 'package:drift/drift.dart';
import 'package:forge/shared/enums/health_entry_type.dart';

class HealthStatusLogsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get type => textEnum<HealthEntryType>()();
  TextColumn get title => text().withLength(min: 1, max: 120)();
  IntColumn get severity => integer()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  IntColumn get energyLevel => integer().nullable()();
  TextColumn get bodyArea => text().withLength(min: 1, max: 80).nullable()();
  TextColumn get symptomTags => text().withDefault(const Constant(''))();
  TextColumn get possibleTrigger =>
      text().withLength(min: 1, max: 160).nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
