import 'package:forge/application/services/reminder_notification_scheduler.dart';
import 'package:forge/application/services/reminder_notification_scheduler_impl_stub.dart'
    if (dart.library.io) 'package:forge/application/services/reminder_notification_scheduler_impl_mobile.dart';

ReminderNotificationScheduler createReminderNotificationScheduler() {
  return createReminderNotificationSchedulerImpl();
}
