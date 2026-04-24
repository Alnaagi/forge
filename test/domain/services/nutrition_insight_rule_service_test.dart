import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/domain/services/nutrition_insight_rule_service.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/value_objects/macro_target.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';

void main() {
  group('NutritionInsightRuleService', () {
    const service = NutritionInsightRuleService();

    test('detects low protein versus the active goal', () {
      final signals = service.evaluate(
        now: DateTime(2026, 4, 21, 18),
        todayTotals: const NutritionMacros(
          calories: 1200,
          protein: 70,
          carbs: 120,
          fat: 35,
        ),
        recentDays: [
          NutritionInsightDaySnapshot(
            day: DateTime(2026, 4, 21),
            totals: const NutritionMacros(
              calories: 1200,
              protein: 70,
              carbs: 120,
              fat: 35,
            ),
            hydrationMilliliters: 1700,
          ),
        ],
        activeGoal: _goal(
          type: GoalType.strength,
          calories: 2800,
          protein: 180,
        ),
      );

      expect(
        signals.any((signal) => signal.id == 'insight-low-protein'),
        isTrue,
      );
    });

    test('detects low calories for a bulk goal late in the day', () {
      final signals = service.evaluate(
        now: DateTime(2026, 4, 21, 19),
        todayTotals: const NutritionMacros(
          calories: 1400,
          protein: 120,
          carbs: 150,
          fat: 40,
        ),
        recentDays: [
          NutritionInsightDaySnapshot(
            day: DateTime(2026, 4, 21),
            totals: const NutritionMacros(
              calories: 1400,
              protein: 120,
              carbs: 150,
              fat: 40,
            ),
            hydrationMilliliters: 1800,
          ),
        ],
        activeGoal: _goal(type: GoalType.bulk, calories: 3000, protein: 170),
      );

      expect(
        signals.any((signal) => signal.id == 'insight-low-calories-for-goal'),
        isTrue,
      );
    });

    test('detects repeated hydration misses across recent days', () {
      final signals = service.evaluate(
        now: DateTime(2026, 4, 21, 15),
        todayTotals: const NutritionMacros(
          calories: 1800,
          protein: 130,
          carbs: 190,
          fat: 55,
        ),
        recentDays: [
          NutritionInsightDaySnapshot(
            day: DateTime(2026, 4, 21),
            totals: const NutritionMacros(
              calories: 1800,
              protein: 130,
              carbs: 190,
              fat: 55,
            ),
            hydrationMilliliters: 900,
          ),
          NutritionInsightDaySnapshot(
            day: DateTime(2026, 4, 20),
            totals: const NutritionMacros(
              calories: 2100,
              protein: 140,
              carbs: 210,
              fat: 60,
            ),
            hydrationMilliliters: 1200,
          ),
          NutritionInsightDaySnapshot(
            day: DateTime(2026, 4, 19),
            totals: const NutritionMacros(
              calories: 2000,
              protein: 150,
              carbs: 200,
              fat: 58,
            ),
            hydrationMilliliters: 1300,
          ),
          NutritionInsightDaySnapshot(
            day: DateTime(2026, 4, 18),
            totals: const NutritionMacros(
              calories: 2200,
              protein: 145,
              carbs: 215,
              fat: 62,
            ),
            hydrationMilliliters: 2000,
          ),
        ],
        activeGoal: null,
      );

      expect(
        signals.any((signal) => signal.id == 'insight-hydration-streak-miss'),
        isTrue,
      );
    });
  });
}

Goal _goal({
  required GoalType type,
  required int calories,
  required double protein,
}) {
  final now = DateTime(2026, 4, 1);
  return Goal(
    id: 'goal-$type',
    type: type,
    macroTarget: MacroTarget(
      calories: calories,
      proteinGrams: protein,
      carbsGrams: 250,
      fatGrams: 70,
    ),
    isActive: true,
    startedAt: now,
    createdAt: now,
    updatedAt: now,
  );
}
