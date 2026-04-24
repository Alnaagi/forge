import 'package:forge/domain/entities/reminder.dart';

abstract class ReminderRepository {
  Future<List<Reminder>> getAll();
  Future<void> save(Reminder reminder);
  Future<void> delete(String reminderId);
}
