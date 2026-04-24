import 'package:forge/application/services/reminder_notification_scheduler.dart';
import 'package:forge/domain/entities/reminder.dart';

ReminderNotificationScheduler createReminderNotificationSchedulerImpl() {
  return const _StubReminderNotificationScheduler();
}

class _StubReminderNotificationScheduler
    implements ReminderNotificationScheduler {
  const _StubReminderNotificationScheduler();

  @override
  Stream<String> get tapEvents => const Stream<String>.empty();

  @override
  Future<ReminderNotificationDeliveryStatus> getStatus() async {
    return const ReminderNotificationDeliveryStatus(
      isSupported: false,
      areNotificationsEnabled: false,
      scheduledReminderCount: 0,
    );
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermissions() async => false;

  @override
  Future<String?> consumeInitialTapPayload() async => null;

  @override
  Future<void> syncSmartReminders(List<Reminder> reminders) async {}

  @override
  void dispose() {}
}
