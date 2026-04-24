import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/workout_exercise_entry.dart';
import 'package:forge/domain/entities/workout_session.dart';

final workoutLauncherProvider = Provider<WorkoutLauncher>((ref) {
  return WorkoutLauncher(ref);
});

class WorkoutLauncher {
  WorkoutLauncher(this._ref);

  final Ref _ref;

  Future<WorkoutSession> startEmptyWorkout() {
    return _ref.read(workoutRepositoryProvider).startSession();
  }

  Future<WorkoutSession> startFromTemplate(String templateId) async {
    final repository = _ref.read(workoutRepositoryProvider);
    final uuid = _ref.read(uuidServiceProvider);
    final session = await repository.startSession(templateId: templateId);
    final detail = await repository.getTemplateDetail(templateId);
    final now = DateTime.now();

    if (detail != null) {
      for (final item in detail.items) {
        await repository.saveExerciseEntry(
          WorkoutExerciseEntry(
            id: 'session-entry-${uuid.next()}',
            sessionId: session.id,
            exerciseId: item.exercise.id,
            orderIndex: item.item.orderIndex,
            notes: item.item.notes,
            supersetGroupId: null,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    }

    return session;
  }
}
