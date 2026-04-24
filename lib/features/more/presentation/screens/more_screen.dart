import 'package:flutter/material.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:go_router/go_router.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'More',
      eyebrow: 'Command Center',
      subtitle:
          'Settings, backup, goals, analytics, insights, and the still-deferred surfaces all live here.',
      child: ListView(
        children: [
          _MoreTile(
            title: 'Settings',
            subtitle:
                'Theme, reminders, membership cycle, and app control surfaces.',
            accent: AppColors.electricBlue,
            onTap: () => context.pushNamed(RouteNames.settings),
          ),
          const SizedBox(height: AppSpacing.md),
          _MoreTile(
            title: 'Backup & Sync',
            subtitle:
                'Optional account linking and local-first cloud backup uploads without making sign-in mandatory.',
            accent: AppColors.electricBlue,
            onTap: () => context.pushNamed(RouteNames.backupSync),
          ),
          const SizedBox(height: AppSpacing.md),
          _MoreTile(
            title: 'Goals',
            subtitle:
                'Set the active goal Forge should use for nutrition and insight decisions.',
            accent: AppColors.neonGreen,
            onTap: () => context.pushNamed(RouteNames.goals),
          ),
          const SizedBox(height: AppSpacing.md),
          _MoreTile(
            title: 'Reports & Export',
            subtitle:
                'Not built yet. Export and reporting stay parked here until their rules are real.',
            accent: AppColors.vividOrange,
            onTap: () => context.pushNamed(RouteNames.reports),
          ),
          const SizedBox(height: AppSpacing.md),
          _MoreTile(
            title: 'Integrations',
            subtitle:
                'Health Connect read-only sync status, permissions, and imported device data.',
            accent: AppColors.neonGreen,
            onTap: () => context.pushNamed(RouteNames.integrations),
          ),
          const SizedBox(height: AppSpacing.md),
          _MoreTile(
            title: 'Analytics',
            subtitle: 'Workout and body analytics are live here now.',
            accent: AppColors.electricBlue,
            onTap: () => context.pushNamed(RouteNames.analytics),
          ),
          const SizedBox(height: AppSpacing.md),
          _MoreTile(
            title: 'Insights',
            subtitle:
                'Active deterministic insights with evidence, actions, and dismiss controls.',
            accent: AppColors.vividOrange,
            onTap: () => context.pushNamed(RouteNames.insights),
          ),
        ],
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          accent.withValues(alpha: 0.18),
          Theme.of(context).colorScheme.surfaceContainerLow,
        ],
      ),
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(color: accent),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
