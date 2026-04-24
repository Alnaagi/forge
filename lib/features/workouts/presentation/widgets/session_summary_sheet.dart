import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/features/workouts/presentation/mappers/workout_display_mapper.dart';

class SessionSummarySheet extends ConsumerWidget {
  const SessionSummarySheet({
    required this.detail,
    required this.personalRecordCount,
    required this.onViewSession,
    super.key,
  });

  final WorkoutSessionDetail detail;
  final int personalRecordCount;
  final VoidCallback onViewSession;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayMapper = WorkoutDisplayMapper(
      metrics: ref.watch(workoutMetricsServiceProvider),
    );
    final overview = displayMapper.toSessionOverview(detail);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: AppPanel(
          gradient: personalRecordCount > 0
              ? AppColors.orangePanelGradient
              : AppColors.bluePanelGradient,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Workout Complete',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                personalRecordCount > 0
                    ? '$personalRecordCount PRs locked in this session.'
                    : 'Session saved locally and ready for review.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  _SummaryChip(label: overview.durationLabel),
                  _SummaryChip(label: overview.exerciseCountLabel),
                  _SummaryChip(label: overview.setCountLabel),
                  _SummaryChip(label: overview.volumeLabel),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onViewSession,
                  child: const Text('View Session'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label});

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
