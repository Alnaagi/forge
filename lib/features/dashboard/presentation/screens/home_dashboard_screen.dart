import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/insight_providers.dart';
import 'package:forge/application/providers/health_sync_providers.dart';
import 'package:forge/application/providers/settings_providers.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/features/insights/presentation/controllers/insight_action_resolver.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/nutrition_dashboard_controller.dart';
import 'package:forge/features/nutrition/presentation/widgets/nutrition_formatters.dart';
import 'package:forge/shared/enums/volume_unit.dart';
import 'package:forge/features/workouts/presentation/controllers/workout_history_controller.dart';
import 'package:forge/features/workouts/presentation/mappers/workout_display_mapper.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:go_router/go_router.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(workoutHistoryProvider);
    final insightsAsync = ref.watch(activeInsightsProvider);
    final nutritionAsync = ref.watch(nutritionDayOverviewProvider);
    final healthOverview = ref.watch(healthOverviewProvider);
    final healthSyncOverview = ref
        .watch(healthSyncOverviewProvider)
        .valueOrNull;
    final gymMembershipAsync = ref.watch(gymMembershipStatusProvider);
    final dashboardOrder =
        ref.watch(dashboardSectionOrderProvider).valueOrNull ??
        defaultDashboardSectionOrder;
    final displayMapper = WorkoutDisplayMapper(
      metrics: ref.watch(workoutMetricsServiceProvider),
    );

    final sectionWidgets = <DashboardSection, Widget>{
      DashboardSection.systemStatus: nutritionAsync.when(
        data: (overview) => AppPanel(
          gradient: AppColors.greenPanelGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Status',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                overview.totalHydrationMilliliters < 1500
                    ? 'Push hydration before the next hard block.'
                    : 'Recovery inputs are moving in the right direction.',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${NutritionFormatters.hydrationMilliliters(overview.totalHydrationMilliliters)} logged today across ${overview.hydrationLogs.length} entries. Deterministic insights and reminder planning are already live, so this panel is your quick read on whether recovery inputs look steady.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        error: (error, stackTrace) =>
            AppPanel(child: AppErrorState(message: error.toString())),
        loading: () => const AppPanel(
          child: SizedBox(
            height: 180,
            child: AppLoadingView(label: 'Loading home status'),
          ),
        ),
      ),
      DashboardSection.insights: insightsAsync.when(
        data: (insights) => _InsightsPanel(insights: insights),
        error: (error, stackTrace) =>
            AppPanel(child: AppErrorState(message: error.toString())),
        loading: () => const AppPanel(
          child: SizedBox(
            height: 132,
            child: AppLoadingView(label: 'Loading insights'),
          ),
        ),
      ),
      DashboardSection.healthWatch: AppPanel(
        gradient: AppColors.orangePanelGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Health Watch', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              healthOverview.activeLogs.isEmpty
                  ? 'No active symptoms, pain, or injury flags right now.'
                  : '${healthOverview.activeLogs.length} active health flags need a little awareness today.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (healthOverview.generalAdvice.isEmpty)
              Text(
                'Log health or mood changes so Forge can keep connecting recovery context to food and training.',
                style: Theme.of(context).textTheme.bodySmall,
              )
            else
              for (final line in healthOverview.generalAdvice.take(2))
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Text(
                    line,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                OutlinedButton.icon(
                  onPressed: () => context.pushNamed(RouteNames.healthStatus),
                  icon: const Icon(Icons.health_and_safety_outlined),
                  label: const Text('Open Health'),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.pushNamed(RouteNames.integrations),
                  icon: const Icon(Icons.sync_outlined),
                  label: const Text('Health Connect'),
                ),
                if (healthOverview.profile != null)
                  _HealthBadge(
                    label:
                        '${healthOverview.profile!.allergies.length} allergies',
                  ),
                if (healthOverview.profile != null)
                  _HealthBadge(
                    label: '${healthOverview.profile!.medications.length} meds',
                  ),
                if (healthSyncOverview?.todaySteps != null)
                  _HealthBadge(
                    label: '${healthSyncOverview!.todaySteps} synced steps',
                  ),
              ],
            ),
          ],
        ),
      ),
      DashboardSection.gymMembership: gymMembershipAsync.when(
        data: (membership) => _GymMembershipPanel(
          membership: membership,
          onSetStartDate: () => _pickGymMembershipStartDate(context, ref),
          onRenewToday: membership == null
              ? null
              : () => ref
                    .read(gymMembershipControllerProvider)
                    .renewToday(cycleDays: membership.cycleDays),
        ),
        error: (error, stackTrace) =>
            AppPanel(child: AppErrorState(message: error.toString())),
        loading: () => const AppPanel(
          child: SizedBox(
            height: 132,
            child: AppLoadingView(label: 'Loading gym membership'),
          ),
        ),
      ),
      DashboardSection.quickMetrics: Row(
        children: [
          Expanded(
            child: nutritionAsync.when(
              data: (overview) => _MetricPanel(
                label: 'Hydration',
                value: NutritionFormatters.hydrationMilliliters(
                  overview.totalHydrationMilliliters,
                ),
                accent: AppColors.electricBlue,
                subtitle: '${overview.hydrationLogs.length} entries today',
              ),
              error: (_, __) => const _MetricPanel(
                label: 'Hydration',
                value: '--',
                accent: AppColors.electricBlue,
                subtitle: 'Unavailable',
              ),
              loading: () => const _MetricPanel(
                label: 'Hydration',
                value: '...',
                accent: AppColors.electricBlue,
                subtitle: 'Loading',
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: historyAsync.when(
              data: (items) => _MetricPanel(
                label: 'Recent Work',
                value: items.isEmpty ? '0' : items.length.toString(),
                accent: AppColors.vividOrange,
                subtitle: items.isEmpty ? 'No sessions yet' : 'Sessions logged',
              ),
              error: (_, __) => const _MetricPanel(
                label: 'Recent Work',
                value: '--',
                accent: AppColors.vividOrange,
                subtitle: 'Unavailable',
              ),
              loading: () => const _MetricPanel(
                label: 'Recent Work',
                value: '...',
                accent: AppColors.vividOrange,
                subtitle: 'Loading',
              ),
            ),
          ),
        ],
      ),
      DashboardSection.quickRoutes: AppPanel(
        gradient: AppColors.bluePanelGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick Routes', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                FilledButton(
                  onPressed: () => context.goNamed(RouteNames.workouts),
                  child: const Text('Open Workouts'),
                ),
                FilledButton.tonal(
                  onPressed: () => context.pushNamed(RouteNames.insights),
                  child: const Text('Open Insights'),
                ),
                FilledButton.tonal(
                  onPressed: () => context.pushNamed(RouteNames.goals),
                  child: const Text('Open Goals'),
                ),
                FilledButton.tonal(
                  onPressed: () => context.goNamed(RouteNames.nutrition),
                  child: const Text('Open Nutrition'),
                ),
                OutlinedButton(
                  onPressed: () => context.goNamed(RouteNames.progress),
                  child: const Text('Open Progress'),
                ),
                OutlinedButton(
                  onPressed: () => context.pushNamed(RouteNames.healthStatus),
                  child: const Text('Open Health'),
                ),
              ],
            ),
          ],
        ),
      ),
      DashboardSection.latestSession: historyAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const AppPanel(
              child: AppEmptyState(
                icon: Icons.fitness_center,
                title: 'No sessions logged yet',
                message:
                    'Start your first workout to light up history, session detail, and future dashboard surfaces.',
              ),
            );
          }

          final latest = displayMapper.toHistoryItem(items.first);
          return AppPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latest Session',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  latest.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  latest.subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  latest.volumeLabel,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) =>
            AppPanel(child: AppErrorState(message: error.toString())),
        loading: () => const AppPanel(
          child: SizedBox(
            height: 132,
            child: AppLoadingView(label: 'Loading recent session'),
          ),
        ),
      ),
    };

    return AppScaffold(
      title: 'Hello, Elite',
      eyebrow: 'Forge',
      subtitle: 'Your local-first command floor for training and fueling.',
      actions: [
        IconButton(
          tooltip: 'Customize dashboard',
          onPressed: () => _openCustomizeDashboardSheet(context, ref),
          icon: const Icon(Icons.dashboard_customize_outlined),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openQuickAdd(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Quick Add'),
      ),
      child: ListView(
        children: _orderedSectionChildren(
          order: dashboardOrder,
          sectionWidgets: sectionWidgets,
        ),
      ),
    );
  }

  Future<void> _pickGymMembershipStartDate(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final settings = await ref.read(gymMembershipSettingsProvider.future);
    if (!context.mounted) {
      return;
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: settings?.startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate == null) {
      return;
    }

    await ref
        .read(gymMembershipControllerProvider)
        .saveMembership(
          startDate: pickedDate,
          cycleDays: settings?.cycleDays ?? 30,
        );
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gym membership start date saved.')),
    );
  }

  Future<void> _openQuickAdd(BuildContext context, WidgetRef ref) async {
    final parentContext = context;
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Add',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                _QuickAddAction(
                  icon: Icons.local_drink_outlined,
                  label: 'Water +250 ml',
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    await ref
                        .read(nutritionActionsProvider)
                        .addHydration(
                          amount: 250,
                          unit: VolumeUnit.milliliters,
                        );
                  },
                ),
                _QuickAddAction(
                  icon: Icons.restaurant_menu_outlined,
                  label: 'Log Food',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    parentContext.pushNamed(RouteNames.foodSearch);
                  },
                ),
                _QuickAddAction(
                  icon: Icons.monitor_weight_outlined,
                  label: 'Body Check-In',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    parentContext.goNamed(RouteNames.progress);
                  },
                ),
                _QuickAddAction(
                  icon: Icons.self_improvement_outlined,
                  label: 'Health / Mood',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    parentContext.pushNamed(
                      RouteNames.healthStatus,
                      queryParameters: {'compose': 'true', 'entryType': 'mood'},
                    );
                  },
                ),
                _QuickAddAction(
                  icon: Icons.healing_outlined,
                  label: 'Pain / Injury',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    parentContext.pushNamed(
                      RouteNames.healthStatus,
                      queryParameters: {'compose': 'true', 'entryType': 'pain'},
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openCustomizeDashboardSheet(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final controller = ref.read(dashboardLayoutControllerProvider);
    final savedOrder = List<DashboardSection>.from(
      ref.read(dashboardSectionOrderProvider).valueOrNull ??
          defaultDashboardSectionOrder,
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        var draftOrder = List<DashboardSection>.from(savedOrder);

        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customize Dashboard',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Drag sections into the order you want. This layout stays saved on this device.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Expanded(
                        child: ReorderableListView.builder(
                          itemCount: draftOrder.length,
                          buildDefaultDragHandles: false,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final section = draftOrder.removeAt(oldIndex);
                              draftOrder.insert(newIndex, section);
                            });
                          },
                          itemBuilder: (context, index) {
                            final section = draftOrder[index];
                            return Card(
                              key: ValueKey(section.name),
                              margin: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: ListTile(
                                title: Text(section.label),
                                subtitle: Text(section.description),
                                leading: CircleAvatar(
                                  radius: 16,
                                  child: Text('${index + 1}'),
                                ),
                                trailing: ReorderableDragStartListener(
                                  index: index,
                                  child: const Icon(Icons.drag_handle),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                draftOrder = List<DashboardSection>.from(
                                  defaultDashboardSectionOrder,
                                );
                              });
                            },
                            child: const Text('Reset Default'),
                          ),
                          FilledButton(
                            onPressed: () async {
                              await controller.saveSectionOrder(draftOrder);
                              if (!sheetContext.mounted) {
                                return;
                              }
                              Navigator.of(sheetContext).pop();
                            },
                            child: const Text('Save Layout'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

List<Widget> _orderedSectionChildren({
  required List<DashboardSection> order,
  required Map<DashboardSection, Widget> sectionWidgets,
}) {
  final children = <Widget>[];
  for (final section in order) {
    final widget = sectionWidgets[section];
    if (widget == null) {
      continue;
    }
    if (children.isNotEmpty) {
      children.add(const SizedBox(height: AppSpacing.md));
    }
    children.add(widget);
  }
  return children;
}

class _QuickAddAction extends StatelessWidget {
  const _QuickAddAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon),
        title: Text(label),
        onTap: onTap,
      ),
    );
  }
}

