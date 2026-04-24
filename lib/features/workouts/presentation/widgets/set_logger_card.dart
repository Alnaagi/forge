import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_logged_exercise.dart';
import 'package:forge/features/workouts/presentation/mappers/workout_display_mapper.dart';
import 'package:forge/features/workouts/presentation/view_models/workout_display_view_models.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class SetLoggerCard extends ConsumerStatefulWidget {
  const SetLoggerCard({
    required this.loggedExercise,
    required this.onAddSet,
    required this.onRepeatLastSet,
    required this.onUpdateSet,
    required this.onDeleteSet,
    required this.onAddSupersetExercise,
    super.key,
  });

  final WorkoutLoggedExercise loggedExercise;
  final Future<bool> Function({
    required int reps,
    required SetType setType,
    double? originalWeightValue,
    WeightUnit? weightUnit,
    double? rpe,
    String? tempo,
    int? restSeconds,
    String? notes,
  })
  onAddSet;
  final Future<bool> Function() onRepeatLastSet;
  final Future<bool> Function({
    required SetEntry existingSet,
    required int reps,
    required SetType setType,
    double? originalWeightValue,
    WeightUnit? weightUnit,
    double? rpe,
    String? tempo,
    int? restSeconds,
    String? notes,
  })
  onUpdateSet;
  final Future<void> Function(SetEntry set) onDeleteSet;
  final VoidCallback onAddSupersetExercise;

  @override
  ConsumerState<SetLoggerCard> createState() => _SetLoggerCardState();
}

class _SetLoggerCardState extends ConsumerState<SetLoggerCard> {
  late final TextEditingController _repsController;
  late final TextEditingController _weightController;
  late final TextEditingController _rpeController;
  late final TextEditingController _tempoController;
  late final TextEditingController _restController;
  late final TextEditingController _notesController;
  SetType _setType = SetType.normal;
  WeightUnit _weightUnit = WeightUnit.kilograms;
  bool _isSaving = false;
  bool _showAdvanced = false;
  SetEntry? _editingSet;

