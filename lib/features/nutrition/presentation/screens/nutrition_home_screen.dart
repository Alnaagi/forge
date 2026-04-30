import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/settings_providers.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/entities/hydration_log.dart';
import 'package:forge/domain/entities/meal_entry_detail.dart';
import 'package:forge/domain/services/nutrition_target_service.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/meal_log_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/nutrition_dashboard_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/saved_meals_controller.dart';
import 'package:forge/features/nutrition/presentation/widgets/nutrition_formatters.dart';
import 'package:forge/shared/enums/meal_type.dart';
import 'package:forge/shared/enums/volume_unit.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';
import 'package:go_router/go_router.dart';

class NutritionHomeScreen extends ConsumerWidget {
  const NutritionHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(nutritionDayOverviewProvider);
    final healthOverview = ref.watch(healthOverviewProvider);
    final targetPlan = ref.watch(nutritionTargetPlanProvider);
    final preferences =
        ref.watch(foodPreferencesProvider).valueOrNull ??
        const FoodPreferences.defaults();
    final recentMeals = ref.watch(recentMealEntriesProvider).valueOrNull ?? [];
    final commonFoods = ref.watch(commonFoodDetailsProvider).valueOrNull ?? [];

    return AppScaffold(
      title: 'Fueling',
      eyebrow: 'Nutrition',
      subtitle:
          'Remote search assists, but every trusted food and meal stays anchored in local storage.',
      child: overviewAsync.when(
        data: (overview) {
          return ListView(
            children: [
              AppPanel(
                gradient: AppColors.bluePanelGradient,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Intake Overview',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        '${overview.totals.calories}',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        'of ${targetPlan.calories} kcal target',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(NutritionFormatters.macros(overview.totals)),
                      Text(targetPlan.explanation),
                      Text(
                        'Hydration: ${NutritionFormatters.hydrationMilliliters(overview.totalHydrationMilliliters)}',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _CalorieTargetBar(
                        current: overview.totals.calories,
                        target: targetPlan.calories,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _MacroBar(
                        label: 'Protein',
                        accent: AppColors.electricBlue,
                        fraction: _macroFraction(
                          overview.totals.protein,
                          targetPlan.proteinGrams,
                        ),
                        value: '${overview.totals.protein.toStringAsFixed(0)}g',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _MacroBar(
                        label: 'Carbs',
                        accent: AppColors.neonGreen,
                        fraction: _macroFraction(
                          overview.totals.carbs,
                          targetPlan.carbsGrams,
                        ),
                        value: '${overview.totals.carbs.toStringAsFixed(0)}g',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _MacroBar(
                        label: 'Fats',
                        accent: AppColors.vividOrange,
                        fraction: _macroFraction(
                          overview.totals.fat,
                          targetPlan.fatGrams,
                        ),
                        value: '${overview.totals.fat.toStringAsFixed(0)}g',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          FilledButton.icon(
                            onPressed: () =>
                                context.pushNamed(RouteNames.foodSearch),
                            icon: const Icon(Icons.search),
                            label: const Text('Log Food'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () =>
                                context.pushNamed(RouteNames.barcodeLookup),
                            icon: const Icon(Icons.qr_code_scanner),
                            label: const Text('Scan Barcode'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () =>
                                context.pushNamed(RouteNames.savedMeals),
                            icon: const Icon(Icons.bookmark),
                            label: const Text('Saved Meals'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _NutritionPlanPanel(
                targetPlan: targetPlan,
                preferences: preferences,
                onEditPreferences: () =>
                    _openFoodPreferencesSurvey(context, ref, preferences),
              ),
              const SizedBox(height: AppSpacing.md),
              _FoodChoicePanel(
                targetPlan: targetPlan,
                current: overview.totals,
                commonFoods: commonFoods.take(6).toList(growable: false),
                recentMeals: recentMeals,
                onLogFood: (foodId) => context.pushNamed(
                  RouteNames.mealLog,
                  queryParameters: {'foodId': foodId},
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (healthOverview.profile != null ||
                  healthOverview.activeLogs.isNotEmpty ||
                  healthOverview.generalAdvice.isNotEmpty) ...[
                AppPanel(
                  gradient: AppColors.orangePanelGradient,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Health-Aware Fueling',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        healthOverview.activeLogs.isEmpty
                            ? 'Your food checks are using allergies, medications, and saved health context.'
                            : 'Forge is cross-checking food choices against your active symptoms and profile.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (healthOverview.generalAdvice.isEmpty)
                        Text(
                          'Log a symptom or mood shift to unlock more context-aware food guidance.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      else
                        for (final line in healthOverview.generalAdvice.take(3))
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.xs,
                            ),
                            child: Text(
                              line,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          if (healthOverview.profile != null)
                            _HealthSignalChip(
                              label:
                                  '${healthOverview.profile!.allergies.length} allergies',
                            ),
                          if (healthOverview.profile != null)
                            _HealthSignalChip(
                              label:
                                  '${healthOverview.profile!.medications.length} meds',
                            ),
                          if (healthOverview.activeLogs.isNotEmpty)
                            _HealthSignalChip(
                              label:
                                  '${healthOverview.activeLogs.length} active flags',
                            ),
                          OutlinedButton.icon(
                            onPressed: () =>
                                context.pushNamed(RouteNames.healthStatus),
                            icon: const Icon(Icons.health_and_safety_outlined),
                            label: const Text('Open Health'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Hydration',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Text(
                          NutritionFormatters.hydrationMilliliters(
                            overview.totalHydrationMilliliters,
                          ),
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        FilledButton.tonal(
                          onPressed: () => ref
                              .read(nutritionActionsProvider)
                              .addHydration(
                                amount: 250,
                                unit: VolumeUnit.milliliters,
                              ),
                          child: const Text('+250 ml'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => ref
                              .read(nutritionActionsProvider)
                              .addHydration(
                                amount: 500,
                                unit: VolumeUnit.milliliters,
                              ),
                          child: const Text('+500 ml'),
                        ),
                      ],
                    ),
                    if (overview.hydrationLogs.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      const Divider(),
                      const SizedBox(height: AppSpacing.sm),
                      for (final log in overview.hydrationLogs)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _HydrationLogRow(
                            log: log,
                            onEdit: () => _editHydrationLog(context, ref, log),
                            onDelete: () =>
                                _deleteHydrationLog(context, ref, log),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              for (final mealType in MealType.values) ...[
                _MealSection(
                  mealType: mealType,
                  entries: overview.entriesFor(mealType),
                  onEditEntry: (entry) => context.pushNamed(
                    RouteNames.mealLog,
                    queryParameters: {'mealEntryId': entry.entry.id},
                  ),
                  onDeleteEntry: (entry) =>
                      _deleteMealEntry(context, ref, entry),
                  onAddFood: () => context.pushNamed(
                    RouteNames.foodSearch,
                    queryParameters: {'mealType': mealType.name},
                  ),
                  onSaveMeal: overview.entriesFor(mealType).isEmpty
                      ? null
                      : () => _saveMealGroup(
                          context,
                          ref,
                          mealType,
                          overview.entriesFor(mealType),
                        ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading nutrition floor'),
      ),
    );
  }

  Future<void> _editHydrationLog(
    BuildContext context,
    WidgetRef ref,
    HydrationLog log,
  ) async {
    final amountController = TextEditingController(
      text: _formatEditableAmount(log.amount.originalValue),
    );
    var selectedUnit = log.amount.originalUnit;

    final didSave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Hydration'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DropdownButtonFormField<VolumeUnit>(
                    initialValue: selectedUnit,
                    decoration: const InputDecoration(labelText: 'Unit'),
                    items: VolumeUnit.values
                        .map(
                          (unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit.symbol),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() => selectedUnit = value);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    final amount = double.tryParse(
                      amountController.text.trim(),
                    );
                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a valid hydration amount.'),
                        ),
                      );
                      return;
                    }
                    await ref
                        .read(nutritionActionsProvider)
                        .updateHydrationLog(
                          existingLog: log,
                          amount: amount,
                          unit: selectedUnit,
                        );
                    if (!dialogContext.mounted) {
                      return;
                    }
                    Navigator.of(dialogContext).pop(true);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    amountController.dispose();

    if (didSave != true || !context.mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Hydration updated.')));
  }

  Future<void> _deleteHydrationLog(
    BuildContext context,
    WidgetRef ref,
    HydrationLog log,
  ) async {
    final confirmed = await _confirmRemoval(
      context,
      title: 'Delete Hydration Log',
      message: 'Remove this hydration entry?',
    );
    if (confirmed != true) {
      return;
    }

    await ref.read(nutritionActionsProvider).deleteHydrationLog(log.id);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Hydration removed.')));
  }

  Future<void> _deleteMealEntry(
    BuildContext context,
    WidgetRef ref,
    MealEntryDetail entry,
  ) async {
    final confirmed = await _confirmRemoval(
      context,
      title: 'Delete Meal Entry',
      message: 'Remove ${entry.food.name} from today\'s log?',
    );
    if (confirmed != true) {
      return;
    }

    await ref.read(mealLogControllerProvider).deleteMealEntry(entry.entry.id);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Meal entry removed.')));
  }

  Future<void> _saveMealGroup(
    BuildContext context,
    WidgetRef ref,
    MealType mealType,
    List<MealEntryDetail> entries,
  ) async {
    final controller = TextEditingController(text: '${mealType.name} meal');
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Save Meal'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Saved meal name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    controller.dispose();

    if (name == null || name.trim().isEmpty || !context.mounted) {
      return;
    }

    await ref
        .read(savedMealsControllerProvider)
        .saveFromEntries(name: name, entries: entries);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Saved meal created.')));
  }

  Future<void> _openFoodPreferencesSurvey(
    BuildContext context,
    WidgetRef ref,
    FoodPreferences current,
  ) async {
    var proteinStyle = current.proteinStyle;
    var carbStyle = current.carbStyle;
    var dietStyle = current.dietStyle;

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Food Preference Survey'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _PreferenceDropdown(
                      label: 'Protein preference',
                      value: proteinStyle,
                      options: _proteinPreferenceOptions,
                      onChanged: (value) =>
                          setState(() => proteinStyle = value),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _PreferenceDropdown(
                      label: 'Carb preference',
                      value: carbStyle,
                      options: _carbPreferenceOptions,
                      onChanged: (value) => setState(() => carbStyle = value),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _PreferenceDropdown(
                      label: 'Diet style',
                      value: dietStyle,
                      options: _dietPreferenceOptions,
                      onChanged: (value) => setState(() => dietStyle = value),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Forge uses this to shape simple local meal ideas. It does not replace medical nutrition advice.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    await ref
                        .read(foodPreferencesControllerProvider)
                        .save(
                          FoodPreferences(
                            proteinStyle: proteinStyle,
                            carbStyle: carbStyle,
                            dietStyle: dietStyle,
                          ),
                        );
                    if (!dialogContext.mounted) {
                      return;
                    }
                    Navigator.of(dialogContext).pop(true);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (saved == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Food preferences updated.')),
      );
    }
  }
}

class _CalorieTargetBar extends StatelessWidget {
  const _CalorieTargetBar({required this.current, required this.target});

  final int current;
  final int target;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final fraction = target <= 0 ? 0.0 : current / target;
    final remaining = target - current;
    final status = remaining > 0
        ? '$remaining kcal left'
        : '${remaining.abs()} kcal over target';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Goal fuel meter',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Text(status, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: fraction.clamp(0.0, 1.0),
            minHeight: 14,
            backgroundColor: AppColors.progressTrackFor(brightness),
            valueColor: AlwaysStoppedAnimation<Color>(
              fraction > 1.1 ? AppColors.vividOrange : AppColors.electricBlue,
            ),
          ),
        ),
      ],
    );
  }
}

class _NutritionPlanPanel extends StatelessWidget {
  const _NutritionPlanPanel({
    required this.targetPlan,
    required this.preferences,
    required this.onEditPreferences,
  });

  final NutritionTargetPlan targetPlan;
  final FoodPreferences preferences;
  final VoidCallback onEditPreferences;

  @override
  Widget build(BuildContext context) {
    final meals = _mealPlanFor(preferences);
    return AppPanel(
      gradient: AppColors.greenPanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.restaurant_menu, color: AppColors.neonGreen),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Goal Fuel Plan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: onEditPreferences,
                child: const Text('Survey'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${targetPlan.calories} kcal · ${targetPlan.proteinGrams.toStringAsFixed(0)}g protein · ${targetPlan.carbsGrams.toStringAsFixed(0)}g carbs · ${targetPlan.fatGrams.toStringAsFixed(0)}g fats',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            targetPlan.recoveryNote,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _PlanChip(
                icon: Icons.egg_alt_outlined,
                label: _preferenceLabel(
                  preferences.proteinStyle,
                  _proteinPreferenceOptions,
                ),
              ),
              _PlanChip(
                icon: Icons.rice_bowl_outlined,
                label: _preferenceLabel(
                  preferences.carbStyle,
                  _carbPreferenceOptions,
                ),
              ),
              _PlanChip(
                icon: Icons.tune,
                label: _preferenceLabel(
                  preferences.dietStyle,
                  _dietPreferenceOptions,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          for (final meal in meals)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _MealIdeaRow(title: meal.$1, detail: meal.$2),
            ),
        ],
      ),
    );
  }
}

class _FoodChoicePanel extends StatelessWidget {
  const _FoodChoicePanel({
    required this.targetPlan,
    required this.current,
    required this.commonFoods,
    required this.recentMeals,
    required this.onLogFood,
  });

  final NutritionTargetPlan targetPlan;
  final NutritionMacros current;
  final List<FoodDetail> commonFoods;
  final List<MealEntryDetail> recentMeals;
  final ValueChanged<String> onLogFood;

  @override
  Widget build(BuildContext context) {
    final advice = _foodAdvice(targetPlan, current);
    final sortedFoods = [
      ...commonFoods,
    ]..sort((a, b) => _foodRank(a.food.name).compareTo(_foodRank(b.food.name)));
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.vividOrange),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Food Guidance',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(advice, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.md),
          if (recentMeals.isNotEmpty) ...[
            Text(
              'Recent quick log',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 132,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recentMeals.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final entry = recentMeals[index];
                  return _FoodVisualCard(
                    title: entry.food.name,
                    subtitle: '${entry.macros.calories} kcal last time',
                    icon: _foodIcon(entry.food.name),
                    onTap: () => onLogFood(entry.food.id),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Text('Common foods', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 140,
            child: sortedFoods.isEmpty
                ? const AppEmptyState(
                    icon: Icons.local_dining_outlined,
                    title: 'Common foods are loading',
                    message:
                        'Use food search while the local starter list warms up.',
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: sortedFoods.take(8).length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      final detail = sortedFoods[index];
                      return _FoodVisualCard(
                        title: detail.food.name,
                        subtitle:
                            '${detail.food.caloriesPer100g} kcal | ${detail.food.proteinPer100g.toStringAsFixed(0)}P / 100g',
                        icon: _foodIcon(detail.food.name),
                        onTap: () => onLogFood(detail.food.id),
                      );
                    },
                  ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'These are local starter foods with nutrition values. Real food photos are deferred; cards use simple visual markers for now.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _FoodVisualCard extends StatelessWidget {
  const _FoodVisualCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 162,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: brightness == Brightness.dark
                ? const [Color(0xFF1D2A24), Color(0xFF111418)]
                : const [Color(0xFFDFF6E8), Color(0xFFEAF2FF)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.ghostOutlineFor(brightness)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 34, color: Theme.of(context).colorScheme.primary),
            const Spacer(),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _MealIdeaRow extends StatelessWidget {
  const _MealIdeaRow({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt_outlined, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: AppSpacing.xxs),
                Text(detail, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanChip extends StatelessWidget {
  const _PlanChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _PreferenceDropdown extends StatelessWidget {
  const _PreferenceDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final Map<String, String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: options.containsKey(value) ? value : options.keys.first,
      decoration: InputDecoration(labelText: label),
      items: options.entries
          .map(
            (entry) => DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            ),
          )
          .toList(growable: false),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

class _HealthSignalChip extends StatelessWidget {
  const _HealthSignalChip({required this.label});

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

class _MealSection extends StatelessWidget {
  const _MealSection({
    required this.mealType,
    required this.entries,
    required this.onEditEntry,
    required this.onDeleteEntry,
    required this.onAddFood,
    required this.onSaveMeal,
  });

  final MealType mealType;
  final List<MealEntryDetail> entries;
  final ValueChanged<MealEntryDetail> onEditEntry;
  final ValueChanged<MealEntryDetail> onDeleteEntry;
  final VoidCallback onAddFood;
  final VoidCallback? onSaveMeal;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  mealType.name[0].toUpperCase() + mealType.name.substring(1),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(onPressed: onAddFood, child: const Text('Add Food')),
              if (onSaveMeal != null)
                TextButton(
                  onPressed: onSaveMeal,
                  child: const Text('Save Meal'),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (entries.isEmpty) ...[
            const AppEmptyState(
              icon: Icons.restaurant_menu_outlined,
              title: 'No food logged yet',
              message: 'Use search or barcode logging to add your next meal.',
            ),
          ] else ...[
            for (final entry in entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.food.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            NutritionFormatters.mealEntrySubtitle(entry),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${entry.macros.calories}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Text('kcal', style: Theme.of(context).textTheme.labelSmall),
                    IconButton(
                      tooltip: 'Edit meal',
                      onPressed: () => onEditEntry(entry),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      tooltip: 'Delete meal',
                      onPressed: () => onDeleteEntry(entry),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _HydrationLogRow extends StatelessWidget {
  const _HydrationLogRow({
    required this.log,
    required this.onEdit,
    required this.onDelete,
  });

  final HydrationLog log;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_formatEditableAmount(log.amount.originalValue)} ${log.amount.originalUnit.symbol}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                TimeOfDay.fromDateTime(log.loggedAt).format(context),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Edit hydration',
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined),
        ),
        IconButton(
          tooltip: 'Delete hydration',
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }
}

class _MacroBar extends StatelessWidget {
  const _MacroBar({
    required this.label,
    required this.accent,
    required this.fraction,
    required this.value,
  });

  final String label;
  final Color accent;
  final double fraction;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label, style: Theme.of(context).textTheme.labelLarge),
            ),
            Text(value, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: fraction.clamp(0, 1),
            minHeight: 10,
            backgroundColor: AppColors.progressTrackFor(
              Theme.of(context).brightness,
            ),
            valueColor: AlwaysStoppedAnimation<Color>(accent),
          ),
        ),
      ],
    );
  }
}

double _macroFraction(double current, double goal) {
  if (goal <= 0) {
    return 0;
  }
  return current / goal;
}

const _proteinPreferenceOptions = <String, String>{
  'mixed': 'Mixed proteins',
  'lean': 'Lean meat focused',
  'seafood': 'Seafood friendly',
  'dairy': 'Dairy and whey',
  'plant': 'Plant-forward',
};

const _carbPreferenceOptions = <String, String>{
  'rice_potato_oats': 'Rice, potatoes, oats',
  'low_gi': 'Slow carbs',
  'high_energy': 'High-energy carbs',
  'light': 'Lighter carbs',
};

const _dietPreferenceOptions = <String, String>{
  'balanced': 'Balanced',
  'budget': 'Budget simple',
  'prep': 'Meal prep',
  'low_appetite': 'Low appetite',
};

String _preferenceLabel(String value, Map<String, String> options) {
  return options[value] ?? options.values.first;
}

List<(String, String)> _mealPlanFor(FoodPreferences preferences) {
  final protein = switch (preferences.proteinStyle) {
    'lean' => 'chicken, tuna, or Greek yogurt',
    'seafood' => 'salmon, tuna, or eggs',
    'dairy' => 'Greek yogurt, whey, eggs',
    'plant' => 'beans, tofu, lentils, or oats',
    _ => 'eggs, chicken, yogurt, or fish',
  };
  final carbs = switch (preferences.carbStyle) {
    'low_gi' => 'oats, potatoes, fruit, and vegetables',
    'high_energy' => 'rice, oats, bananas, and potatoes',
    'light' => 'fruit, potatoes, and vegetables',
    _ => 'rice, potatoes, oats, and bananas',
  };
  final prep = switch (preferences.dietStyle) {
    'budget' => 'repeat simple staples so logging stays fast',
    'prep' => 'batch protein and carbs for two to three days',
    'low_appetite' => 'use smaller meals plus a shake if needed',
    _ => 'spread fuel across three to four meals',
  };

  return [
    ('Breakfast anchor', 'Protein from $protein with $carbs.'),
    ('Training window', 'Place most carbs around your workout when possible.'),
    ('Daily structure', prep),
  ];
}

String _foodAdvice(NutritionTargetPlan targetPlan, NutritionMacros current) {
  final proteinGap = targetPlan.proteinGrams - current.protein;
  final carbGap = targetPlan.carbsGrams - current.carbs;
  final fatGap = targetPlan.fatGrams - current.fat;
  if (proteinGap > 35) {
    return 'Protein is the biggest gap right now. Pick a dense protein first, then add carbs if training is today.';
  }
  if (carbGap > 80) {
    return 'Carbs are behind your target. Choose rice, oats, potato, or fruit to support training output and recovery.';
  }
  if (fatGap < -15) {
    return 'Fats are already high for today. Keep the next meal lean and protein-focused.';
  }
  if (current.calories > targetPlan.calories) {
    return 'Calories are over target. Keep the next choice light, high-protein, and easy to digest.';
  }
  return 'Your intake is tracking cleanly. Keep choosing foods that fill the biggest macro gap without overshooting calories.';
}

int _foodRank(String name) {
  final normalized = name.toLowerCase();
  const ordered = [
    'chicken',
    'rice',
    'egg',
    'yogurt',
    'oats',
    'banana',
    'salmon',
    'tuna',
  ];
  final index = ordered.indexWhere(normalized.contains);
  return index == -1 ? 99 : index;
}

IconData _foodIcon(String name) {
  final normalized = name.toLowerCase();
  if (normalized.contains('chicken')) return Icons.set_meal_outlined;
  if (normalized.contains('rice')) return Icons.rice_bowl_outlined;
  if (normalized.contains('egg')) return Icons.egg_alt_outlined;
  if (normalized.contains('yogurt') || normalized.contains('oat')) {
    return Icons.breakfast_dining_outlined;
  }
  if (normalized.contains('banana')) return Icons.eco_outlined;
  if (normalized.contains('salmon') || normalized.contains('tuna')) {
    return Icons.water_outlined;
  }
  if (normalized.contains('potato')) return Icons.spa_outlined;
  if (normalized.contains('broccoli')) return Icons.grass_outlined;
  if (normalized.contains('oil')) return Icons.opacity_outlined;
  if (normalized.contains('whey')) return Icons.local_drink_outlined;
  return Icons.restaurant_outlined;
}

String _formatEditableAmount(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}

Future<bool?> _confirmRemoval(
  BuildContext context, {
  required String title,
  required String message,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
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
}
