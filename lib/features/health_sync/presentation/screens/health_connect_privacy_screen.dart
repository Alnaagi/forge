import 'package:flutter/material.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';

class HealthConnectPrivacyScreen extends StatelessWidget {
  const HealthConnectPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Health Connect Privacy',
      eyebrow: 'Permission Rationale',
      subtitle:
          'Forge reads only the Health Connect data needed for progress, recovery, and consistency features. It does not make Health Connect your source of truth.',
      child: ListView(
        children: const [
          _PrivacyIntroPanel(),
          SizedBox(height: AppSpacing.md),
          _PermissionReasonPanel(
            title: 'Steps',
            accent: AppColors.neonGreen,
            explanation:
                'Forge reads step totals to improve daily activity context, dashboard summaries, and future consistency insights.',
          ),
          SizedBox(height: AppSpacing.md),
          _PermissionReasonPanel(
            title: 'Heart Rate',
            accent: AppColors.electricBlue,
            explanation:
                'Forge reads heart rate samples when available to enrich recovery context and imported health summaries.',
          ),
          SizedBox(height: AppSpacing.md),
          _PermissionReasonPanel(
            title: 'Sleep',
            accent: AppColors.vividOrange,
            explanation:
                'Forge reads sleep sessions to show recovery context and support explainable health summaries without inventing missing data.',
          ),
          SizedBox(height: AppSpacing.md),
          _PermissionReasonPanel(
            title: 'Body Weight',
            accent: AppColors.electricBlue,
            explanation:
                'Forge reads body weight so safe imported weigh-ins can appear in progress while your original local entries remain intact.',
          ),
          SizedBox(height: AppSpacing.md),
          _BoundaryPanel(),
        ],
      ),
    );
  }
}

class _PrivacyIntroPanel extends StatelessWidget {
  const _PrivacyIntroPanel();

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      gradient: AppColors.bluePanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What Forge Reads',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Forge requests read-only access to steps, heart rate, sleep, and body weight through Health Connect on Android. These imports help fill in recovery and consistency context around the data you already log in Forge.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _PermissionReasonPanel extends StatelessWidget {
  const _PermissionReasonPanel({
    required this.title,
    required this.accent,
    required this.explanation,
  });

  final String title;
  final Color accent;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: accent),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  explanation,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BoundaryPanel extends StatelessWidget {
  const _BoundaryPanel();

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      gradient: AppColors.orangePanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Data Boundary', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Health Connect is an assistive read-only input for Forge. Imported records sync into Forge locally, repeat syncs are deduped, and Forge keeps its local database as the source of truth for your training, nutrition, progress, and health history.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Forge does not write your workouts, meals, hydration, or health timeline back into Health Connect in this milestone.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
