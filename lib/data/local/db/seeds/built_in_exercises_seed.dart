import 'package:forge/domain/entities/exercise.dart';

class BuiltInExercisesSeed {
  const BuiltInExercisesSeed();

  List<Exercise> all() {
    return [
      Exercise(
        id: 'barbell-bench-press',
        name: 'Barbell Bench Press',
        primaryMuscleGroup: 'chest',
        isBuiltIn: true,
        notes: null,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      ),
      Exercise(
        id: 'barbell-squat',
        name: 'Barbell Squat',
        primaryMuscleGroup: 'quads',
        isBuiltIn: true,
        notes: null,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      ),
      Exercise(
        id: 'barbell-deadlift',
        name: 'Barbell Deadlift',
        primaryMuscleGroup: 'posterior_chain',
        isBuiltIn: true,
        notes: null,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      ),
    ];
  }
}
