import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/features/goals/presentation/controllers/goal_settings_controller.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class GoalSettingsScreen extends ConsumerStatefulWidget {
  const GoalSettingsScreen({super.key});

  @override
  ConsumerState<GoalSettingsScreen> createState() => _GoalSettingsScreenState();
}

class _GoalSettingsScreenState extends ConsumerState<GoalSettingsScreen> {
  final _titleController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _targetWeightController = TextEditingController();
  bool _initialized = false;
  GoalType _goalType = GoalType.maintain;
  WeightUnit _targetWeightUnit = WeightUnit.kilograms;
  DateTime? _targetDate;

  @override
  void dispose() {
    _titleController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _targetWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewDataAsync = ref.watch(goalSettingsViewProvider);
    final saveState = ref.watch(goalSettingsControllerProvider);

    return AppScaffold(
      title: 'Goals',
      eyebrow: 'Targets',
      subtitle:
          'Set the active goal Forge should use when prioritizing insights, nutrition checks, and dashboard emphasis.',
      child: viewDataAsync.when(
        data: (viewData) {
          final activeGoal = viewData.activeGoal;
          if (!_initialized) {
            _initialized = true;
            _hydrateForm(
              activeGoal: activeGoal,
              preferredWeightUnit: viewData.preferredWeightUnit,
            );
          }

          return ListView(
            children: [
              AppPanel(
                gradient: AppColors.greenPanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeGoal == null ? 'No active goal yet' : 'Active goal',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      activeGoal == null
                          ? 'Pick one goal and give Forge at least the targets you actually care about. Protein and calories are the biggest unlocks for goal-aware insights.'
                          : _activeGoalSummary(activeGoal),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (activeGoal != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          _GoalBadge(label: goalTypeLabel(activeGoal.type)),
                          _GoalBadge(
                            label:
                                '${activeGoal.macroTarget.calories} kcal target',
                          ),
                          _GoalBadge(
                            label:
                                '${_formatDouble(activeGoal.macroTarget.proteinGrams)} g protein',
                          ),
                          if (activeGoal.endedAt != null)
                            _GoalBadge(
                              label:
                                  'Target ${_formatDate(activeGoal.endedAt!)}',
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeGoal == null
                          ? 'Set Active Goal'
                          : 'Update Active Goal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Keep this simple. If you only care about calories and protein right now, fill those and leave the rest as zero.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<GoalType>(
                      initialValue: _goalType,
                      decoration: const InputDecoration(labelText: 'Goal type'),
                      items: GoalType.values
                          .map(
                            (goalType) => DropdownMenuItem(
                              value: goalType,
                              child: Text(goalTypeLabel(goalType)),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() => _goalType = value);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Goal title (optional)',
                        helperText:
                            'Example: Spring cut, Strength block, Maintenance phase',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Target calories',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _proteinController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Protein (g)',
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: TextField(
                            controller: _carbsController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Carbs (g)',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _fatController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Fat (g)',
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: TextField(
                            controller: _targetWeightController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Target weight (optional)',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<WeightUnit>(
                      initialValue: _targetWeightUnit,
                      decoration: const InputDecoration(
                        labelText: 'Target weight unit',
                      ),
                      items: WeightUnit.values
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
                        setState(() => _targetWeightUnit = value);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.softFillFor(
                          Theme.of(context).brightness,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Target date',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            _targetDate == null
                                ? 'No target date set'
                                : _formatDate(_targetDate!),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: [
                              OutlinedButton(
                                onPressed: () => _pickTargetDate(context),
                                child: Text(
                                  _targetDate == null ? 'Set Date' : 'Change',
                                ),
                              ),
                              if (_targetDate != null)
                                TextButton(
                                  onPressed: () =>
                                      setState(() => _targetDate = null),
                                  child: const Text('Clear'),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    FilledButton.icon(
                      onPressed: saveState.isLoading
                          ? null
                          : () => _saveGoal(context, activeGoal),
                      icon: const Icon(Icons.flag_outlined),
                      label: Text(
                        saveState.isLoading ? 'Saving...' : 'Save Active Goal',
                      ),
                    ),
                  ],
                ),
              ),
              if (viewData.recentGoals.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                AppPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Goal States',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Forge keeps prior goal states in local history, while one goal stays active at a time.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      for (final goal in viewData.recentGoals) ...[
                        _GoalHistoryRow(goal: goal),
                        if (goal != viewData.recentGoals.last)
                          const SizedBox(height: AppSpacing.sm),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading goal settings'),
      ),
    );
  }

  void _hydrateForm({
    required Goal? activeGoal,
    required WeightUnit preferredWeightUnit,
  }) {
    _goalType = activeGoal?.type ?? GoalType.maintain;
    _titleController.text = activeGoal?.title ?? '';
    _caloriesController.text =
        activeGoal?.macroTarget.calories.toString() ?? '0';
    _proteinController.text = activeGoal == null
        ? '0'
        : _formatDouble(activeGoal.macroTarget.proteinGrams);
    _carbsController.text = activeGoal == null
        ? '0'
        : _formatDouble(activeGoal.macroTarget.carbsGrams);
    _fatController.text = activeGoal == null
        ? '0'
        : _formatDouble(activeGoal.macroTarget.fatGrams);
    _targetWeightController.text = activeGoal?.targetWeight == null
        ? ''
        : _formatDouble(activeGoal!.targetWeight!.originalValue);
    _targetWeightUnit =
        activeGoal?.targetWeight?.originalUnit ?? preferredWeightUnit;
    _targetDate = activeGoal?.endedAt;
  }

  Future<void> _pickTargetDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? DateTime.now().add(const Duration(days: 28)),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (pickedDate == null) {
      return;
    }
    setState(() => _targetDate = pickedDate);
  }

  Future<void> _saveGoal(BuildContext context, Goal? existingGoal) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final calories = int.tryParse(_caloriesController.text.trim()) ?? 0;
    final protein = _tryParse(_proteinController.text);
    final carbs = _tryParse(_carbsController.text);
    final fat = _tryParse(_fatController.text);
    final targetWeight = _tryParse(_targetWeightController.text);

    if (calories < 0 || protein < 0 || carbs < 0 || fat < 0) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Goal targets cannot be negative.')),
      );
      return;
    }

    await ref
        .read(goalSettingsControllerProvider.notifier)
        .saveActiveGoal(
          existingGoal: existingGoal,
          type: _goalType,
          title: _titleController.text,
          calories: calories,
          proteinGrams: protein,
          carbsGrams: carbs,
          fatGrams: fat,
          targetWeightValue: targetWeight,
          targetWeightUnit: _targetWeightUnit,
          targetDate: _targetDate,
        );

    if (!mounted) {
      return;
    }
    scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text('Active goal updated.')),
    );
  }
}

class _GoalHistoryRow extends StatelessWidget {
  const _GoalHistoryRow({required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final accent = goal.isActive ? AppColors.neonGreen : AppColors.electricBlue;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.title ?? goalTypeLabel(goal.type),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '${goalTypeLabel(goal.type)} | ${goal.macroTarget.calories} kcal | ${_formatDate(goal.startedAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            goal.isActive ? 'Active' : 'Saved',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: accent),
          ),
        ],
      ),
    );
  }
}

class _GoalBadge extends StatelessWidget {
  const _GoalBadge({required this.label});

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

String _activeGoalSummary(Goal goal) {
  final targetDateLabel = goal.endedAt == null
      ? 'No target date set.'
      : 'Target date ${_formatDate(goal.endedAt!)}.';
  return '${goal.title ?? goalTypeLabel(goal.type)} is the active target. Forge can now use these macros and timeline when deciding whether nutrition and insight signals are actually off track. $targetDateLabel';
}

String _formatDate(DateTime value) {
  final local = value.toLocal();
  return '${local.month}/${local.day}/${local.year}';
}

String _formatDouble(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}

double _tryParse(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return 0;
  }
  return double.tryParse(trimmed) ?? 0;
}
