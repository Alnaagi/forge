import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/core/widgets/trend_sparkline.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/features/analytics/presentation/controllers/analytics_overview_controller.dart';

class AnalyticsHomeScreen extends ConsumerWidget {
  const AnalyticsHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(analyticsOverviewProvider);

    return AppScaffold(
      title: 'Analytics',
      eyebrow: 'Operations',
      subtitle:
          'Real local-first summaries built from workout and body data today. Nutrition analytics are still a later expansion, not faked here.',
      child: overviewAsync.when(
        data: (overview) {
          return ListView(
            children: [
              AppPanel(
                gradient: AppColors.bluePanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Training Load',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _AnalyticsBadge(
                          label:
                              '${overview.workouts.totalSessions} total sessions',
                        ),
                        _AnalyticsBadge(
                          label:
                              '${overview.workouts.sessionsLast30Days} sessions in 30d',
                        ),
                        _AnalyticsBadge(
                          label:
                              '${_formatDouble(overview.workouts.totalVolumeKilograms)} kg total volume',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _AnalyticsMetricCard(
                      title: 'Sets Logged',
                      value: overview.workouts.totalSets.toString(),
                      subtitle: 'Across all stored sessions',
                      accent: AppColors.electricBlue,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _AnalyticsMetricCard(
                      title: '30d Volume',
                      value:
                          '${_formatDouble(overview.workouts.volumeLast30Days)} kg',
                      subtitle: 'Recent training load',
                      accent: AppColors.vividOrange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Training Volume Trend',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Recent session volume in canonical kilograms, so trend comparisons stay consistent even if you log mixed units.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TrendSparkline(
                      points: overview.workouts.volumeTrend,
                      color: AppColors.vividOrange,
                      emptyLabel:
                          'Complete at least two sessions to unlock the trend.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppPanel(
                gradient: AppColors.greenPanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Body Trend',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _AnalyticsBadge(
                          label:
                              '${overview.body.checkInCount} progress check-ins',
                        ),
                        if (overview.body.latestWeightKilograms != null)
                          _AnalyticsBadge(
                            label:
                                'Latest weight ${_formatDouble(overview.body.latestWeightKilograms!)} kg',
                          ),
                        if (overview.body.latestWaistCentimeters != null)
                          _AnalyticsBadge(
                            label:
                                'Latest waist ${_formatDouble(overview.body.latestWaistCentimeters!)} cm',
                          ),
                        if (overview.body.latestBodyFatPercentage != null)
                          _AnalyticsBadge(
                            label:
                                'Latest body fat ${_formatDouble(overview.body.latestBodyFatPercentage!)}%',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _AnalyticsMetricCard(
                      title: 'Weight Change',
                      value: _signedMetric(
                        overview.body.weightDeltaKilograms,
                        'kg',
                      ),
                      subtitle: 'Vs previous weight check-in',
                      accent: AppColors.neonGreen,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _AnalyticsMetricCard(
                      title: 'Waist Change',
                      value: _signedMetric(
                        overview.body.waistDeltaCentimeters,
                        'cm',
                      ),
                      subtitle: 'Vs previous waist entry',
                      accent: AppColors.electricBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bodyweight Trend',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'This line follows the last few weigh-ins using normalized kilograms for clean body analytics.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TrendSparkline(
                      points: overview.body.weightTrend,
                      color: AppColors.neonGreen,
                      emptyLabel:
                          'Log at least two bodyweight entries to see the trend.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _AnalyticsMetricCard(
                title: 'Body Fat Change',
                value: _signedMetric(overview.body.bodyFatDeltaPercentage, '%'),
                subtitle: 'Vs previous body fat entry',
                accent: AppColors.vividOrange,
              ),
            ],
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading analytics'),
      ),
    );
  }
}

class _AnalyticsMetricCard extends StatelessWidget {
  const _AnalyticsMetricCard({
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
            ).textTheme.displaySmall?.copyWith(color: accent),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _AnalyticsBadge extends StatelessWidget {
  const _AnalyticsBadge({required this.label});

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

String _formatDouble(double value) {
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
  return '$sign${_formatDouble(value)} $unit';
}
