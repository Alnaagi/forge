import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/insight_providers.dart';
import 'package:forge/application/services/reminder_notification_scheduler.dart';
import 'package:forge/application/services/reminder_notification_scheduler_factory.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/reminder_dao.dart';
import 'package:forge/data/repositories/reminder_repository_impl.dart';
import 'package:forge/domain/entities/reminder.dart';
import 'package:forge/domain/repositories/reminder_repository.dart';
import 'package:forge/domain/services/insight_reminder_service.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';

final reminderDaoProvider = Provider<ReminderDao>((ref) {
  return ReminderDao(ref.watch(appDatabaseProvider));
});

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepositoryImpl(ref.watch(reminderDaoProvider));
});

final insightReminderServiceProvider = Provider<InsightReminderService>((ref) {
  return const InsightReminderService();
});

final reminderNotificationSchedulerProvider =
    Provider<ReminderNotificationScheduler>((ref) {
      final scheduler = createReminderNotificationScheduler();
      ref.onDispose(scheduler.dispose);
      return scheduler;
    });

final reminderSyncProvider = FutureProvider<void>((ref) async {
  final activeInsights = await ref.watch(activeInsightsProvider.future);
  final healthProfile = await ref.watch(healthProfileProvider.future);
  final repository = ref.watch(reminderRepositoryProvider);
  final reminderService = ref.watch(insightReminderServiceProvider);
  final notificationScheduler = ref.watch(
    reminderNotificationSchedulerProvider,
  );
  final existingReminders = await repository.getAll();
  final now = DateTime.now();

  final generatedReminders = reminderService.buildReminders(
    now: now,
    activeInsights: activeInsights,
    healthProfile: healthProfile,
    existingReminders: existingReminders,
  );
  final generatedIds = generatedReminders
      .map((reminder) => reminder.id)
      .toSet();

  for (final reminder in generatedReminders) {
    await repository.save(reminder);
  }

  for (final existing in existingReminders) {
    if (!existing.id.startsWith('smart-') ||
        generatedIds.contains(existing.id)) {
      continue;
    }
    await repository.delete(existing.id);
  }

  final syncedReminders = await repository.getAll();
  await notificationScheduler.syncSmartReminders(syncedReminders);
});

final smartRemindersProvider = FutureProvider<List<Reminder>>((ref) async {
  await ref.watch(reminderSyncProvider.future);
  final reminders = await ref.watch(reminderRepositoryProvider).getAll();
  return reminders
      .where((reminder) => reminder.id.startsWith('smart-'))
      .toList(growable: false);
});

final reminderNotificationStatusProvider =
    FutureProvider<ReminderNotificationDeliveryStatus>((ref) async {
      await ref.watch(reminderSyncProvider.future);
      return ref.watch(reminderNotificationSchedulerProvider).getStatus();
    });

final initialReminderTapProvider = FutureProvider<String?>((ref) async {
  return ref
      .watch(reminderNotificationSchedulerProvider)
      .consumeInitialTapPayload();
});

final reminderTapEventsProvider = StreamProvider<String>((ref) {
  return ref.watch(reminderNotificationSchedulerProvider).tapEvents;
});

final reminderNotificationControllerProvider =
    Provider<ReminderNotificationController>((ref) {
      return ReminderNotificationController(ref);
    });

class ReminderNotificationController {
  ReminderNotificationController(this._ref);

  final Ref _ref;

  Future<void> refresh() async {
    _ref.invalidate(reminderSyncProvider);
    _ref.invalidate(smartRemindersProvider);
    _ref.invalidate(reminderNotificationStatusProvider);
    await _ref.read(reminderSyncProvider.future);
  }

  Future<bool> requestPermissions() async {
    final granted = await _ref
        .read(reminderNotificationSchedulerProvider)
        .requestPermissions();
    _ref.invalidate(reminderNotificationStatusProvider);
    if (granted) {
      await refresh();
    }
    return granted;
  }

  Future<void> setReminderEnabled({
    required Reminder reminder,
    required bool isEnabled,
  }) async {
    await _ref
        .read(reminderRepositoryProvider)
        .save(
          reminder.copyWith(
            isEnabled: isEnabled,
            isUserDisabled: !isEnabled,
            updatedAt: DateTime.now(),
          ),
        );
    await refresh();
  }

  Future<void> setReminderTimeOfDay({
    required Reminder reminder,
    required String timeOfDay,
  }) async {
    await _ref
        .read(reminderRepositoryProvider)
        .save(
          reminder.copyWith(timeOfDay: timeOfDay, updatedAt: DateTime.now()),
        );
    await refresh();
  }
}
