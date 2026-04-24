import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/features/workouts/presentation/controllers/workout_history_controller.dart';
import 'package:forge/features/workouts/presentation/mappers/workout_display_mapper.dart';
import 'package:go_router/go_router.dart';

class WorkoutHistoryScreen extends ConsumerWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(workoutHistoryProvider);
    final displayMapper = WorkoutDisplayMapper(
      metrics: ref.watch(workoutMetricsServiceProvider),
    );

    return AppScaffold(
      title: 'Workout History',
      eyebrow: 'Archive',
      subtitle:
          'Original logged set values stay intact while canonical volume powers later analytics.',
      child: historyAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const AppPanel(
              child: AppEmptyState(
                icon: Icons.history,
                title: 'No workouts logged yet',
                message:
                    'Completed sessions will stack here with rich summaries and preserved set history.',
              ),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final viewModel = displayMapper.toHistoryItem(item);
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: AppPanel(
                  gradient: index.isEven ? AppColors.bluePanelGradient : null,
                  onTap: () => context.pushNamed(
                    RouteNames.workoutDetail,
                    pathParameters: {'sessionId': item.sessionId},
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        viewModel.dateLabel,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          _HistoryChip(label: viewModel.exerciseCountLabel),
                          _HistoryChip(label: viewModel.setCountLabel),
                          _HistoryChip(
                            label: viewModel.volumeLabel,
                            accent: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        viewModel.subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading workout history'),
      ),
    );
  }
}

class _HistoryChip extends StatelessWidget {
  const _HistoryChip({required this.label, this.accent});

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
