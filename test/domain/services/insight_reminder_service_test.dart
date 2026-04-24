import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/entities/health_profile.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/domain/entities/reminder.dart';
import 'package:forge/domain/services/insight_reminder_service.dart';
import 'package:forge/shared/enums/insight_category.dart';
import 'package:forge/shared/enums/insight_severity.dart';
import 'package:forge/shared/enums/insight_status.dart';
import 'package:forge/shared/enums/reminder_type.dart';

void main() {
  group('InsightReminderService', () {
    const service = InsightReminderService();

    test('builds hydration reminder from active hydration insight', () {
      final now = DateTime(2026, 4, 21, 18);
      final reminders = service.buildReminders(
        now: now,
        activeInsights: [_insight('insight-hydration-shortfall')],
      );

      expect(reminders, hasLength(1));
      expect(reminders.single.type, ReminderType.water);
      expect(reminders.single.timeOfDay, '18:00');
    });

    test('adds multiple health cadence reminders when profile exists', () {
      final now = DateTime(2026, 4, 21, 18);
      final reminders = service.buildReminders(
        now: now,
        activeInsights: const [],
        healthProfile: HealthProfile(
          id: 'health-profile',
          healthConditions: const ['migraine'],
          medications: const ['ibuprofen'],
          allergies: const ['peanut'],
          checkInCadenceHours: 8,
          createdAt: now,
          updatedAt: now,
        ),
      );

      expect(reminders, hasLength(2));
      expect(
        reminders.map((reminder) => reminder.id),
        containsAll([
          'smart-health-checkin-10-00',
          'smart-health-checkin-18-00',
        ]),
      );
      expect(
        reminders.map((reminder) => reminder.timeOfDay),
        containsAll(['10:00', '18:00']),
      );
    });

    test(
      'preserves user-disabled and time override state on active reminders',
      () {
        final now = DateTime(2026, 4, 21, 18);
        final reminders = service.buildReminders(
          now: now,
          activeInsights: [_insight('insight-training-gap')],
          existingReminders: [
            Reminder(
              id: 'smart-training-check',
              type: ReminderType.workout,
              title: 'Review the next training move',
              timeOfDay: '20:15',
              isEnabled: false,
              isUserDisabled: true,
              createdAt: now.subtract(const Duration(days: 1)),
              updatedAt: now.subtract(const Duration(days: 1)),
            ),
          ],
        );

        expect(reminders, hasLength(1));
        expect(reminders.single.timeOfDay, '20:15');
        expect(reminders.single.isEnabled, isFalse);
        expect(reminders.single.isUserDisabled, isTrue);
      },
    );
  });
}

Insight _insight(String id) {
  final now = DateTime(2026, 4, 21);
  return Insight(
    id: id,
    category: InsightCategory.recovery,
    severity: InsightSeverity.medium,
    status: InsightStatus.active,
    title: 'Title',
    shortMessage: 'Short',
    fullExplanation: 'Full',
    evidenceJson: '{}',
    confidence: 0.9,
    suggestedAction: 'Action',
    createdAt: now,
    updatedAt: now,
  );
}
