import 'dart:convert';

import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/domain/entities/health_status_log.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/domain/entities/workout_history_item.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/shared/enums/insight_category.dart';
import 'package:forge/shared/enums/insight_severity.dart';
import 'package:forge/shared/enums/insight_status.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';

import 'nutrition_insight_rule_service.dart';
import 'training_insight_rule_service.dart';

class DeterministicInsightEngine {
  const DeterministicInsightEngine({
    TrainingInsightRuleService trainingInsightRuleService =
        const TrainingInsightRuleService(),
    NutritionInsightRuleService nutritionInsightRuleService =
        const NutritionInsightRuleService(),
  }) : _trainingInsightRuleService = trainingInsightRuleService,
       _nutritionInsightRuleService = nutritionInsightRuleService;

  final TrainingInsightRuleService _trainingInsightRuleService;
  final NutritionInsightRuleService _nutritionInsightRuleService;

  List<Insight> generate({
    required DateTime now,
    required double hydrationMillilitersToday,
    required List<WorkoutHistoryItem> workoutHistory,
    List<WorkoutSessionDetail> recentWorkoutDetails = const [],
    NutritionMacros todayNutritionTotals = NutritionMacros.zero,
    List<NutritionInsightDaySnapshot> recentNutritionDays = const [],
    Goal? activeGoal,
    required List<BodyLog> bodyLogs,
    required List<HealthStatusLog> activeHealthLogs,
    int? gymMembershipDaysRemaining,
  }) {
    final insights = <Insight>[];

    final hydrationInsight = _buildHydrationInsight(
      now: now,
      hydrationMillilitersToday: hydrationMillilitersToday,
    );
    if (hydrationInsight != null) {
      insights.add(hydrationInsight);
    }

    final healthInsight = _buildHealthInsight(
      now: now,
      activeHealthLogs: activeHealthLogs,
    );
    if (healthInsight != null) {
      insights.add(healthInsight);
    }

    final membershipInsight = _buildMembershipInsight(
      now: now,
      daysRemaining: gymMembershipDaysRemaining,
    );
    if (membershipInsight != null) {
      insights.add(membershipInsight);
    }

    final trainingGapInsight = _buildTrainingGapInsight(
      now: now,
      workoutHistory: workoutHistory,
    );
    if (trainingGapInsight != null) {
      insights.add(trainingGapInsight);
    }

    final bodyCheckInInsight = _buildBodyCheckInInsight(
      now: now,
      bodyLogs: bodyLogs,
    );
    if (bodyCheckInInsight != null) {
      insights.add(bodyCheckInInsight);
    }

    final nutritionSignals = _nutritionInsightRuleService.evaluate(
      now: now,
      todayTotals: todayNutritionTotals,
      recentDays: recentNutritionDays,
      activeGoal: activeGoal,
    );
    for (final signal in nutritionSignals) {
      insights.add(
        Insight(
          id: signal.id,
          category: signal.category,
          severity: signal.severity,
          status: InsightStatus.active,
          title: signal.title,
          shortMessage: signal.shortMessage,
          fullExplanation: signal.fullExplanation,
          evidenceJson: signal.evidenceJson,
          confidence: signal.confidence,
          suggestedAction: signal.suggestedAction,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    final trainingSignals = _trainingInsightRuleService.evaluate(
      now: now,
      recentSessions: recentWorkoutDetails,
    );
    for (final signal in trainingSignals) {
      insights.add(
        Insight(
          id: signal.id,
          category: signal.category,
          severity: signal.severity,
          status: InsightStatus.active,
          title: signal.title,
          shortMessage: signal.shortMessage,
          fullExplanation: signal.fullExplanation,
          evidenceJson: signal.evidenceJson,
          confidence: signal.confidence,
          suggestedAction: signal.suggestedAction,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    return insights;
  }

  Insight? _buildHydrationInsight({
    required DateTime now,
    required double hydrationMillilitersToday,
  }) {
    if (now.hour < 14 || hydrationMillilitersToday >= 1500) {
      return null;
    }

    final severity = hydrationMillilitersToday < 900
        ? InsightSeverity.high
        : InsightSeverity.medium;
    final shortfall = (2000 - hydrationMillilitersToday).clamp(250, 2000);

    return Insight(
      id: 'insight-hydration-shortfall',
      category: InsightCategory.recovery,
      severity: severity,
      status: InsightStatus.active,
      title: 'Hydration is lagging today',
      shortMessage:
          '${hydrationMillilitersToday.toStringAsFixed(0)} ml logged so far, which is light for this point in the day.',
      fullExplanation:
          'Forge is flagging hydration because you are past early day hours and your logged intake is still below a simple recovery threshold. Low fluids can drag training output, appetite control, and how you feel later in the session.',
      evidenceJson: jsonEncode({
        'hydrationMillilitersToday': hydrationMillilitersToday,
        'hourOfDay': now.hour,
        'thresholdMilliliters': 1500,
      }),
      confidence: 0.93,
      suggestedAction:
          'Add about ${shortfall.toStringAsFixed(0)} ml across the next 1-2 hours and log it so the dashboard can clear the flag.',
      createdAt: now,
      updatedAt: now,
    );
  }

  Insight? _buildHealthInsight({
    required DateTime now,
    required List<HealthStatusLog> activeHealthLogs,
  }) {
    if (activeHealthLogs.isEmpty) {
      return null;
    }

    final highestSeverity = activeHealthLogs
        .map((log) => log.severity)
        .fold<int>(0, (max, value) => value > max ? value : max);
    final severity = highestSeverity >= 4
        ? InsightSeverity.high
        : InsightSeverity.medium;
    final topTitles = activeHealthLogs
        .take(3)
        .map((log) => log.title)
        .toList(growable: false);

    return Insight(
      id: 'insight-health-active-flags',
      category: InsightCategory.recovery,
      severity: severity,
      status: InsightStatus.active,
      title: 'Recovery context is elevated',
      shortMessage:
          '${activeHealthLogs.length} active health log${activeHealthLogs.length == 1 ? '' : 's'} are still open.',
      fullExplanation:
          'Forge found active symptom, pain, injury, or mood entries that are still unresolved. That does not diagnose anything, but it is enough signal to bias the day toward recovery-aware decisions and more conservative fueling or training choices.',
      evidenceJson: jsonEncode({
        'activeLogCount': activeHealthLogs.length,
        'topTitles': topTitles,
        'highestSeverity': highestSeverity,
      }),
      confidence: 0.95,
      suggestedAction:
          'Review the active health timeline, close anything that has resolved, and keep training intensity honest if symptoms are still present.',
      createdAt: now,
      updatedAt: now,
    );
  }

  Insight? _buildMembershipInsight({
    required DateTime now,
    required int? daysRemaining,
  }) {
    if (daysRemaining == null || daysRemaining > 3) {
      return null;
    }

    final expired = daysRemaining <= 0;
    return Insight(
      id: 'insight-gym-membership-ending',
      category: InsightCategory.consistency,
      severity: expired ? InsightSeverity.high : InsightSeverity.medium,
      status: InsightStatus.active,
      title: expired
          ? 'Gym membership needs renewal'
          : 'Gym membership is in the last 3 days',
      shortMessage: expired
          ? 'Your tracked gym cycle has ended.'
          : '$daysRemaining day${daysRemaining == 1 ? '' : 's'} remain in your tracked gym cycle.',
      fullExplanation:
          'Forge is using the saved membership start date to track your current cycle. When the end gets close, it becomes a consistency risk because access and routine can break if renewal slips.',
      evidenceJson: jsonEncode({
        'daysRemaining': daysRemaining,
        'warningWindowDays': 3,
      }),
      confidence: 0.98,
      suggestedAction: expired
          ? 'Renew the membership or update the start date today so the dashboard returns to a clean cycle.'
          : 'Decide now whether you are renewing, so this does not interrupt training momentum.',
      createdAt: now,
      updatedAt: now,
    );
  }

  Insight? _buildTrainingGapInsight({
    required DateTime now,
    required List<WorkoutHistoryItem> workoutHistory,
  }) {
    if (workoutHistory.isEmpty) {
      return null;
    }

    final latest = workoutHistory.first.startedAt;
    final gapDays = now.difference(latest).inDays;
    if (gapDays < 5) {
      return null;
    }

    final severity = gapDays >= 10
        ? InsightSeverity.high
        : InsightSeverity.medium;

    return Insight(
      id: 'insight-training-gap',
      category: InsightCategory.consistency,
      severity: severity,
      status: InsightStatus.active,
      title: 'Training consistency has cooled off',
      shortMessage:
          'It has been $gapDays day${gapDays == 1 ? '' : 's'} since the last logged session.',
      fullExplanation:
          'Forge compares the current date against your latest recorded workout. A growing gap does not always mean a problem, but it usually matters for momentum, strength retention, and how hard the restart feels.',
      evidenceJson: jsonEncode({
        'daysSinceLastWorkout': gapDays,
        'lastWorkoutAt': latest.toIso8601String(),
        'historyCount': workoutHistory.length,
      }),
      confidence: 0.91,
      suggestedAction:
          'Schedule one realistic next session, even if it is short, so consistency starts moving again.',
      createdAt: now,
      updatedAt: now,
    );
  }

  Insight? _buildBodyCheckInInsight({
    required DateTime now,
    required List<BodyLog> bodyLogs,
  }) {
    if (bodyLogs.isEmpty) {
      return Insight(
        id: 'insight-body-checkin-missing',
        category: InsightCategory.bodyComposition,
        severity: InsightSeverity.low,
        status: InsightStatus.active,
        title: 'No body check-ins logged yet',
        shortMessage:
            'You already have progress tools available, but no body metrics are logged yet.',
        fullExplanation:
            'Forge can only build body-composition trends and compare progress against training or nutrition if at least one check-in exists.',
        evidenceJson: jsonEncode({'bodyLogCount': 0}),
        confidence: 0.9,
        suggestedAction:
            'Log a bodyweight or waist check-in to start the trend history.',
        createdAt: now,
        updatedAt: now,
      );
    }

    final latest = bodyLogs.first.loggedAt;
    final gapDays = now.difference(latest).inDays;
    if (gapDays < 14) {
      return null;
    }

    return Insight(
      id: 'insight-body-checkin-stale',
      category: InsightCategory.bodyComposition,
      severity: gapDays >= 21 ? InsightSeverity.medium : InsightSeverity.low,
      status: InsightStatus.active,
      title: 'Body progress check-in is getting stale',
      shortMessage:
          'It has been $gapDays day${gapDays == 1 ? '' : 's'} since the last body log.',
      fullExplanation:
          'Body trends stay more useful when check-ins happen on a regular cadence. Long gaps make it harder to connect food, training, and recovery changes to actual body outcomes.',
      evidenceJson: jsonEncode({
        'daysSinceLastBodyLog': gapDays,
        'lastBodyLogAt': latest.toIso8601String(),
        'bodyLogCount': bodyLogs.length,
      }),
      confidence: 0.88,
      suggestedAction:
          'Add a quick body check-in this week so analytics and progress trends stay grounded.',
      createdAt: now,
      updatedAt: now,
    );
  }
}
