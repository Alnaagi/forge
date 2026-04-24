import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/entities/exercise.dart';
import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_exercise_entry.dart';
import 'package:forge/domain/entities/workout_logged_exercise.dart';
import 'package:forge/domain/entities/workout_session.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/domain/services/training_insight_rule_service.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

void main() {
  group('TrainingInsightRuleService', () {
    const service = TrainingInsightRuleService();

    test('detects a plateau when repeated exposures stay flat', () {
      final now = DateTime(2026, 4, 21);
      final sessions = [
        _session(
          sessionId: 'bench-1',
          startedAt: DateTime(2026, 4, 20),
          exercises: [
            _loggedExercise(
              sessionId: 'bench-1',
              exerciseId: 'bench',
              exerciseName: 'Bench Press',
              muscleGroup: 'chest',
              sets: [_normalSet('s1', 100, 5)],
            ),
          ],
        ),
        _session(
          sessionId: 'bench-2',
          startedAt: DateTime(2026, 4, 14),
          exercises: [
            _loggedExercise(
              sessionId: 'bench-2',
              exerciseId: 'bench',
              exerciseName: 'Bench Press',
              muscleGroup: 'chest',
              sets: [_normalSet('s2', 100.5, 5)],
            ),
          ],
        ),
        _session(
          sessionId: 'bench-3',
          startedAt: DateTime(2026, 4, 8),
          exercises: [
            _loggedExercise(
              sessionId: 'bench-3',
              exerciseId: 'bench',
              exerciseName: 'Bench Press',
              muscleGroup: 'chest',
              sets: [_normalSet('s3', 100, 5)],
            ),
          ],
        ),
      ];

      final signals = service.evaluate(now: now, recentSessions: sessions);

      expect(
        signals.any((signal) => signal.id == 'insight-training-plateau'),
        isTrue,
      );
    });

    test('detects a skipped muscle group when other sessions continue', () {
      final now = DateTime(2026, 4, 21);
      final sessions = [
        _session(
          sessionId: 'push-1',
          startedAt: DateTime(2026, 4, 20),
          exercises: [
            _loggedExercise(
              sessionId: 'push-1',
              exerciseId: 'bench',
              exerciseName: 'Bench Press',
              muscleGroup: 'chest',
              sets: [_normalSet('s1', 90, 6)],
            ),
          ],
        ),
        _session(
          sessionId: 'pull-1',
          startedAt: DateTime(2026, 4, 18),
          exercises: [
            _loggedExercise(
              sessionId: 'pull-1',
              exerciseId: 'row',
              exerciseName: 'Barbell Row',
              muscleGroup: 'back',
              sets: [_normalSet('s2', 80, 8)],
            ),
          ],
        ),
        _session(
          sessionId: 'legs-1',
          startedAt: DateTime(2026, 4, 2),
          exercises: [
            _loggedExercise(
              sessionId: 'legs-1',
              exerciseId: 'squat',
              exerciseName: 'Squat',
              muscleGroup: 'legs',
              sets: [_normalSet('s3', 120, 5)],
            ),
          ],
        ),
        _session(
          sessionId: 'legs-2',
          startedAt: DateTime(2026, 3, 30),
          exercises: [
            _loggedExercise(
              sessionId: 'legs-2',
              exerciseId: 'leg-press',
              exerciseName: 'Leg Press',
              muscleGroup: 'legs',
              sets: [_normalSet('s4', 180, 10)],
            ),
          ],
        ),
      ];

      final signals = service.evaluate(now: now, recentSessions: sessions);

      expect(
        signals.any((signal) => signal.id == 'insight-skipped-muscle-group'),
        isTrue,
      );
    });

    test('detects a deload trigger when recent workload stacks up', () {
      final now = DateTime(2026, 4, 21);
      final sessions = [
        _highVolumeSession('d1', DateTime(2026, 4, 20)),
        _highVolumeSession('d2', DateTime(2026, 4, 18)),
        _highVolumeSession('d3', DateTime(2026, 4, 16)),
        _highVolumeSession('d4', DateTime(2026, 4, 15)),
      ];

      final signals = service.evaluate(now: now, recentSessions: sessions);

      expect(
        signals.any((signal) => signal.id == 'insight-deload-trigger'),
        isTrue,
      );
    });
  });
}

WorkoutSessionDetail _session({
  required String sessionId,
  required DateTime startedAt,
  required List<WorkoutLoggedExercise> exercises,
}) {
  final totalSets = exercises.fold<int>(
    0,
    (sum, exercise) => sum + exercise.sets.length,
  );
  final totalVolume = exercises.fold<double>(
    0,
    (sum, exercise) =>
        sum +
        exercise.sets.fold<double>(
          0,
          (exerciseSum, set) =>
              exerciseSum + ((set.weight?.canonicalKilograms ?? 0) * set.reps),
        ),
  );

  return WorkoutSessionDetail(
    session: WorkoutSession(
      id: sessionId,
      startedAt: startedAt,
      endedAt: startedAt.add(const Duration(hours: 1)),
      createdAt: startedAt,
      updatedAt: startedAt.add(const Duration(hours: 1)),
    ),
    exercises: exercises,
    totalSets: totalSets,
    totalVolumeKilograms: totalVolume,
  );
}

WorkoutLoggedExercise _loggedExercise({
  required String sessionId,
  required String exerciseId,
  required String exerciseName,
  required String muscleGroup,
  required List<SetEntry> sets,
}) {
  final timestamp = sets.first.createdAt;
  return WorkoutLoggedExercise(
    entry: WorkoutExerciseEntry(
      id: 'entry-$sessionId-$exerciseId',
      sessionId: sessionId,
      exerciseId: exerciseId,
      orderIndex: 0,
      createdAt: timestamp,
      updatedAt: timestamp,
    ),
    exercise: Exercise(
      id: exerciseId,
      name: exerciseName,
      primaryMuscleGroup: muscleGroup,
      createdAt: timestamp,
      updatedAt: timestamp,
    ),
    sets: sets,
  );
}

SetEntry _normalSet(String id, double kilograms, int reps) {
  final timestamp = DateTime(2026, 4, 21, 8);
  return SetEntry(
    id: id,
    exerciseEntryId: 'entry-$id',
    setType: SetType.normal,
    orderIndex: 0,
    reps: reps,
    weight: WeightValue(
      originalValue: kilograms,
      originalUnit: WeightUnit.kilograms,
      canonicalKilograms: kilograms,
    ),
    createdAt: timestamp,
    updatedAt: timestamp,
  );
}

WorkoutSessionDetail _highVolumeSession(String sessionId, DateTime startedAt) {
  final sets = List<SetEntry>.generate(
    20,
    (index) => SetEntry(
      id: '$sessionId-set-$index',
      exerciseEntryId: '$sessionId-entry',
      setType: SetType.normal,
      orderIndex: index,
      reps: 8,
      weight: const WeightValue(
        originalValue: 50,
        originalUnit: WeightUnit.kilograms,
        canonicalKilograms: 50,
      ),
      createdAt: startedAt,
      updatedAt: startedAt,
    ),
    growable: false,
  );

  return _session(
    sessionId: sessionId,
    startedAt: startedAt,
    exercises: [
      _loggedExercise(
        sessionId: sessionId,
        exerciseId: 'squat',
        exerciseName: 'Squat',
        muscleGroup: 'legs',
        sets: sets,
      ),
    ],
  );
}
