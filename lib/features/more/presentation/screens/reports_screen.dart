import 'package:flutter/material.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Reports',
      eyebrow: 'Not Built Yet',
      subtitle:
          'Exports and report surfaces will arrive after progress and analytics mature enough to generate trustworthy summaries.',
      child: ListView(
        children: const [
          _ReportCard(
            title: 'Workout Export',
            subtitle:
                'Future export options will package original entered values and canonical analytics values together.',
          ),
          SizedBox(height: AppSpacing.md),
          _ReportCard(
            title: 'Nutrition Export',
            subtitle:
                'Meal logs, saved meals, and hydration history will become exportable once reporting rules are finalized.',
          ),
          SizedBox(height: AppSpacing.md),
          _ReportCard(
            title: 'Progress Reports',
            subtitle:
                'High-signal printable or shareable summaries belong after the progress and analytics milestones, not before.',
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      gradient: AppColors.orangePanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
