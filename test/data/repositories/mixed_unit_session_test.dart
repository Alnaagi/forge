import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/daos/exercise_dao.dart';
import 'package:forge/data/local/db/daos/workout_dao.dart';
import 'package:forge/data/repositories/exercise_repository_impl.dart';
import 'package:forge/data/repositories/workout_repository_impl.dart';
import 'package:forge/domain/entities/exercise.dart';
import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_exercise_entry.dart';
import 'package:forge/domain/services/e1rm_service.dart';
import 'package:forge/domain/services/pr_detection_service.dart';
import 'package:forge/domain/services/volume_service.dart';
import 'package:forge/domain/services/workout_metrics_service.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';

void main() {
  late AppDatabase database;
  late ExerciseRepositoryImpl exerciseRepository;
  late WorkoutRepositoryImpl workoutRepository;
  const metrics = WorkoutMetricsService(
    unitConverter: UnitConverter(),
    e1rmService: E1rmService(),
    volumeService: VolumeService(),
    prDetectionService: PrDetectionService(),
  );

  setUp(() {
    database = AppDatabase.test(NativeDatabase.memory());
    final exerciseDao = ExerciseDao(database);
    final workoutDao = WorkoutDao(database);
    exerciseRepository = ExerciseRepositoryImpl(exerciseDao);
    workoutRepository = WorkoutRepositoryImpl(workoutDao);
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'preserves original unit values and sums canonical kilograms in mixed-unit sessions',
    () async {
      final now = DateTime(2026, 4, 13, 9);
      final exercise = Exercise(
        id: 'bench',
        name: 'Bench Press',
        primaryMuscleGroup: 'chest',
        isBuiltIn: false,
        notes: null,
        createdAt: now,
        updatedAt: now,
      );
      await exerciseRepository.upsert(exercise);

      final session = await workoutRepository.startSession();
      final entry = WorkoutExerciseEntry(
        id: 'entry-1',
        sessionId: session.id,
        exerciseId: exercise.id,
        orderIndex: 0,
        notes: null,
        supersetGroupId: null,
        createdAt: now,
        updatedAt: now,
      );
      await workoutRepository.saveExerciseEntry(entry);

      await workoutRepository.saveSet(
        SetEntry(
          id: 'set-1',
          exerciseEntryId: entry.id,
          setType: SetType.normal,
          orderIndex: 0,
          reps: 5,
          weight: metrics.createWeightValue(
            originalValue: 100,
            originalUnit: WeightUnit.kilograms,
          ),
          rpe: 8,
          tempo: null,
          restSeconds: 90,
          notes: null,
          createdAt: now,
          updatedAt: now,
        ),
      );
      await workoutRepository.saveSet(
        SetEntry(
          id: 'set-2',
          exerciseEntryId: entry.id,
          setType: SetType.normal,
          orderIndex: 1,
          reps: 5,
          weight: metrics.createWeightValue(
            originalValue: 225,
            originalUnit: WeightUnit.pounds,
          ),
          rpe: 9,
          tempo: null,
          restSeconds: 120,
          notes: null,
          createdAt: now,
          updatedAt: now,
        ),
      );

      final detail = await workoutRepository.getSessionDetail(session.id);

      expect(detail, isNotNull);
      final sets = detail!.exercises.single.sets;
      expect(sets[0].weight!.originalValue, 100);
      expect(sets[0].weight!.originalUnit, WeightUnit.kilograms);
      expect(sets[1].weight!.originalValue, 225);
      expect(sets[1].weight!.originalUnit, WeightUnit.pounds);
      expect(detail.totalVolumeKilograms, closeTo(100 * 5 + 102.058 * 5, 0.01));
    },
  );

  test(
    'preserves session notes when completion omits a replacement note',
    () async {
      final session = await workoutRepository.startSession(notes: 'Push day');

      await workoutRepository.completeSession(
        sessionId: session.id,
        endedAt: DateTime(2026, 4, 13, 10),
      );

      final completed = await workoutRepository.getSession(session.id);

      expect(completed, isNotNull);
      expect(completed!.notes, 'Push day');
      expect(completed.endedAt, isNotNull);
    },
  );

  test(
    'rejects exercise and set writes after a session is completed',
    () async {
      final now = DateTime(2026, 4, 13, 11);
      final exercise = Exercise(
        id: 'squat',
        name: 'Back Squat',
        primaryMuscleGroup: 'legs',
        isBuiltIn: false,
        notes: null,
        createdAt: now,
        updatedAt: now,
      );
      await exerciseRepository.upsert(exercise);

      final session = await workoutRepository.startSession();
      final entry = WorkoutExerciseEntry(
        id: 'entry-closed',
        sessionId: session.id,
        exerciseId: exercise.id,
        orderIndex: 0,
        notes: null,
        supersetGroupId: null,
        createdAt: now,
        updatedAt: now,
      );
      await workoutRepository.saveExerciseEntry(entry);
      await workoutRepository.completeSession(
        sessionId: session.id,
        endedAt: now.add(const Duration(hours: 1)),
      );

      await expectLater(
        workoutRepository.saveExerciseEntry(
          WorkoutExerciseEntry(
            id: 'entry-too-late',
            sessionId: session.id,
            exerciseId: exercise.id,
            orderIndex: 1,
            notes: null,
            supersetGroupId: null,
            createdAt: now,
            updatedAt: now,
          ),
        ),
        throwsA(isA<StateError>()),
      );

      await expectLater(
        workoutRepository.saveSet(
          SetEntry(
            id: 'set-too-late',
            exerciseEntryId: entry.id,
            setType: SetType.normal,
            orderIndex: 0,
            reps: 5,
            weight: metrics.createWeightValue(
              originalValue: 100,
              originalUnit: WeightUnit.kilograms,
            ),
            rpe: null,
            tempo: null,
            restSeconds: 120,
            notes: null,
            createdAt: now,
            updatedAt: now,
          ),
        ),
        throwsA(isA<StateError>()),
      );
    },
  );
}