class _InsightsPanel extends ConsumerWidget {
  const _InsightsPanel({required this.insights});

  final List<Insight> insights;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topInsights = insights.take(2).toList(growable: false);

    return AppPanel(
      gradient: AppColors.bluePanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Insights',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () => context.pushNamed(RouteNames.insights),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            insights.isEmpty
                ? 'No active deterministic alerts right now.'
                : '${insights.length} active signal${insights.length == 1 ? '' : 's'} are shaping today.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (insights.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            for (final insight in topInsights) ...[
              _DashboardInsightTile(insight: insight),
              if (insight != topInsights.last)
                const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ],
      ),
    );
  }
}

class _DashboardInsightTile extends ConsumerWidget {
  const _DashboardInsightTile({required this.insight});

  final Insight insight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = resolveInsightActions(insight);
    final primaryAction = actions.isEmpty ? null : actions.first;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(insight.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            insight.shortMessage,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            insight.suggestedAction,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (primaryAction != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => executeInsightAction(
                  context: context,
                  ref: ref,
                  action: primaryAction,
                ),
                icon: Icon(primaryAction.icon),
                label: Text(primaryAction.label),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _HealthBadge extends StatelessWidget {
  const _HealthBadge({required this.label});

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

class _GymMembershipPanel extends StatelessWidget {
  const _GymMembershipPanel({
    required this.membership,
    required this.onSetStartDate,
    required this.onRenewToday,
  });

  final GymMembershipStatus? membership;
  final VoidCallback onSetStartDate;
  final VoidCallback? onRenewToday;

  @override
  Widget build(BuildContext context) {
    if (membership == null) {
      return AppPanel(
        gradient: AppColors.bluePanelGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gym Membership',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Track when your monthly gym subscription starts so Forge can count it down and warn you before it ends.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: onSetStartDate,
              icon: const Icon(Icons.calendar_month_outlined),
              label: const Text('Set Start Date'),
            ),
          ],
        ),
      );
    }

    final accent = _membershipAccent(membership!);
    final brightness = Theme.of(context).brightness;
    final headline = membership!.isExpired
        ? 'Membership expired'
        : '${membership!.daysRemaining} day${membership!.daysRemaining == 1 ? '' : 's'} left';
    final subtitle = membership!.isWarning
        ? 'Last 3 days. Time to plan the renewal.'
        : membership!.isNearEnd
        ? 'Approaching the end of this cycle.'
        : 'Cycle started ${membership!.daysElapsed} day${membership!.daysElapsed == 1 ? '' : 's'} ago.';

    return AppPanel(
      gradient: AppColors.bluePanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Gym Membership',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (membership!.isWarning)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.crimson.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Last 3 days',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppColors.crimson),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            headline,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(color: accent),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: membership!.progress,
              minHeight: 12,
              backgroundColor: AppColors.progressTrackFor(brightness),
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Started ${_formatDate(membership!.startDate)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Text(
                'Renews ${_formatDate(membership!.renewalDate)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilledButton.tonal(
                onPressed: onSetStartDate,
                child: const Text('Edit Start Date'),
              ),
              if (onRenewToday != null)
                OutlinedButton(
                  onPressed: onRenewToday,
                  child: const Text('Renew Today'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _membershipAccent(GymMembershipStatus membership) {
    if (membership.isExpired || membership.isWarning) {
      return AppColors.crimson;
    }
    if (membership.isNearEnd) {
      return AppColors.vividOrange;
    }
    return AppColors.neonGreen;
  }
}

class _MetricPanel extends StatelessWidget {
  const _MetricPanel({
    required this.label,
    required this.value,
    required this.accent,
    required this.subtitle,
  });

  final String label;
  final String value;
  final Color accent;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: AppSpacing.lg),
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

String _formatDate(DateTime value) {
  final local = value.toLocal();
  return '${local.month}/${local.day}/${local.year}';
}
