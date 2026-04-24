import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/features/templates/presentation/controllers/template_list_controller.dart';
import 'package:forge/features/workouts/presentation/controllers/workout_launcher.dart';

class TemplateListScreen extends ConsumerWidget {
  const TemplateListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.watch(workoutTemplatesProvider);

    return AppScaffold(
      title: 'Templates',
      subtitle:
          'Reusable session structures that can launch straight into live logging.',
      child: Column(
        children: [
          Expanded(
            child: templatesAsync.when(
              data: (templates) {
                if (templates.isEmpty) {
                  return const Center(
                    child: AppPanel(
                      child: AppEmptyState(
                        icon: Icons.copy_all_outlined,
                        title: 'No templates yet',
                        message:
                            'Build a template once and launch it whenever you need a repeatable session.',
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: templates.length,
                  itemBuilder: (context, index) {
                    final detail = templates[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: AppPanel(
                        gradient: index.isEven
                            ? AppColors.bluePanelGradient
                            : null,
                        onTap: () => context.pushNamed(
                          RouteNames.templateBuilder,
                          queryParameters: {'templateId': detail.template.id},
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detail.template.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    '${detail.items.length} exercises',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            FilledButton.tonal(
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
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) => Center(
                child: AppPanel(
                  child: AppErrorState(message: error.toString()),
                ),
              ),
              loading: () => const AppLoadingView(label: 'Loading templates'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: () => context.pushNamed(RouteNames.templateBuilder),
            icon: const Icon(Icons.add),
            label: const Text('Create Template'),
          ),
        ],
      ),
    );
  }
}
