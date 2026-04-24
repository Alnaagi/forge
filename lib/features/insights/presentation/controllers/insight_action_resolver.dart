import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/features/nutrition/presentation/controllers/nutrition_dashboard_controller.dart';
import 'package:forge/shared/enums/volume_unit.dart';
import 'package:go_router/go_router.dart';

enum InsightActionKind { navigate, addHydration }

class InsightQuickAction {
  const InsightQuickAction({
    required this.label,
    required this.icon,
    required this.kind,
    this.routeName,
    this.queryParameters,
    this.hydrationMilliliters,
  });

  final String label;
  final IconData icon;
  final InsightActionKind kind;
  final String? routeName;
  final Map<String, dynamic>? queryParameters;
  final double? hydrationMilliliters;
}

List<InsightQuickAction> resolveInsightActions(Insight insight) {
  switch (insight.id) {
    case 'insight-hydration-shortfall':
    case 'insight-hydration-streak-miss':
      return const [
        InsightQuickAction(
          label: 'Add 250 ml',
          icon: Icons.local_drink_outlined,
          kind: InsightActionKind.addHydration,
          hydrationMilliliters: 250,
        ),
        InsightQuickAction(
          label: 'Open Nutrition',
          icon: Icons.restaurant_menu_outlined,
          kind: InsightActionKind.navigate,
          routeName: RouteNames.nutrition,
        ),
      ];
    case 'insight-low-protein':
    case 'insight-low-calories-for-goal':
      return const [
        InsightQuickAction(
          label: 'Open Nutrition',
          icon: Icons.restaurant_menu_outlined,
          kind: InsightActionKind.navigate,
          routeName: RouteNames.nutrition,
        ),
        InsightQuickAction(
          label: 'Log Food',
          icon: Icons.add_circle_outline,
          kind: InsightActionKind.navigate,
          routeName: RouteNames.foodSearch,
        ),
      ];
    case 'insight-training-gap':
    case 'insight-training-plateau':
    case 'insight-skipped-muscle-group':
    case 'insight-deload-trigger':
      return const [
        InsightQuickAction(
          label: 'Open Workouts',
          icon: Icons.fitness_center,
          kind: InsightActionKind.navigate,
          routeName: RouteNames.workouts,
        ),
      ];
    case 'insight-body-checkin-missing':
    case 'insight-body-checkin-stale':
      return const [
        InsightQuickAction(
          label: 'Open Progress',
          icon: Icons.monitor_weight_outlined,
          kind: InsightActionKind.navigate,
          routeName: RouteNames.progress,
        ),
      ];
    case 'insight-health-active-flags':
      return const [
        InsightQuickAction(
          label: 'Open Health',
          icon: Icons.health_and_safety_outlined,
          kind: InsightActionKind.navigate,
          routeName: RouteNames.healthStatus,
        ),
      ];
    case 'insight-gym-membership-ending':
      return const [
        InsightQuickAction(
          label: 'Open Settings',
          icon: Icons.settings_outlined,
          kind: InsightActionKind.navigate,
          routeName: RouteNames.settings,
        ),
      ];
  }

  return const [];
}

Future<void> executeInsightAction({
  required BuildContext context,
  required WidgetRef ref,
  required InsightQuickAction action,
}) async {
  switch (action.kind) {
    case InsightActionKind.navigate:
      final routeName = action.routeName;
      if (routeName == null) {
        return;
      }
      context.pushNamed(
        routeName,
        queryParameters: action.queryParameters ?? const <String, dynamic>{},
      );
      return;
    case InsightActionKind.addHydration:
      final amount = action.hydrationMilliliters;
      if (amount == null) {
        return;
      }
      await ref
          .read(nutritionActionsProvider)
          .addHydration(amount: amount, unit: VolumeUnit.milliliters);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${amount.toStringAsFixed(0)} ml added to hydration.'),
        ),
      );
      return;
  }
}
