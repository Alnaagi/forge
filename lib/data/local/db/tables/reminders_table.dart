import 'package:drift/drift.dart';
import 'package:forge/shared/enums/reminder_type.dart';

class RemindersTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get type => textEnum<ReminderType>()();
  TextColumn get title => text().withLength(min: 1, max: 120)();
  TextColumn get timeOfDay => text().withLength(min: 1, max: 16)();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get isUserDisabled =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
