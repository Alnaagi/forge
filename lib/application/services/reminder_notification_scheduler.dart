import 'package:forge/domain/entities/reminder.dart';

abstract class ReminderNotificationScheduler {
  Stream<String> get tapEvents;

  Future<void> initialize();

  Future<void> syncSmartReminders(List<Reminder> reminders);

  Future<ReminderNotificationDeliveryStatus> getStatus();

  Future<bool> requestPermissions();

  Future<String?> consumeInitialTapPayload();

  void dispose();
}

class ReminderNotificationDeliveryStatus {
  const ReminderNotificationDeliveryStatus({
    required this.isSupported,
    required this.areNotificationsEnabled,
    required this.scheduledReminderCount,
  });

  final bool isSupported;
  final bool areNotificationsEnabled;
  final int scheduledReminderCount;
}
