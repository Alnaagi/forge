import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/core/widgets/trend_sparkline.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/health_sync_providers.dart';
import 'package:forge/application/providers/profile_providers.dart';
import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/domain/services/body_baseline_service.dart';
import 'package:forge/features/body_metrics/presentation/controllers/body_progress_controller.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/value_objects/trend_point.dart';
import 'package:go_router/go_router.dart';

class BodyProgressScreen extends ConsumerWidget {
  const BodyProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bodyLogsAsync = ref.watch(bodyLogsProvider);
    final summary = ref.watch(bodyProgressSummaryProvider);
    final healthSyncOverview = ref
        .watch(healthSyncOverviewProvider)
        .valueOrNull;
    final profile = ref.watch(currentUserProfileProvider).valueOrNull;
    final baselineMetrics = const BodyBaselineService().calculate(
      weightKilograms: summary.latestWeight,
      heightCentimeters: profile?.height?.canonicalCentimeters,
      waistCentimeters: summary.latestWaist,
    );

    return AppScaffold(
      title: 'Progress',
      eyebrow: 'Body Metrics',
      subtitle:
          'Track bodyweight and measurements with original units preserved for history and canonical values kept for analytics.',
      child: bodyLogsAsync.when(
        data: (logs) {
          final latest = logs.isEmpty ? null : logs.first;
          return ListView(
            children: [
              AppPanel(
                gradient: AppColors.greenPanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      latest == null
                          ? 'No metrics logged yet'
                          : 'Latest check-in',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (latest == null)
                      Text(
                        'Start with bodyweight, waist, or body fat. You can log one metric or all three.',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    else
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          if (latest.bodyWeight != null)
                            _MetricBadge(
                              label:
                                  'Weight ${_formatNumber(latest.bodyWeight!.originalValue)} ${latest.bodyWeight!.originalUnit.symbol}',
                            ),
                          if (latest.waist != null)
                            _MetricBadge(
                              label:
                                  'Waist ${_formatNumber(latest.waist!.originalValue)} ${latest.waist!.originalUnit.symbol}',
                            ),
                          if (latest.bodyFatPercentage != null)
                            _MetricBadge(
                              label:
                                  'Body Fat ${_formatNumber(latest.bodyFatPercentage!.value)}%',
                            ),
                        ],
                      ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton.icon(
                      onPressed: () => _openLogDialog(context, ref),
                      icon: const Icon(Icons.add),
                      label: const Text('Log Metrics'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: () =>
                          context.pushNamed(RouteNames.healthStatus),
                      icon: const Icon(Icons.health_and_safety_outlined),
                      label: const Text('Open Health Timeline'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: 'Check-ins',
                      value: summary.totalLogs.toString(),
                      subtitle: summary.latestLog == null
                          ? 'No baseline yet'
                          : 'Last on ${_formatLoggedAt(summary.latestLog!.loggedAt)}',
                      accent: AppColors.electricBlue,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _SummaryCard(
                      title: 'Weight Trend',
                      value: _signedMetric(summary.weightDeltaKilograms, 'kg'),
                      subtitle: summary.latestWeight == null
                          ? 'No weight logged'
                          : 'Latest ${_formatNumber(summary.latestWeight!)} kg',
                      accent: AppColors.neonGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: 'Waist Trend',
                      value: _signedMetric(summary.waistDeltaCentimeters, 'cm'),
                      subtitle: summary.latestWaist == null
                          ? 'No waist logged'
                          : 'Latest ${_formatNumber(summary.latestWaist!)} cm',
                      accent: AppColors.electricBlue,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _SummaryCard(
                      title: 'Body Fat Trend',
                      value: _signedMetric(summary.bodyFatDeltaPercentage, '%'),
                      subtitle: summary.latestBodyFatPercentage == null
                          ? 'No body fat logged'
                          : 'Latest ${_formatNumber(summary.latestBodyFatPercentage!)}%',
                      accent: AppColors.vividOrange,
                    ),
                  ),
                ],
              ),
              if (baselineMetrics.bmi != null ||
                  baselineMetrics.waistToHeightRatio != null ||
                  profile?.activityLevel != null) ...[
                const SizedBox(height: AppSpacing.md),
                AppPanel(
                  gradient: AppColors.orangePanelGradient,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Baseline Signals',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Calculated from your saved height, latest weight, latest waist, and activity level. Body fat is only shown when you log it directly.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          if (baselineMetrics.bmi != null)
                            _MetricBadge(
                              label:
                                  'BMI ${baselineMetrics.bmi!.toStringAsFixed(1)} | ${baselineMetrics.bmiLabel}',
                            ),
                          if (baselineMetrics.waistToHeightRatio != null)
                            _MetricBadge(
                              label:
                                  'Waist/height ${baselineMetrics.waistToHeightRatio!.toStringAsFixed(2)} | ${baselineMetrics.waistToHeightLabel}',
                            ),
                          if (profile?.activityLevel != null)
                            _MetricBadge(
                              label:
                                  'Activity ${profile!.activityLevel!.label}',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              if (healthSyncOverview?.latestBodyWeight != null) ...[
                const SizedBox(height: AppSpacing.md),
                AppPanel(
                  gradient: AppColors.bluePanelGradient,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Health Connect Import',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${_formatNumber(healthSyncOverview!.latestBodyWeight!.numericValue)} kg imported on ${_formatLoggedAt(healthSyncOverview.latestBodyWeight!.recordedAt)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Imported weight records are mirrored into Forge progress when they do not collide with an existing local check-in.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trend Lines',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Your last few check-ins, normalized for clean analytics while history keeps the original units you entered.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _TrendSection(
                      title: 'Weight',
                      accent: AppColors.neonGreen,
                      unitLabel: 'kg',
                      points: summary.weightTrend,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _TrendSection(
                      title: 'Waist',
                      accent: AppColors.electricBlue,
                      unitLabel: 'cm',
                      points: summary.waistTrend,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _TrendSection(
                      title: 'Body Fat',
                      accent: AppColors.vividOrange,
                      unitLabel: '%',
                      points: summary.bodyFatTrend,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (logs.isEmpty)
                const AppPanel(
                  child: AppEmptyState(
                    icon: Icons.monitor_weight_outlined,
                    title: 'No progress entries yet',
                    message:
                        'Your check-ins will appear here once you start logging bodyweight or measurements.',
                  ),
                )
              else
                for (final log in logs) ...[
                  AppPanel(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatLoggedAt(log.loggedAt),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              if (log.bodyWeight != null)
                                Text(
                                  'Weight: ${_formatNumber(log.bodyWeight!.originalValue)} ${log.bodyWeight!.originalUnit.symbol}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              if (log.waist != null)
                                Text(
                                  'Waist: ${_formatNumber(log.waist!.originalValue)} ${log.waist!.originalUnit.symbol}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              if (log.bodyFatPercentage != null)
                                Text(
                                  'Body Fat: ${_formatNumber(log.bodyFatPercentage!.value)}%',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              if ((log.notes ?? '').trim().isNotEmpty) ...[
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  log.notes!.trim(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              tooltip: 'Edit progress log',
                              onPressed: () => _openLogDialog(
                                context,
                                ref,
                                existingLog: log,
                              ),
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              tooltip: 'Delete progress log',
                              onPressed: () => _deleteLog(context, ref, log),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
            ],
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading body progress'),
      ),
    );
  }

  Future<void> _openLogDialog(
    BuildContext context,
    WidgetRef ref, {
    BodyLog? existingLog,
  }) async {
    final weightController = TextEditingController(
      text: existingLog?.bodyWeight == null
          ? ''
          : _formatNumber(existingLog!.bodyWeight!.originalValue),
    );
    final waistController = TextEditingController(
      text: existingLog?.waist == null
          ? ''
          : _formatNumber(existingLog!.waist!.originalValue),
    );
    final bodyFatController = TextEditingController(
      text: existingLog?.bodyFatPercentage == null
          ? ''
          : _formatNumber(existingLog!.bodyFatPercentage!.value),
    );
    final notesController = TextEditingController(
      text: existingLog?.notes ?? '',
    );
    var selectedWeightUnit =
        existingLog?.bodyWeight?.originalUnit ?? WeightUnit.kilograms;
    var selectedWaistUnit =
        existingLog?.waist?.originalUnit ?? BodyMetricUnit.centimeters;

    final didSave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                existingLog == null ? 'Log Progress' : 'Edit Progress',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: weightController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Bodyweight',
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: DropdownButtonFormField<WeightUnit>(
                            initialValue: selectedWeightUnit,
                            decoration: const InputDecoration(
                              labelText: 'Unit',
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
                              setState(() => selectedWeightUnit = value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: waistController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Waist',
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: DropdownButtonFormField<BodyMetricUnit>(
                            initialValue: selectedWaistUnit,
                            decoration: const InputDecoration(
                              labelText: 'Unit',
                            ),
                            items: BodyMetricUnit.values
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
                              setState(() => selectedWaistUnit = value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: bodyFatController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Body Fat %',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: notesController,
                      minLines: 1,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Notes'),
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
                    try {
                      await ref
                          .read(bodyMetricsControllerProvider)
                          .saveBodyLog(
                            existingLog: existingLog,
                            weightValue: _tryParse(weightController.text),
                            weightUnit: selectedWeightUnit,
                            waistValue: _tryParse(waistController.text),
                            waistUnit: selectedWaistUnit,
                            bodyFatPercentage: _tryParse(
                              bodyFatController.text,
                            ),
                            notes: notesController.text,
                          );
                    } on StateError catch (error) {
                      if (!dialogContext.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(
                        dialogContext,
                      ).showSnackBar(SnackBar(content: Text(error.message)));
                      return;
                    }
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

    weightController.dispose();
    waistController.dispose();
    bodyFatController.dispose();
    notesController.dispose();

    if (didSave != true || !context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existingLog == null ? 'Progress logged.' : 'Progress updated.',
        ),
      ),
    );
  }

  Future<void> _deleteLog(
    BuildContext context,
    WidgetRef ref,
    BodyLog log,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Progress Log'),
          content: const Text('Remove this body metrics entry?'),
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

    await ref.read(bodyMetricsControllerProvider).deleteBodyLog(log.id);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Progress log removed.')));
  }
}

class _TrendSection extends StatelessWidget {
  const _TrendSection({
    required this.title,
    required this.accent,
    required this.unitLabel,
    required this.points,
  });

  final String title;
  final Color accent;
  final String unitLabel;
  final List<TrendPoint> points;

  @override
  Widget build(BuildContext context) {
    final latest = points.isEmpty ? null : points.last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title, style: Theme.of(context).textTheme.labelLarge),
            ),
            Text(
              latest == null
                  ? 'Need 2+ logs'
                  : '${_formatNumber(latest.value)} $unitLabel',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: accent),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        TrendSparkline(
          points: points,
          color: accent,
          emptyLabel: 'Log this metric at least twice to see the line.',
        ),
      ],
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({required this.label});

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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.accent,
  });

  final String title;
  final String value;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.md),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: accent),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

String _formatLoggedAt(DateTime value) {
  final date = value.toLocal();
  final month = switch (date.month) {
    1 => 'Jan',
    2 => 'Feb',
    3 => 'Mar',
    4 => 'Apr',
    5 => 'May',
    6 => 'Jun',
    7 => 'Jul',
    8 => 'Aug',
    9 => 'Sep',
    10 => 'Oct',
    11 => 'Nov',
    _ => 'Dec',
  };
  return '$month ${date.day}, ${date.year}';
}

String _formatNumber(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}

String _signedMetric(double? value, String unit) {
  if (value == null) {
    return 'No baseline';
  }
  final sign = value > 0 ? '+' : '';
  return '$sign${_formatNumber(value)} $unit';
}

double? _tryParse(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  return double.tryParse(trimmed);
}
