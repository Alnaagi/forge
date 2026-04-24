import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/reminder.dart';

extension ReminderDataMapper on RemindersTableData {
  Reminder toDomain() {
    return Reminder(
      id: id,
      type: type,
      title: title,
      timeOfDay: timeOfDay,
      isEnabled: isEnabled,
      isUserDisabled: isUserDisabled,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ReminderCompanionMapper on Reminder {
  RemindersTableCompanion toCompanion() {
    return RemindersTableCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      timeOfDay: Value(timeOfDay),
      isEnabled: Value(isEnabled),
      isUserDisabled: Value(isUserDisabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
