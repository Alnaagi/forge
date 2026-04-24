import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/features/nutrition/presentation/controllers/saved_meals_controller.dart';
import 'package:forge/features/nutrition/presentation/widgets/nutrition_formatters.dart';
import 'package:forge/shared/enums/meal_type.dart';
import 'package:go_router/go_router.dart';

class SavedMealsScreen extends ConsumerWidget {
  const SavedMealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedMealsAsync = ref.watch(savedMealsProvider);

    return AppScaffold(
      title: 'Saved Meals',
      eyebrow: 'Nutrition',
      subtitle:
          'Reusable local meal stacks that you can log fast without searching item by item every time.',
      child: savedMealsAsync.when(
        data: (savedMeals) {
          if (savedMeals.isEmpty) {
            return const AppPanel(
              child: AppEmptyState(
                icon: Icons.bookmark_border,
                title: 'No saved meals yet',
                message:
                    'Save a meal from the nutrition home screen to make repeat logging instant.',
              ),
            );
          }
          return ListView.builder(
            itemCount: savedMeals.length,
            itemBuilder: (context, index) {
              final detail = savedMeals[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: AppPanel(
                  gradient: index.isEven ? AppColors.greenPanelGradient : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.savedMeal.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          _MealBadge(
                            label: NutritionFormatters.macros(detail.macros),
                          ),
                          _MealBadge(label: '${detail.items.length} items'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      for (final item in detail.items.take(4))
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                          child: Text(
                            '${item.food.name} - ${NutritionFormatters.quantity(item.item.quantity)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => _logSavedMeal(
                                context,
                                ref,
                                detail.savedMeal.id,
                              ),
                              child: const Text('Log Saved Meal'),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          IconButton.filledTonal(
                            tooltip: 'Edit saved meal',
                            onPressed: () => context.pushNamed(
                              RouteNames.savedMealEditor,
                              pathParameters: {
                                'savedMealId': detail.savedMeal.id,
                              },
                            ),
                            icon: const Icon(Icons.edit_outlined),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          IconButton.filledTonal(
                            tooltip: 'Delete saved meal',
                            onPressed: () => _deleteSavedMeal(
                              context,
                              ref,
                              detail.savedMeal.id,
                            ),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading saved meals'),
      ),
    );
  }

  Future<void> _logSavedMeal(
    BuildContext context,
    WidgetRef ref,
    String savedMealId,
  ) async {
    MealType selectedMealType = MealType.breakfast;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Log Saved Meal'),
              content: DropdownButtonFormField<MealType>(
                initialValue: selectedMealType,
                items: MealType.values
                    .map(
                      (mealType) => DropdownMenuItem(
                        value: mealType,
                        child: Text(mealType.name),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() => selectedMealType = value);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Log'),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await ref
        .read(savedMealsControllerProvider)
        .logSavedMeal(savedMealId: savedMealId, mealType: selectedMealType);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Saved meal logged.')));
  }

  Future<void> _deleteSavedMeal(
    BuildContext context,
    WidgetRef ref,
    String savedMealId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Saved Meal'),
          content: const Text('Remove this saved meal template?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
    if (confirmed != true) {
      return;
    }

    await ref.read(savedMealsControllerProvider).deleteSavedMeal(savedMealId);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Saved meal removed.')));
  }
}

class _MealBadge extends StatelessWidget {
  const _MealBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
