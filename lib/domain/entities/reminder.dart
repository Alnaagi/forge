import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/reminder_type.dart';

part 'reminder.freezed.dart';

@freezed
class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required ReminderType type,
    required String title,
    required String timeOfDay,
    required bool isEnabled,
    required bool isUserDisabled,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Reminder;
}