  @override
  void initState() {
    super.initState();
    _repsController = TextEditingController();
    _weightController = TextEditingController();
    _rpeController = TextEditingController();
    _tempoController = TextEditingController();
    _restController = TextEditingController(text: '90');
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    _rpeController.dispose();
    _tempoController.dispose();
    _restController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayMapper = WorkoutDisplayMapper(
      metrics: ref.watch(workoutMetricsServiceProvider),
    );
    final setRows = [
      for (final entry in widget.loggedExercise.sets.asMap().entries)
        (
          set: entry.value,
          viewModel: displayMapper.toSetDisplay(
            entry.value,
            displayIndex: entry.key + 1,
          ),
        ),
    ];

    return AppPanel(
      gradient: widget.loggedExercise.entry.supersetGroupId != null
          ? AppColors.bluePanelGradient
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.loggedExercise.exercise.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      widget.loggedExercise.entry.supersetGroupId != null
                          ? 'Superset linked'
                          : 'Log the next set fast, with original unit preserved.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: widget.onAddSupersetExercise,
                child: const Text('Add Superset'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (setRows.isEmpty)
            const _WorkoutEmptyMessage(
              title: 'No sets logged yet',
              message:
                  'Start with reps and optional weight, then Forge will keep the rest timer and PR checks moving.',
            )
          else
            Column(
              children: setRows
                  .map(
                    (row) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _LoggedSetRow(
                        viewModel: row.viewModel,
                        onEdit: () => _startEditingSet(row.set),
                        onDelete: () => _deleteSet(row.set),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _MetricInput(
                  controller: _weightController,
                  label: 'Weight',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _MetricInput(
                  controller: _repsController,
                  label: 'Reps',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: SegmentedButton<WeightUnit>(
                  showSelectedIcon: false,
                  segments: WeightUnit.values
                      .map(
                        (unit) => ButtonSegment<WeightUnit>(
                          value: unit,
                          label: Text(unit.symbol.toUpperCase()),
                        ),
                      )
                      .toList(growable: false),
                  selected: {_weightUnit},
                  onSelectionChanged: (selection) {
                    setState(() => _weightUnit = selection.first);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: SetType.values
                .map(
                  (type) => ChoiceChip(
                    label: Text(_setTypeLabel(type)),
                    selected: _setType == type,
                    onSelected: (_) => setState(() => _setType = type),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              TextButton.icon(
                onPressed: () => setState(() => _showAdvanced = !_showAdvanced),
                icon: Icon(
                  _showAdvanced
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                label: Text(_showAdvanced ? 'Hide details' : 'More details'),
              ),
            ],
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 220),
            crossFadeState: _showAdvanced
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _MetricInput(
                          controller: _rpeController,
                          label: 'RPE',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _MetricInput(
                          controller: _restController,
                          label: 'Rest sec',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _MetricInput(controller: _tempoController, label: 'Tempo'),
                  const SizedBox(height: AppSpacing.sm),
                  _MetricInput(controller: _notesController, label: 'Notes'),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (_editingSet != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Editing set #${_editingSet!.orderIndex + 1}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  TextButton(
                    onPressed: _isSaving ? null : _cancelEditing,
                    child: const Text('Cancel Edit'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _isSaving ? null : _handleAddSet,
                  child: Text(
                    _isSaving
                        ? 'Saving...'
                        : _editingSet == null
                        ? 'Add Set'
                        : 'Save Changes',
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSaving
                      ? null
                      : _editingSet == null
                      ? _handleRepeatLastSet
                      : _cancelEditing,
                  child: Text(
                    _editingSet == null ? 'Repeat Last Set' : 'Cancel',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleAddSet() async {
    final reps = int.tryParse(_repsController.text.trim());
    final weight = double.tryParse(_weightController.text.trim());
    final rpe = double.tryParse(_rpeController.text.trim());
    final rest = int.tryParse(_restController.text.trim());

    if (reps == null || reps <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter valid reps.')));
      return;
    }

    setState(() => _isSaving = true);
    final wasEditing = _editingSet != null;
    final isPr = !wasEditing
        ? await widget.onAddSet(
            reps: reps,
            setType: _setType,
            originalWeightValue: weight,
            weightUnit: weight == null ? null : _weightUnit,
            rpe: rpe,
            tempo: _tempoController.text,
            restSeconds: rest,
            notes: _notesController.text,
          )
        : await widget.onUpdateSet(
            existingSet: _editingSet!,
            reps: reps,
            setType: _setType,
            originalWeightValue: weight,
            weightUnit: weight == null ? null : _weightUnit,
            rpe: rpe,
            tempo: _tempoController.text,
            restSeconds: rest,
            notes: _notesController.text,
          );
    setState(() => _isSaving = false);
    setState(() {
      _editingSet = null;
      _clearInputs();
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          !wasEditing
              ? isPr
                    ? 'Set logged. New PR detected.'
                    : 'Set logged.'
              : isPr
              ? 'Set updated. New PR detected.'
              : 'Set updated.',
        ),
      ),
    );
  }

  Future<void> _handleRepeatLastSet() async {
    setState(() => _isSaving = true);
    final isPr = await widget.onRepeatLastSet();
    setState(() => _isSaving = false);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isPr ? 'Repeated last set. New PR detected.' : 'Repeated last set.',
        ),
      ),
    );
  }

  void _startEditingSet(SetEntry set) {
    _editingSet = set;
    _repsController.text = set.reps.toString();
    _weightController.text = set.weight == null
        ? ''
        : _formatDouble(set.weight!.originalValue);
    _rpeController.text = set.rpe == null ? '' : _formatDouble(set.rpe!);
    _tempoController.text = set.tempo ?? '';
    _restController.text = set.restSeconds?.toString() ?? '';
    _notesController.text = set.notes ?? '';
    _setType = set.setType;
    _weightUnit = set.weight?.originalUnit ?? WeightUnit.kilograms;
    _showAdvanced =
        set.rpe != null ||
        set.tempo != null ||
        set.restSeconds != null ||
        set.notes != null;
    setState(() {});
  }

  void _cancelEditing() {
    _editingSet = null;
    _clearInputs();
    setState(() {});
  }

  void _clearInputs() {
    _repsController.clear();
    _weightController.clear();
    _rpeController.clear();
    _tempoController.clear();
    _restController.text = '90';
    _notesController.clear();
    _showAdvanced = false;
  }

  Future<void> _deleteSet(SetEntry set) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Set'),
          content: const Text('Remove this set from the live workout?'),
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

    if (_editingSet?.id == set.id) {
      _cancelEditing();
    }

    await widget.onDeleteSet(set);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Set removed.')));
  }
}

String _setTypeLabel(SetType type) {
  switch (type) {
    case SetType.normal:
      return 'Normal';
    case SetType.warmUp:
      return 'Warm-up';
    case SetType.drop:
      return 'Drop';
    case SetType.failure:
      return 'Failure';
  }
}

class _LoggedSetRow extends StatelessWidget {
  const _LoggedSetRow({
    required this.viewModel,
    required this.onEdit,
    required this.onDelete,
  });

  final WorkoutSetDisplayViewModel viewModel;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final accent = switch (viewModel.setTypeLabel) {
      'warmUp' => AppColors.electricBlue,
      'drop' => AppColors.vividOrange,
      'failure' => AppColors.vividOrange,
      _ => Theme.of(context).colorScheme.secondary,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  viewModel.indexLabel.replaceFirst('#', ''),
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: accent),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  viewModel.setTypeLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: accent),
                ),
              ),
              IconButton(
                tooltip: 'Edit set',
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'Delete set',
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline),
              ),
              Text(
                viewModel.estimatedOneRepMaxLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: Text(viewModel.weightLabel)),
              Expanded(child: Text(viewModel.repsLabel)),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              viewModel.metaLabel,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricInput extends StatelessWidget {
  const _MetricInput({
    required this.controller,
    required this.label,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _WorkoutEmptyMessage extends StatelessWidget {
  const _WorkoutEmptyMessage({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(message, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

String _formatDouble(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}
