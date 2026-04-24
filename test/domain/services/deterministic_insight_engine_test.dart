import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/domain/entities/health_status_log.dart';
import 'package:forge/domain/entities/workout_history_item.dart';
import 'package:forge/domain/services/deterministic_insight_engine.dart';
import 'package:forge/shared/enums/health_entry_type.dart';
import 'package:forge/shared/enums/insight_category.dart';

void main() {
  group('DeterministicInsightEngine', () {
    test('creates hydration and training gap insights from clear signals', () {
      final engine = const DeterministicInsightEngine();
      final insights = engine.generate(
        now: DateTime(2026, 4, 21, 15),
        hydrationMillilitersToday: 700,
        workoutHistory: [
          WorkoutHistoryItem(
            sessionId: 's1',
            templateName: 'Push',
            startedAt: DateTime(2026, 4, 13),
            endedAt: DateTime(2026, 4, 13, 1),
            exerciseCount: 5,
            setCount: 20,
            totalVolumeKilograms: 4200,
          ),
        ],
        bodyLogs: <BodyLog>[],
        activeHealthLogs: <HealthStatusLog>[],
        gymMembershipDaysRemaining: 10,
      );

      expect(
        insights.any((insight) => insight.id == 'insight-hydration-shortfall'),
        isTrue,
      );
      expect(
        insights.any((insight) => insight.id == 'insight-training-gap'),
        isTrue,
      );
      expect(
        insights.any(
          (insight) => insight.category == InsightCategory.bodyComposition,
        ),
        isTrue,
      );
    });

    test('creates elevated recovery insight for active health logs', () {
      final engine = const DeterministicInsightEngine();
      final insights = engine.generate(
        now: DateTime(2026, 4, 21, 10),
        hydrationMillilitersToday: 1800,
        workoutHistory: <WorkoutHistoryItem>[],
        bodyLogs: <BodyLog>[],
        activeHealthLogs: [
          HealthStatusLog(
            id: 'h1',
            type: HealthEntryType.symptom,
            title: 'Migraine',
            severity: 4,
            loggedAt: DateTime(2026, 4, 21, 8),
            createdAt: DateTime(2026, 4, 21, 8),
            updatedAt: DateTime(2026, 4, 21, 8),
          ),
        ],
        gymMembershipDaysRemaining: null,
      );

      final healthInsight = insights.firstWhere(
        (insight) => insight.id == 'insight-health-active-flags',
      );
      expect(healthInsight.title, contains('Recovery'));
    });
  });
}
