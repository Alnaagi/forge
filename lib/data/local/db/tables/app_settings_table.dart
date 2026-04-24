import 'package:drift/drift.dart';

class AppSettingsTable extends Table {
  TextColumn get key => text().withLength(min: 1, max: 120)();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {key};
}
