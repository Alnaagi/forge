import 'package:forge/domain/entities/goal.dart';
import 'package:forge/domain/entities/user_profile.dart';
import 'package:forge/domain/entities/workout_history_item.dart';
import 'package:forge/shared/enums/activity_level.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';

class NutritionTargetPlan {
  const NutritionTargetPlan({
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.explanation,
    required this.recoveryNote,
  });

  final int calories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final String explanation;
  final String recoveryNote;

  NutritionMacros get macros => NutritionMacros(
    calories: calories,
    protein: proteinGrams,
    carbs: carbsGrams,
    fat: fatGrams,
  );
}

class NutritionTargetService {
  const NutritionTargetService();

  NutritionTargetPlan calculate({
    required UserProfile? profile,
    required Goal? activeGoal,
    required double? latestWeightKilograms,
    required List<WorkoutHistoryItem> workoutHistory,
  }) {
    final explicit = activeGoal?.macroTarget;
    if (explicit != null && explicit.calories > 0) {
      return NutritionTargetPlan(
        calories: explicit.calories,
        proteinGrams: explicit.proteinGrams,
        carbsGrams: explicit.carbsGrams,
        fatGrams: explicit.fatGrams,
        explanation: 'Using your saved active goal macros.',
        recoveryNote: _recoveryNote(workoutHistory),
      );
    }

    final weight =
        latestWeightKilograms ?? activeGoal?.targetWeight?.canonicalKilograms;
    if (weight == null || weight <= 0) {
      return const NutritionTargetPlan(
        calories: 2200,
        proteinGrams: 150,
        carbsGrams: 250,
        fatGrams: 70,
        explanation: 'Default starter target until bodyweight is logged.',
        recoveryNote: 'Log bodyweight and workouts for smarter adjustment.',
      );
    }

    final activityFactor = _activityFactor(profile?.activityLevel);
    final goalOffset = _goalOffset(activeGoal?.type);
    final recoveryBoost = _recentHardTraining(workoutHistory) ? 120 : 0;
    final calories =
        ((weight * 24 * activityFactor) + goalOffset + recoveryBoost)
            .round()
            .clamp(1200, 5200);
    final protein = weight * _proteinFactor(activeGoal?.type);
    final fat = (weight * 0.8).clamp(45, 120).toDouble();
    final proteinCalories = protein * 4;
    final fatCalories = fat * 9;
    final carbs = ((calories - proteinCalories - fatCalories) / 4)
        .clamp(80, 650)
        .toDouble();

    return NutritionTargetPlan(
      calories: calories,
      proteinGrams: protein,
      carbsGrams: carbs,
      fatGrams: fat,
      explanation:
          'Calculated from latest bodyweight, activity level, active goal, and recent training.',
      recoveryNote: _recoveryNote(workoutHistory),
    );
  }

  double _activityFactor(ActivityLevel? activityLevel) {
    return switch (activityLevel) {
      ActivityLevel.sedentary => 1.25,
      ActivityLevel.lightlyActive => 1.4,
      ActivityLevel.moderatelyActive || null => 1.55,
      ActivityLevel.veryActive => 1.75,
      ActivityLevel.athlete => 1.95,
    };
  }

  int _goalOffset(GoalType? goalType) {
    return switch (goalType) {
      GoalType.cut => -350,
      GoalType.bulk => 300,
      GoalType.hypertrophy => 180,
      GoalType.strength => 150,
      GoalType.endurance => 120,
      GoalType.recomp => -100,
      GoalType.maintain || GoalType.custom || null => 0,
    };
  }

  double _proteinFactor(GoalType? goalType) {
    return switch (goalType) {
      GoalType.cut || GoalType.recomp => 2.1,
      GoalType.hypertrophy || GoalType.strength => 2.0,
      GoalType.bulk => 1.8,
      GoalType.endurance => 1.6,
      GoalType.maintain || GoalType.custom || null => 1.7,
    };
  }

  bool _recentHardTraining(List<WorkoutHistoryItem> history) {
    if (history.isEmpty) {
      return false;
    }
    final latest = history.first.startedAt.toLocal();
    return DateTime.now().difference(latest).inHours <= 24;
  }

  String _recoveryNote(List<WorkoutHistoryItem> history) {
    return _recentHardTraining(history)
        ? 'Recent training detected: target includes a small recovery fuel bump.'
        : 'No hard session detected in the last 24 hours.';
  }
}
