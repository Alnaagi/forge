import 'package:forge/shared/enums/activity_level.dart';
import 'package:forge/shared/enums/goal_type.dart';

class GoalRecommendation {
  const GoalRecommendation({
    required this.headline,
    required this.dietFocus,
    required this.trainingFocus,
    required this.templateName,
    required this.templateNotes,
    required this.exercises,
  });

  final String headline;
  final String dietFocus;
  final String trainingFocus;
  final String templateName;
  final String templateNotes;
  final List<GoalTemplateExercise> exercises;
}

class GoalTemplateExercise {
  const GoalTemplateExercise({
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.notes,
  });

  final String exerciseId;
  final int sets;
  final String reps;
  final String notes;
}

class GoalRecommendationService {
  const GoalRecommendationService();

  GoalRecommendation recommendationFor({
    required GoalType goalType,
    required ActivityLevel activityLevel,
  }) {
    final activityNote = switch (activityLevel) {
      ActivityLevel.sedentary || ActivityLevel.lightlyActive =>
        'Start conservative and build weekly consistency.',
      ActivityLevel.moderatelyActive =>
        'Use steady progression with recovery days.',
      ActivityLevel.veryActive || ActivityLevel.athlete =>
        'Watch recovery and avoid stacking hard days too tightly.',
    };

    final base = switch (goalType) {
      GoalType.cut => _cut,
      GoalType.bulk => _bulk,
      GoalType.recomp => _recomp,
      GoalType.hypertrophy => _hypertrophy,
      GoalType.strength => _strength,
      GoalType.endurance => _endurance,
      GoalType.maintain => _maintain,
      GoalType.custom => _custom,
    };

    return GoalRecommendation(
      headline: base.headline,
      dietFocus: '${base.dietFocus} $activityNote',
      trainingFocus: base.trainingFocus,
      templateName: base.templateName,
      templateNotes: base.templateNotes,
      exercises: base.exercises,
    );
  }

  static const _cut = GoalRecommendation(
    headline: 'Cut: preserve strength while weight trends down.',
    dietFocus:
        'Prioritize protein, high-volume foods, water, and a modest calorie deficit.',
    trainingFocus:
        'Keep compounds heavy enough to protect muscle, with controlled accessory volume.',
    templateName: 'Forge Cut Strength Base',
    templateNotes:
        'Goal preset: cut. Keep effort honest, avoid junk volume, and track recovery.',
    exercises: [
      GoalTemplateExercise(
        exerciseId: 'barbell-squat',
        sets: 3,
        reps: '5-8',
        notes: 'Controlled heavy work',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-bench-press',
        sets: 3,
        reps: '5-8',
        notes: 'Preserve pressing strength',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-row',
        sets: 3,
        reps: '8-12',
        notes: 'Back volume and posture',
      ),
    ],
  );

  static const _bulk = GoalRecommendation(
    headline: 'Bulk: grow with measurable surplus and progressive volume.',
    dietFocus:
        'Use a small calorie surplus, protein at each meal, and carbs around hard sessions.',
    trainingFocus:
        'Push progressive overload with enough weekly volume to grow.',
    templateName: 'Forge Lean Bulk Builder',
    templateNotes:
        'Goal preset: bulk. Add load or reps slowly and keep food consistent.',
    exercises: [
      GoalTemplateExercise(
        exerciseId: 'barbell-squat',
        sets: 4,
        reps: '6-10',
        notes: 'Primary lower growth lift',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-bench-press',
        sets: 4,
        reps: '6-10',
        notes: 'Pressing progression',
      ),
      GoalTemplateExercise(
        exerciseId: 'lat-pulldown',
        sets: 4,
        reps: '8-12',
        notes: 'Upper back volume',
      ),
    ],
  );

  static const _recomp = GoalRecommendation(
    headline: 'Recomp: build strength while tightening body composition.',
    dietFocus:
        'Keep calories near maintenance, protein high, and use waist/weight trends together.',
    trainingFocus: 'Blend strength practice with hypertrophy accessories.',
    templateName: 'Forge Recomp Split',
    templateNotes:
        'Goal preset: recomp. Watch waist, strength, and consistency together.',
    exercises: [
      GoalTemplateExercise(
        exerciseId: 'barbell-deadlift',
        sets: 3,
        reps: '3-6',
        notes: 'Strength anchor',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-bench-press',
        sets: 3,
        reps: '6-10',
        notes: 'Upper push',
      ),
      GoalTemplateExercise(
        exerciseId: 'dumbbell-lunge',
        sets: 3,
        reps: '8-12/side',
        notes: 'Single-leg volume',
      ),
    ],
  );

