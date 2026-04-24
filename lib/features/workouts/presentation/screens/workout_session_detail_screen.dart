import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/features/workouts/presentation/controllers/workout_history_controller.dart';
import 'package:forge/features/workouts/presentation/mappers/workout_display_mapper.dart';

class WorkoutSessionDetailScreen extends ConsumerWidget {
  const WorkoutSessionDetailScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(workoutSessionDetailProvider(sessionId));
    final displayMapper = WorkoutDisplayMapper(
      metrics: ref.watch(workoutMetricsServiceProvider),
    );

    return AppScaffold(
      title: 'Workout Detail',
      eyebrow: 'Session Review',
      subtitle:
          'History preserves the exact units you entered, even when later analytics normalize by kilograms.',
      child: detailAsync.when(
        data: (detail) {
          if (detail == null) {
            return const AppPanel(
              child: AppEmptyState(
                icon: Icons.search_off,
                title: 'Workout not found',
                message:
                    'This session may have been removed or never completed.',
              ),
            );
          }
          final overview = displayMapper.toSessionOverview(detail);

          return ListView(
            children: [
              AppPanel(
                gradient: AppColors.bluePanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overview.headerTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _OverviewChip(label: overview.startedAtLabel),
                        _OverviewChip(label: overview.durationLabel),
                        _OverviewChip(label: overview.exerciseCountLabel),
                        _OverviewChip(label: overview.setCountLabel),
                        _OverviewChip(
                          label: overview.volumeLabel,
                          accent: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final loggedExercise in detail.exercises) ...[
                AppPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loggedExercise.exercise.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${loggedExercise.sets.length} sets logged',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      for (final entry in loggedExercise.sets.asMap().entries)
                        Builder(
                          builder: (context) {
                            final row = displayMapper.toSetDisplay(
                              entry.value,
                              displayIndex: entry.key + 1,
                            );
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    entry.key == loggedExercise.sets.length - 1
                                    ? 0
                                    : AppSpacing.sm,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHigh,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 34,
                                      child: Text(
                                        row.indexLabel,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelLarge,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(row.summaryLabel),
                                          const SizedBox(
                                            height: AppSpacing.xxs,
                                          ),
                                          Text(
                                            row.metaLabel,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Text(
                                      row.estimatedOneRepMaxLabel,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading workout detail'),
      ),
    );
  }
}

class _OverviewChip extends StatelessWidget {
  const _OverviewChip({required this.label, this.accent});

  final String label;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final resolvedAccent = accent ?? Theme.of(context).colorScheme.secondary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: resolvedAccent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: resolvedAccent),
      ),
    );
  }
}
