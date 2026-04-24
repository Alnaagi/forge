import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/features/templates/presentation/controllers/template_list_controller.dart';
import 'package:forge/features/workouts/presentation/controllers/workout_history_controller.dart';
import 'package:forge/features/workouts/presentation/controllers/workout_launcher.dart';
import 'package:forge/features/workouts/presentation/mappers/workout_display_mapper.dart';
import 'package:go_router/go_router.dart';

class WorkoutsHomeScreen extends ConsumerWidget {
  const WorkoutsHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(workoutHistoryProvider);
    final templatesAsync = ref.watch(workoutTemplatesProvider);
    final displayMapper = WorkoutDisplayMapper(
      metrics: ref.watch(workoutMetricsServiceProvider),
    );

    return AppScaffold(
      title: 'Workouts',
      eyebrow: 'Training',
      subtitle:
          'Live sessions, templates, and history stay local-first and mixed-unit safe.',
      child: ListView(
        children: [
          AppPanel(
            gradient: AppColors.bluePanelGradient,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Session Control',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Start clean, jump from a template, or dive back into your recent logbook.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                FilledButton.icon(
                  onPressed: () async {
                    final session = await ref
                        .read(workoutLauncherProvider)
                        .startEmptyWorkout();
                    if (!context.mounted) {
                      return;
                    }
                    context.pushNamed(
                      RouteNames.liveWorkout,
                      pathParameters: {'sessionId': session.id},
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Empty Workout'),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    OutlinedButton(
                      onPressed: () =>
                          context.pushNamed(RouteNames.templateList),
                      child: const Text('Templates'),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          context.pushNamed(RouteNames.exerciseLibrary),
                      child: const Text('Exercise Library'),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          context.pushNamed(RouteNames.workoutHistory),
                      child: const Text('History'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionTitle(title: 'Recent Templates'),
          const SizedBox(height: AppSpacing.sm),
          templatesAsync.when(
            data: (templates) {
              if (templates.isEmpty) {
                return const AppPanel(
                  child: AppEmptyState(
                    icon: Icons.copy_all_outlined,
                    title: 'No templates yet',
                    message:
                        'Build repeatable sessions once you have a structure you want to keep reusing.',
                  ),
                );
              }
              return Column(
                children: templates
                    .take(3)
                    .map((detail) {
                      final exerciseCount = displayMapper
                          .templateExerciseCountLabel(detail.items.length);
                      return Card(
                        child: ListTile(
                          title: Text(detail.template.name),
                          subtitle: Text(exerciseCount),
                          trailing: FilledButton.tonal(
                            onPressed: () async {
                              final session = await ref
                                  .read(workoutLauncherProvider)
                                  .startFromTemplate(detail.template.id);
                              if (!context.mounted) {
                                return;
                              }
                              context.pushNamed(
                                RouteNames.liveWorkout,
                                pathParameters: {'sessionId': session.id},
                              );
                            },
                            child: const Text('Launch'),
                          ),
                        ),
                      );
                    })
                    .toList(growable: false),
              );
            },
            error: (error, stackTrace) =>
                AppPanel(child: AppErrorState(message: error.toString())),
            loading: () => const AppPanel(
              child: SizedBox(
                height: 132,
                child: AppLoadingView(label: 'Loading templates'),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle(title: 'Recent Sessions'),
          const SizedBox(height: AppSpacing.sm),
          historyAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return const AppPanel(
                  child: AppEmptyState(
                    icon: Icons.bolt_outlined,
                    title: 'No workouts logged yet',
                    message:
                        'Your first completed session will show up here with preserved original units and canonical volume.',
                  ),
                );
              }
              return Column(
                children: items
                    .take(5)
                    .map((item) {
                      final viewModel = displayMapper.toHistoryItem(item);
                      return AppPanel(
                        onTap: () => context.pushNamed(
                          RouteNames.workoutDetail,
                          pathParameters: {'sessionId': item.sessionId},
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    viewModel.title,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    viewModel.subtitle,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              viewModel.volumeLabel,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      );
                    })
                    .toList(growable: false),
              );
            },
            error: (error, stackTrace) =>
                AppPanel(child: AppErrorState(message: error.toString())),
            loading: () => const AppPanel(
              child: SizedBox(
                height: 132,
                child: AppLoadingView(label: 'Loading sessions'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }
}
