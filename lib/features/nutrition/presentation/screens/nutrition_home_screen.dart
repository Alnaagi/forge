import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/domain/entities/hydration_log.dart';
import 'package:forge/domain/entities/meal_entry_detail.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/meal_log_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/nutrition_dashboard_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/saved_meals_controller.dart';
import 'package:forge/features/nutrition/presentation/widgets/nutrition_formatters.dart';
import 'package:forge/shared/enums/meal_type.dart';
import 'package:forge/shared/enums/volume_unit.dart';
import 'package:go_router/go_router.dart';

class NutritionHomeScreen extends ConsumerWidget {
  const NutritionHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(nutritionDayOverviewProvider);
    final healthOverview = ref.watch(healthOverviewProvider);

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
                        'kcal logged today',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(NutritionFormatters.macros(overview.totals)),
                      Text(
                        'Hydration: ${NutritionFormatters.hydrationMilliliters(overview.totalHydrationMilliliters)}',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _MacroBar(
                        label: 'Protein',
                        accent: AppColors.electricBlue,
                        fraction: _macroFraction(overview.totals.protein, 200),
                        value: '${overview.totals.protein.toStringAsFixed(0)}g',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _MacroBar(
                        label: 'Carbs',
                        accent: AppColors.neonGreen,
                        fraction: _macroFraction(overview.totals.carbs, 300),
                        value: '${overview.totals.carbs.toStringAsFixed(0)}g',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _MacroBar(
                        label: 'Fats',
                        accent: AppColors.vividOrange,
                        fraction: _macroFraction(overview.totals.fat, 90),
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
