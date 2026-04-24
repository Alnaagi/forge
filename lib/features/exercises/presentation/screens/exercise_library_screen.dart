import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_search_field.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/features/exercises/presentation/controllers/exercise_library_controller.dart';
import 'package:go_router/go_router.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() =>
      _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends ConsumerState<ExerciseLibraryScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(exerciseSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(exerciseLibraryProvider);

    return AppScaffold(
      title: 'Exercise Library',
      subtitle:
          'Built-in lifts and custom movements stay in one searchable local library.',
      child: Column(
        children: [
          AppPanel(
            gradient: AppColors.bluePanelGradient,
            child: AppSearchField(
              controller: _searchController,
              hintText: 'Search exercises',
              onChanged: (value) {
                ref.read(exerciseSearchQueryProvider.notifier).state = value;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: exercisesAsync.when(
              data: (exercises) {
                if (exercises.isEmpty) {
                  return const Center(
                    child: AppPanel(
                      child: AppEmptyState(
                        icon: Icons.fitness_center,
                        title: 'No exercises yet',
                        message:
                            'Built-in seeds or your custom movements will appear here.',
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: AppPanel(
                        gradient: exercise.isBuiltIn
                            ? null
                            : AppColors.greenPanelGradient,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exercise.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    exercise.primaryMuscleGroup,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              exercise.isBuiltIn ? 'Built-in' : 'Custom',
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: exercise.isBuiltIn
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                  ),
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
              loading: () => const AppLoadingView(label: 'Loading exercises'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: () => context.pushNamed(RouteNames.createCustomExercise),
            icon: const Icon(Icons.add),
            label: const Text('Create Custom Exercise'),
          ),
        ],
      ),
    );
  }
}
