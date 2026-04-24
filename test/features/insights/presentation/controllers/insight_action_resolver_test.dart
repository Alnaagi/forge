import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/features/insights/presentation/controllers/insight_action_resolver.dart';
import 'package:forge/shared/enums/insight_category.dart';
import 'package:forge/shared/enums/insight_severity.dart';
import 'package:forge/shared/enums/insight_status.dart';

void main() {
  group('resolveInsightActions', () {
    test('maps hydration insight to add water and nutrition actions', () {
      final actions = resolveInsightActions(
        _insight('insight-hydration-shortfall'),
      );

      expect(actions, hasLength(2));
      expect(actions.first.kind, InsightActionKind.addHydration);
      expect(actions.first.hydrationMilliliters, 250);
      expect(actions.last.routeName, RouteNames.nutrition);
    });

    test('maps training insight to workouts action', () {
      final actions = resolveInsightActions(_insight('insight-training-gap'));

      expect(actions, hasLength(1));
      expect(actions.single.routeName, RouteNames.workouts);
      expect(actions.single.icon, Icons.fitness_center);
    });

    test('maps body check-in insight to progress action', () {
      final actions = resolveInsightActions(
        _insight('insight-body-checkin-stale'),
      );

      expect(actions, hasLength(1));
      expect(actions.single.routeName, RouteNames.progress);
    });
  });
}

Insight _insight(String id) {
  final now = DateTime(2026, 4, 21);
  return Insight(
    id: id,
    category: InsightCategory.recovery,
    severity: InsightSeverity.medium,
    status: InsightStatus.active,
    title: 'Title',
    shortMessage: 'Short',
    fullExplanation: 'Full',
    evidenceJson: '{}',
    confidence: 0.8,
    suggestedAction: 'Action',
    createdAt: now,
    updatedAt: now,
  );
}
