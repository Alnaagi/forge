import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/features/templates/presentation/controllers/template_builder_controller.dart';
import 'package:forge/features/workouts/presentation/widgets/exercise_picker_sheet.dart';
import 'package:go_router/go_router.dart';

class TemplateBuilderScreen extends ConsumerStatefulWidget {
  const TemplateBuilderScreen({this.templateId, super.key});

  final String? templateId;

  @override
  ConsumerState<TemplateBuilderScreen> createState() =>
      _TemplateBuilderScreenState();
}

class _TemplateBuilderScreenState extends ConsumerState<TemplateBuilderScreen> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      Future.microtask(
        () => ref
            .read(templateBuilderControllerProvider.notifier)
            .load(widget.templateId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(templateBuilderControllerProvider);

    return AppScaffold(
      title: widget.templateId == null ? 'Template Builder' : 'Edit Template',
      eyebrow: 'Templates',
      subtitle:
          'Build repeatable session structures without hardcoding workout logic into the UI.',
      child: stateAsync.when(
        data: (state) {
          return ListView(
            children: [
              AppPanel(
                gradient: AppColors.bluePanelGradient,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: state.name,
                      decoration: const InputDecoration(
                        labelText: 'Template name',
                      ),
                      onChanged: ref
                          .read(templateBuilderControllerProvider.notifier)
                          .setName,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      initialValue: state.notes,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Notes'),
                      onChanged: ref
                          .read(templateBuilderControllerProvider.notifier)
                          .setNotes,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton.icon(
                      onPressed: _pickExercise,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Exercise'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (state.items.isEmpty)
                const AppPanel(
                  child: AppEmptyState(
                    icon: Icons.copy_all_outlined,
                    title: 'No exercises in this template yet',
                    message:
                        'Add a movement to start shaping sets, reps, and notes.',
                  ),
                ),
              for (final item in state.items) ...[
                AppPanel(
                  gradient: AppColors.greenPanelGradient,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.exercise.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: item.targetSets.toString(),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Sets',
                              ),
                              onChanged: (value) {
                                final sets = int.tryParse(value);
                                if (sets != null && sets > 0) {
                                  ref
                                      .read(
                                        templateBuilderControllerProvider
                                            .notifier,
                                      )
                                      .updateItem(
                                        localId: item.localId,
                                        targetSets: sets,
                                      );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: TextFormField(
                              initialValue: item.targetReps,
                              decoration: const InputDecoration(
                                labelText: 'Reps',
                              ),
                              onChanged: (value) {
                                ref
                                    .read(
                                      templateBuilderControllerProvider
                                          .notifier,
                                    )
                                    .updateItem(
                                      localId: item.localId,
                                      targetReps: value,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextFormField(
                        initialValue: item.notes,
                        maxLines: 2,
                        decoration: const InputDecoration(labelText: 'Notes'),
                        onChanged: (value) {
                          ref
                              .read(templateBuilderControllerProvider.notifier)
                              .updateItem(localId: item.localId, notes: value);
                        },
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            ref
                                .read(
                                  templateBuilderControllerProvider.notifier,
                                )
                                .removeItem(item.localId);
                          },
                          child: const Text('Remove'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              FilledButton(
                onPressed: state.canSave ? _save : null,
                child: const Text('Save Template'),
              ),
            ],
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading template builder'),
      ),
    );
  }

  Future<void> _pickExercise() async {
    final exercise = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SizedBox(
        height: 560,
        child: ExercisePickerSheet(title: 'Add Exercise'),
      ),
    );

    if (exercise == null || !mounted) {
      return;
    }

    ref.read(templateBuilderControllerProvider.notifier).addExercise(exercise);
  }

  Future<void> _save() async {
    final templateId = await ref
        .read(templateBuilderControllerProvider.notifier)
        .save();
    if (!mounted || templateId == null) {
      return;
    }
    context.pop();
  }
}
