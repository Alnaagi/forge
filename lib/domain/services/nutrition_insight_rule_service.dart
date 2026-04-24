import 'dart:convert';

import 'package:forge/domain/entities/goal.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/enums/insight_category.dart';
import 'package:forge/shared/enums/insight_severity.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';

class NutritionInsightRuleService {
  const NutritionInsightRuleService();

  List<NutritionInsightSignal> evaluate({
    required DateTime now,
    required NutritionMacros todayTotals,
    required List<NutritionInsightDaySnapshot> recentDays,
    Goal? activeGoal,
  }) {
    final signals = <NutritionInsightSignal>[];

    final proteinSignal = _buildProteinSignal(
      now: now,
      todayTotals: todayTotals,
      activeGoal: activeGoal,
    );
    if (proteinSignal != null) {
      signals.add(proteinSignal);
    }

    final calorieSignal = _buildCalorieSignal(
      now: now,
      todayTotals: todayTotals,
      activeGoal: activeGoal,
    );
    if (calorieSignal != null) {
      signals.add(calorieSignal);
    }

    final hydrationPatternSignal = _buildHydrationPatternSignal(
      now: now,
      recentDays: recentDays,
    );
    if (hydrationPatternSignal != null) {
      signals.add(hydrationPatternSignal);
    }

    return signals;
  }

  NutritionInsightSignal? _buildProteinSignal({
    required DateTime now,
    required NutritionMacros todayTotals,
    Goal? activeGoal,
  }) {
    final targetProtein = activeGoal?.macroTarget.proteinGrams;
    if (targetProtein == null || targetProtein <= 0 || now.hour < 14) {
      return null;
    }

    final ratio = todayTotals.protein / targetProtein;
    final threshold = now.hour >= 18 ? 0.7 : 0.45;
    if (ratio >= threshold) {
      return null;
    }

    return NutritionInsightSignal(
      id: 'insight-low-protein',
      category: InsightCategory.nutrition,
      severity: now.hour >= 18 ? InsightSeverity.medium : InsightSeverity.low,
      title: 'Protein intake is trailing the current goal',
      shortMessage:
          '${todayTotals.protein.toStringAsFixed(0)} g logged so far against a ${targetProtein.toStringAsFixed(0)} g goal.',
      fullExplanation:
          'Forge compared today\'s logged protein against the active macro target and the time of day. Protein does not need to be perfectly linear through the day, but a clear shortfall by mid or late day usually makes the final target harder to hit cleanly.',
      evidenceJson: jsonEncode({
        'proteinGramsToday': todayTotals.protein.toStringAsFixed(1),
        'proteinTargetGrams': targetProtein.toStringAsFixed(1),
        'progressPercent': (ratio * 100).toStringAsFixed(0),
        'hourOfDay': now.hour,
      }),
      confidence: 0.9,
      suggestedAction:
          'Add one protein-forward meal or snack now so the remaining gap is smaller tonight.',
    );
  }

  NutritionInsightSignal? _buildCalorieSignal({
    required DateTime now,
    required NutritionMacros todayTotals,
    Goal? activeGoal,
  }) {
    final targetCalories = activeGoal?.macroTarget.calories;
    if (activeGoal == null || targetCalories == null || targetCalories <= 0) {
      return null;
    }
    if (now.hour < 17) {
      return null;
    }

    final ratio = todayTotals.calories / targetCalories;
    final threshold = switch (activeGoal.type) {
      GoalType.cut => 0.45,
      GoalType.bulk => 0.65,
      GoalType.strength => 0.65,
      GoalType.maintain => 0.6,
      GoalType.recomp => 0.55,
      GoalType.custom => 0.6,
    };
    if (ratio >= threshold) {
      return null;
    }

    final severity =
        activeGoal.type == GoalType.bulk || activeGoal.type == GoalType.strength
        ? InsightSeverity.medium
        : InsightSeverity.low;

    return NutritionInsightSignal(
      id: 'insight-low-calories-for-goal',
      category: InsightCategory.nutrition,
      severity: severity,
      title: 'Energy intake looks light for the active goal',
      shortMessage:
          '${todayTotals.calories} kcal logged so far against a $targetCalories kcal target for ${activeGoal.type.name}.',
      fullExplanation:
          'Forge compares today\'s calories to the active goal target instead of using a generic number. A big late-day gap does not always mean the day is bad, but for performance-focused goals it often makes recovery and progression harder to support.',
      evidenceJson: jsonEncode({
        'caloriesToday': todayTotals.calories,
        'calorieTarget': targetCalories,
        'goalType': activeGoal.type.name,
        'progressPercent': (ratio * 100).toStringAsFixed(0),
        'hourOfDay': now.hour,
      }),
      confidence: 0.86,
      suggestedAction:
          'Review the remaining intake window and decide whether the goal needs one more real meal, not just a small snack.',
    );
  }

  NutritionInsightSignal? _buildHydrationPatternSignal({
    required DateTime now,
    required List<NutritionInsightDaySnapshot> recentDays,
  }) {
    if (recentDays.isEmpty || now.hour < 14) {
      return null;
    }

    final lowDays = recentDays
        .where((day) => day.hydrationMilliliters < 1500)
        .toList(growable: false);
    if (lowDays.length < 3) {
      return null;
    }

    final today = recentDays.first;
    if (today.hydrationMilliliters >= 1200) {
      return null;
    }

    return NutritionInsightSignal(
      id: 'insight-hydration-streak-miss',
      category: InsightCategory.nutrition,
      severity: InsightSeverity.medium,
      title: 'Hydration has been running low for several days',
      shortMessage:
          '${lowDays.length} of the last ${recentDays.length} days landed below 1500 ml, and today is still light.',
      fullExplanation:
          'Forge looked past today and found a short hydration pattern, not just one quiet morning. When fluids stay low across multiple days, recovery and training quality usually feel worse even before the dashboard looks dramatic.',
      evidenceJson: jsonEncode({
        'lowHydrationDays': lowDays.length,
        'daysReviewed': recentDays.length,
        'todayHydrationMilliliters': today.hydrationMilliliters.toStringAsFixed(
          0,
        ),
        'lowDayThresholdMilliliters': 1500,
      }),
      confidence: 0.92,
      suggestedAction:
          'Treat hydration like a streak to recover today: add a larger water block now and another one later instead of relying on random sips.',
    );
  }
}

class NutritionInsightDaySnapshot {
  const NutritionInsightDaySnapshot({
    required this.day,
    required this.totals,
    required this.hydrationMilliliters,
  });

  final DateTime day;
  final NutritionMacros totals;
  final double hydrationMilliliters;
}

class NutritionInsightSignal {
  const NutritionInsightSignal({
    required this.id,
    required this.category,
    required this.severity,
    required this.title,
    required this.shortMessage,
    required this.fullExplanation,
    required this.evidenceJson,
    required this.confidence,
    required this.suggestedAction,
  });

  final String id;
  final InsightCategory category;
  final InsightSeverity severity;
  final String title;
  final String shortMessage;
  final String fullExplanation;
  final String evidenceJson;
  final double confidence;
  final String suggestedAction;
}