  static const _hypertrophy = GoalRecommendation(
    headline: 'Hypertrophy: chase quality volume and muscle tension.',
    dietFocus:
        'Protein stays high; calories should support performance and recovery.',
    trainingFocus:
        'Use moderate reps, stable technique, and enough weekly sets per muscle.',
    templateName: 'Forge Hypertrophy Starter',
    templateNotes:
        'Goal preset: hypertrophy. Own the reps, track pumps and progression.',
    exercises: [
      GoalTemplateExercise(
        exerciseId: 'barbell-bench-press',
        sets: 4,
        reps: '8-12',
        notes: 'Controlled chest volume',
      ),
      GoalTemplateExercise(
        exerciseId: 'lat-pulldown',
        sets: 4,
        reps: '10-15',
        notes: 'Full stretch and squeeze',
      ),
      GoalTemplateExercise(
        exerciseId: 'leg-press',
        sets: 4,
        reps: '10-15',
        notes: 'Hard quad volume',
      ),
    ],
  );

  static const _strength = GoalRecommendation(
    headline: 'Strength: practice heavy basics with clean recovery.',
    dietFocus:
        'Fuel sessions with enough carbs and protein; avoid aggressive dieting.',
    trainingFocus:
        'Lower rep compounds, longer rest, and clear top-set progress.',
    templateName: 'Forge Strength Base',
    templateNotes:
        'Goal preset: strength. Prioritize clean heavy reps and rest quality.',
    exercises: [
      GoalTemplateExercise(
        exerciseId: 'barbell-squat',
        sets: 5,
        reps: '3-5',
        notes: 'Main strength lift',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-bench-press',
        sets: 5,
        reps: '3-5',
        notes: 'Main press',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-deadlift',
        sets: 3,
        reps: '3-5',
        notes: 'Heavy pull',
      ),
    ],
  );

  static const _endurance = GoalRecommendation(
    headline: 'Endurance: build repeatable work capacity.',
    dietFocus:
        'Hydration, electrolytes, and carbs around longer sessions matter most.',
    trainingFocus:
        'Use lighter resistance circuits and consistency over max loading.',
    templateName: 'Forge Conditioning Base',
    templateNotes:
        'Goal preset: endurance. Keep rests honest and track repeatability.',
    exercises: [
      GoalTemplateExercise(
        exerciseId: 'goblet-squat',
        sets: 3,
        reps: '12-20',
        notes: 'Smooth circuit pace',
      ),
      GoalTemplateExercise(
        exerciseId: 'push-up',
        sets: 3,
        reps: 'AMRAP clean',
        notes: 'Stop before form breaks',
      ),
      GoalTemplateExercise(
        exerciseId: 'plank',
        sets: 3,
        reps: '30-60 sec',
        notes: 'Brace and breathe',
      ),
    ],
  );

  static const _maintain = GoalRecommendation(
    headline: 'Maintain: keep strength, routine, and body metrics stable.',
    dietFocus:
        'Use maintenance calories, regular protein, and stable hydration.',
    trainingFocus:
        'Use balanced full-body work with enough intensity to stay sharp.',
    templateName: 'Forge Maintenance Full Body',
    templateNotes:
        'Goal preset: maintain. Keep the rhythm simple and repeatable.',
    exercises: [
      GoalTemplateExercise(
        exerciseId: 'barbell-squat',
        sets: 3,
        reps: '5-8',
        notes: 'Lower anchor',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-bench-press',
        sets: 3,
        reps: '6-10',
        notes: 'Upper push',
      ),
      GoalTemplateExercise(
        exerciseId: 'lat-pulldown',
        sets: 3,
        reps: '8-12',
        notes: 'Upper pull',
      ),
    ],
  );

  static const _custom = GoalRecommendation(
    headline: 'Custom: start with a balanced base, then tune it.',
    dietFocus:
        'Track calories, protein, water, and body metrics until the pattern is clear.',
    trainingFocus:
        'Begin with a balanced full-body template and adjust from evidence.',
    templateName: 'Forge Custom Starter',
    templateNotes:
        'Goal preset: custom. Treat this as a clean baseline template.',
    exercises: [
      GoalTemplateExercise(
        exerciseId: 'barbell-squat',
        sets: 3,
        reps: '5-8',
        notes: 'Lower body base',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-bench-press',
        sets: 3,
        reps: '6-10',
        notes: 'Upper push base',
      ),
      GoalTemplateExercise(
        exerciseId: 'barbell-row',
        sets: 3,
        reps: '8-12',
        notes: 'Upper pull base',
      ),
    ],
  );
}
