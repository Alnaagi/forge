import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/constants/app_constants.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/exercise.dart';
import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_exercise_entry.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class LiveWorkoutState {
  const LiveWorkoutState({
    required this.detail,
    required this.restTimerRemainingSeconds,
    required this.isRestTimerRunning,
    required this.personalRecordCount,
  });

  final WorkoutSessionDetail detail;
  final int restTimerRemainingSeconds;
  final bool isRestTimerRunning;
  final int personalRecordCount;

  LiveWorkoutState copyWith({
    WorkoutSessionDetail? detail,
    int? restTimerRemainingSeconds,
    bool? isRestTimerRunning,
    int? personalRecordCount,
  }) {
    return LiveWorkoutState(
      detail: detail ?? this.detail,
      restTimerRemainingSeconds:
          restTimerRemainingSeconds ?? this.restTimerRemainingSeconds,
      isRestTimerRunning: isRestTimerRunning ?? this.isRestTimerRunning,
      personalRecordCount: personalRecordCount ?? this.personalRecordCount,
    );
  }
}

final liveWorkoutControllerProvider = AsyncNotifierProvider.autoDispose
    .family<LiveWorkoutController, LiveWorkoutState, String>(
      LiveWorkoutController.new,
    );

class LiveWorkoutController
    extends AutoDisposeFamilyAsyncNotifier<LiveWorkoutState, String> {
  Timer? _restTimer;
  late String _sessionId;

  @override
  Future<LiveWorkoutState> build(String sessionId) async {
    _sessionId = sessionId;
    ref.onDispose(() => _restTimer?.cancel());

    final detail = await ref
        .read(workoutRepositoryProvider)
        .getSessionDetail(sessionId);
    if (detail == null) {
      throw StateError('Workout session $sessionId was not found.');
    }

    return LiveWorkoutState(
      detail: detail,
      restTimerRemainingSeconds: 0,
      isRestTimerRunning: false,
      personalRecordCount: 0,
    );
  }

  Future<void> addExercise(Exercise exercise, {String? supersetGroupId}) async {
    final current = state.requireValue;
    final repository = ref.read(workoutRepositoryProvider);
    final uuid = ref.read(uuidServiceProvider);
    final now = DateTime.now();

    await repository.saveExerciseEntry(
      WorkoutExerciseEntry(
        id: 'session-entry-${uuid.next()}',
        sessionId: current.detail.session.id,
        exerciseId: exercise.id,
        orderIndex: current.detail.exercises.length,
        notes: null,
        supersetGroupId: supersetGroupId,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await _reload();
  }

  Future<bool> addSet({
    required String exerciseEntryId,
    required int reps,
    required SetType setType,
    double? originalWeightValue,
    WeightUnit? weightUnit,
    double? rpe,
    String? tempo,
    int? restSeconds,
    String? notes,
  }) async {
    final current = state.requireValue;
    final repository = ref.read(workoutRepositoryProvider);
    final uuid = ref.read(uuidServiceProvider);
    final metrics = ref.read(workoutMetricsServiceProvider);
    final now = DateTime.now();

    final loggedExercise = current.detail.exercises.firstWhere(
      (exercise) => exercise.entry.id == exerciseEntryId,
    );

    final setEntry = SetEntry(
      id: 'set-${uuid.next()}',
      exerciseEntryId: exerciseEntryId,
      setType: setType,
      orderIndex: loggedExercise.sets.isEmpty
          ? 0
          : loggedExercise.sets
                    .map((set) => set.orderIndex)
                    .reduce((a, b) => a > b ? a : b) +
                1,
      reps: reps,
      weight: originalWeightValue != null && weightUnit != null
          ? metrics.createWeightValue(
              originalValue: originalWeightValue,
              originalUnit: weightUnit,
            )
          : null,
      rpe: rpe,
      tempo: tempo?.trim().isEmpty ?? true ? null : tempo?.trim(),
      restSeconds: restSeconds,
      notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
      createdAt: now,
      updatedAt: now,
    );

    final shouldCheckForPr =
        setEntry.weight != null && setEntry.setType == SetType.normal;
    final previousSets = shouldCheckForPr
        ? await repository.getSetHistoryForExercise(loggedExercise.exercise.id)
        : const <SetEntry>[];
    final isPr =
        shouldCheckForPr &&
        metrics.isPersonalRecord(
          candidate: setEntry,
          previousSets: previousSets,
        );

    await repository.saveSet(setEntry);
    await _reload(
      restSeconds: restSeconds ?? AppConstants.restTimerDefaultSeconds,
      addPersonalRecord: isPr ? 1 : 0,
    );
    return isPr;
  }

  Future<bool> repeatLastSet(String exerciseEntryId) async {
    final current = state.requireValue;
    final loggedExercise = current.detail.exercises.firstWhere(
      (exercise) => exercise.entry.id == exerciseEntryId,
    );
    final sourceSet = loggedExercise.sets.isNotEmpty
        ? loggedExercise.sets.last
        : await ref
              .read(workoutRepositoryProvider)
              .getLastSetForExercise(loggedExercise.exercise.id);

    if (sourceSet == null) {
      return false;
    }

    return addSet(
      exerciseEntryId: exerciseEntryId,
      reps: sourceSet.reps,
      setType: sourceSet.setType,
      originalWeightValue: sourceSet.weight?.originalValue,
      weightUnit: sourceSet.weight?.originalUnit,
      rpe: sourceSet.rpe,
      tempo: sourceSet.tempo,
      restSeconds: sourceSet.restSeconds,
      notes: sourceSet.notes,
    );
  }

  Future<bool> updateSet({
    required String exerciseId,
    required SetEntry existingSet,
    required int reps,
    required SetType setType,
    double? originalWeightValue,
    WeightUnit? weightUnit,
    double? rpe,
    String? tempo,
    int? restSeconds,
    String? notes,
  }) async {
    final repository = ref.read(workoutRepositoryProvider);
    final metrics = ref.read(workoutMetricsServiceProvider);

    final updatedSet = existingSet.copyWith(
      setType: setType,
      reps: reps,
      weight: originalWeightValue != null && weightUnit != null
          ? metrics.createWeightValue(
              originalValue: originalWeightValue,
              originalUnit: weightUnit,
            )
          : null,
      rpe: rpe,
      tempo: tempo?.trim().isEmpty ?? true ? null : tempo?.trim(),
      restSeconds: restSeconds,
      notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
      updatedAt: DateTime.now(),
    );

    final shouldCheckForPr =
        updatedSet.weight != null && updatedSet.setType == SetType.normal;
    final previousSets = shouldCheckForPr
        ? (await repository.getSetHistoryForExercise(
            exerciseId,
          )).where((set) => set.id != existingSet.id).toList(growable: false)
        : const <SetEntry>[];
    final isPr =
        shouldCheckForPr &&
        metrics.isPersonalRecord(
          candidate: updatedSet,
          previousSets: previousSets,
        );

    await repository.saveSet(updatedSet);
    await _reload(restSeconds: restSeconds, addPersonalRecord: isPr ? 1 : 0);
    return isPr;
  }

  Future<void> deleteSet(String setId) async {
    await ref.read(workoutRepositoryProvider).deleteSet(setId);
    await _reload(clearTimer: true);
  }

  Future<WorkoutSessionDetail?> completeWorkout({String? notes}) async {
    _restTimer?.cancel();
    final repository = ref.read(workoutRepositoryProvider);
    await repository.completeSession(
      sessionId: _sessionId,
      notes: notes,
      endedAt: DateTime.now(),
    );
    await _reload(clearTimer: true);
    return ref.read(workoutRepositoryProvider).getSessionDetail(_sessionId);
  }

  void pauseRestTimer() {
    _restTimer?.cancel();
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(current.copyWith(isRestTimerRunning: false));
  }

  void resumeRestTimer() {
    final current = state.valueOrNull;
    if (current == null || current.restTimerRemainingSeconds <= 0) {
      return;
    }
    _startRestTimer(current.restTimerRemainingSeconds);
  }

  void resetRestTimer() {
    _restTimer?.cancel();
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(
      current.copyWith(restTimerRemainingSeconds: 0, isRestTimerRunning: false),
    );
  }

  Future<void> _reload({
    int? restSeconds,
    int addPersonalRecord = 0,
    bool clearTimer = false,
  }) async {
    final repository = ref.read(workoutRepositoryProvider);
    final current = state.valueOrNull;
    final detail = await repository.getSessionDetail(_sessionId);
    if (detail == null || current == null) {
      return;
    }

    if (clearTimer) {
      _restTimer?.cancel();
      state = AsyncData(
        current.copyWith(
          detail: detail,
          restTimerRemainingSeconds: 0,
          isRestTimerRunning: false,
          personalRecordCount: current.personalRecordCount + addPersonalRecord,
        ),
      );
      return;
    }

    state = AsyncData(
      current.copyWith(
        detail: detail,
        personalRecordCount: current.personalRecordCount + addPersonalRecord,
      ),
    );

    if (restSeconds != null && restSeconds > 0) {
      _startRestTimer(restSeconds);
    }
  }

  void _startRestTimer(int seconds) {
    _restTimer?.cancel();
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        restTimerRemainingSeconds: seconds,
        isRestTimerRunning: true,
      ),
    );

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final snapshot = state.valueOrNull;
      if (snapshot == null) {
        timer.cancel();
        return;
      }
      final next = snapshot.restTimerRemainingSeconds - 1;
      if (next <= 0) {
        timer.cancel();
        state = AsyncData(
          snapshot.copyWith(
            restTimerRemainingSeconds: 0,
            isRestTimerRunning: false,
          ),
        );
      } else {
        state = AsyncData(
          snapshot.copyWith(
            restTimerRemainingSeconds: next,
            isRestTimerRunning: true,
          ),
        );
      }
    });
  }
}
