import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/features/workouts/presentation/controllers/live_workout_controller.dart';
import 'package:forge/features/workouts/presentation/widgets/exercise_picker_sheet.dart';
import 'package:forge/features/workouts/presentation/widgets/rest_timer_card.dart';
import 'package:forge/features/workouts/presentation/widgets/session_summary_sheet.dart';
import 'package:forge/features/workouts/presentation/widgets/set_logger_card.dart';
import 'package:go_router/go_router.dart';

class LiveWorkoutScreen extends ConsumerWidget {
  const LiveWorkoutScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(liveWorkoutControllerProvider(sessionId));

    return AppScaffold(
      title: 'Live Workout',
      eyebrow: 'Training Floor',
      subtitle:
          'Fast logging, mixed-unit safe sets, and real local-first session state.',
      child: stateAsync.when(
        data: (state) {
          final controller = ref.read(
            liveWorkoutControllerProvider(sessionId).notifier,
          );

          return ListView(
            children: [
              AppPanel(
                gradient: state.personalRecordCount > 0
                    ? AppColors.orangePanelGradient
                    : AppColors.bluePanelGradient,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.personalRecordCount > 0
                                ? '${state.personalRecordCount} PRs this session'
                                : 'Log your session set by set',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            state.detail.exercises.isEmpty
                                ? 'Add an exercise to open the session.'
                                : '${state.detail.exercises.length} exercises in progress',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () => _finishWorkout(context, ref, sessionId),
                      child: const Text('Finish'),
                    ),
                  ],
                ),
              ),
              if (state.restTimerRemainingSeconds > 0) ...[
                const SizedBox(height: AppSpacing.md),
                RestTimerCard(
                  remainingSeconds: state.restTimerRemainingSeconds,
                  isRunning: state.isRestTimerRunning,
                  onPause: controller.pauseRestTimer,
                  onResume: controller.resumeRestTimer,
                  onReset: controller.resetRestTimer,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              FilledButton.icon(
                onPressed: () => _pickExercise(context, ref, sessionId),
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
              ),
              const SizedBox(height: AppSpacing.md),
              if (state.detail.exercises.isEmpty)
                const AppPanel(
                  child: AppEmptyState(
                    icon: Icons.fitness_center,
                    title: 'No exercises added yet',
                    message:
                        'Pick an exercise to start logging sets, rest, and PR checks.',
                  ),
                ),
              for (final loggedExercise in state.detail.exercises) ...[
                SetLoggerCard(
                  loggedExercise: loggedExercise,
                  onAddSet:
                      ({
                        required reps,
                        required setType,
                        originalWeightValue,
                        weightUnit,
                        rpe,
                        tempo,
                        restSeconds,
                        notes,
                      }) {
                        return controller.addSet(
                          exerciseEntryId: loggedExercise.entry.id,
                          reps: reps,
                          setType: setType,
                          originalWeightValue: originalWeightValue,
                          weightUnit: weightUnit,
                          rpe: rpe,
                          tempo: tempo,
                          restSeconds: restSeconds,
                          notes: notes,
                        );
                      },
                  onRepeatLastSet: () {
                    return controller.repeatLastSet(loggedExercise.entry.id);
                  },
                  onUpdateSet:
                      ({
                        required existingSet,
                        required reps,
                        required setType,
                        originalWeightValue,
                        weightUnit,
                        rpe,
                        tempo,
                        restSeconds,
                        notes,
                      }) {
                        return controller.updateSet(
                          exerciseId: loggedExercise.exercise.id,
                          existingSet: existingSet,
                          reps: reps,
                          setType: setType,
                          originalWeightValue: originalWeightValue,
                          weightUnit: weightUnit,
                          rpe: rpe,
                          tempo: tempo,
                          restSeconds: restSeconds,
                          notes: notes,
                        );
                      },
                  onDeleteSet: (set) => controller.deleteSet(set.id),
                  onAddSupersetExercise: () {
                    _pickExercise(
                      context,
                      ref,
                      sessionId,
                      supersetGroupId:
                          loggedExercise.entry.supersetGroupId ??
                          'superset-${loggedExercise.entry.id}',
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading live workout'),
      ),
    );
  }

  Future<void> _pickExercise(
    BuildContext context,
    WidgetRef ref,
    String sessionId, {
    String? supersetGroupId,
  }) async {
    final exercise = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SizedBox(
        height: 560,
        child: ExercisePickerSheet(title: 'Add Exercise'),
      ),
    );

    if (exercise == null || !context.mounted) {
      return;
    }

    await ref
        .read(liveWorkoutControllerProvider(sessionId).notifier)
        .addExercise(exercise, supersetGroupId: supersetGroupId);
  }

  Future<void> _finishWorkout(
    BuildContext context,
    WidgetRef ref,
    String sessionId,
  ) async {
    final detail = await ref
        .read(liveWorkoutControllerProvider(sessionId).notifier)
        .completeWorkout();
    final snapshot = ref
        .read(liveWorkoutControllerProvider(sessionId))
        .valueOrNull;

    if (detail == null || snapshot == null || !context.mounted) {
      return;
    }

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SessionSummarySheet(
        detail: detail,
        personalRecordCount: snapshot.personalRecordCount,
        onViewSession: () {
          Navigator.of(context).pop();
        },
      ),
    );

    if (!context.mounted) {
      return;
    }

    context.goNamed(
      RouteNames.workoutDetail,
      pathParameters: {'sessionId': sessionId},
    );
  }
}
