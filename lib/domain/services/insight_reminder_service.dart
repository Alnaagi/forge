import 'package:forge/domain/entities/health_profile.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/domain/entities/reminder.dart';
import 'package:forge/shared/enums/reminder_type.dart';

class InsightReminderService {
  const InsightReminderService();

  List<Reminder> buildReminders({
    required DateTime now,
    required List<Insight> activeInsights,
    HealthProfile? healthProfile,
    List<Reminder> existingReminders = const [],
  }) {
    final existingById = {
      for (final reminder in existingReminders) reminder.id: reminder,
    };
    final reminders = <Reminder>[];

    for (final insight in activeInsights) {
      final template = _templateForInsight(insight);
      if (template == null) {
        continue;
      }

      final existing = existingById[template.id];
      reminders.add(
        Reminder(
          id: template.id,
          type: template.type,
          title: template.title,
          timeOfDay: existing?.timeOfDay ?? template.timeOfDay,
          isEnabled: !(existing?.isUserDisabled ?? false),
          isUserDisabled: existing?.isUserDisabled ?? false,
          createdAt: existing?.createdAt ?? now,
          updatedAt: now,
        ),
      );
    }

    if (healthProfile != null) {
      for (final slot in _healthCadenceSlots(
        healthProfile.checkInCadenceHours,
      )) {
        final existing = existingById[slot.id];
        reminders.add(
          Reminder(
            id: slot.id,
            type: ReminderType.progressCheck,
            title: 'Health check-in',
            timeOfDay: existing?.timeOfDay ?? slot.timeOfDay,
            isEnabled: !(existing?.isUserDisabled ?? false),
            isUserDisabled: existing?.isUserDisabled ?? false,
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
      }
    }

    return reminders;
  }

  _ReminderTemplate? _templateForInsight(Insight insight) {
    switch (insight.id) {
      case 'insight-hydration-shortfall':
      case 'insight-hydration-streak-miss':
        return const _ReminderTemplate(
          id: 'smart-water-recovery',
          type: ReminderType.water,
          title: 'Hydration catch-up block',
          timeOfDay: '18:00',
        );
      case 'insight-low-protein':
      case 'insight-low-calories-for-goal':
        return const _ReminderTemplate(
          id: 'smart-nutrition-goal',
          type: ReminderType.meal,
          title: 'Close the nutrition gap',
          timeOfDay: '19:00',
        );
      case 'insight-training-gap':
      case 'insight-training-plateau':
      case 'insight-skipped-muscle-group':
      case 'insight-deload-trigger':
        return const _ReminderTemplate(
          id: 'smart-training-check',
          type: ReminderType.workout,
          title: 'Review the next training move',
          timeOfDay: '17:30',
        );
      case 'insight-body-checkin-missing':
      case 'insight-body-checkin-stale':
        return const _ReminderTemplate(
          id: 'smart-body-checkin',
          type: ReminderType.weighIn,
          title: 'Log a body progress check-in',
          timeOfDay: '09:00',
        );
      case 'insight-health-active-flags':
        return const _ReminderTemplate(
          id: 'smart-health-review',
          type: ReminderType.progressCheck,
          title: 'Review active health flags',
          timeOfDay: '20:00',
        );
      case 'insight-gym-membership-ending':
        return const _ReminderTemplate(
          id: 'smart-membership-renewal',
          type: ReminderType.progressCheck,
          title: 'Renew or update gym membership',
          timeOfDay: '10:00',
        );
    }
    return null;
  }

  List<_HealthCadenceSlot> _healthCadenceSlots(int cadenceHours) {
    return switch (cadenceHours) {
      4 => const [
        _HealthCadenceSlot('smart-health-checkin-08-00', '08:00'),
        _HealthCadenceSlot('smart-health-checkin-12-00', '12:00'),
        _HealthCadenceSlot('smart-health-checkin-16-00', '16:00'),
        _HealthCadenceSlot('smart-health-checkin-20-00', '20:00'),
      ],
      8 => const [
        _HealthCadenceSlot('smart-health-checkin-10-00', '10:00'),
        _HealthCadenceSlot('smart-health-checkin-18-00', '18:00'),
      ],
      12 => const [
        _HealthCadenceSlot('smart-health-checkin-09-00', '09:00'),
        _HealthCadenceSlot('smart-health-checkin-21-00', '21:00'),
      ],
      _ => const [_HealthCadenceSlot('smart-health-checkin-19-00', '19:00')],
    };
  }
}

class _ReminderTemplate {
  const _ReminderTemplate({
    required this.id,
    required this.type,
    required this.title,
    required this.timeOfDay,
  });

  final String id;
  final ReminderType type;
  final String title;
  final String timeOfDay;
}

class _HealthCadenceSlot {
  const _HealthCadenceSlot(this.id, this.timeOfDay);

  final String id;
  final String timeOfDay;
}
