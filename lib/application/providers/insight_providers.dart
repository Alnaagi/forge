import 'package:forge/application/providers/goal_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/insight_dao.dart';
import 'package:forge/data/repositories/insight_repository_impl.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/domain/repositories/insight_repository.dart';
import 'package:forge/domain/services/deterministic_insight_engine.dart';
import 'package:forge/domain/services/nutrition_insight_rule_service.dart';
import 'package:forge/features/body_metrics/presentation/controllers/body_progress_controller.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/nutrition_dashboard_controller.dart';
import 'package:forge/features/workouts/presentation/controllers/workout_history_controller.dart';
import 'package:forge/application/providers/settings_providers.dart';
import 'package:forge/shared/enums/insight_status.dart';

final insightDaoProvider = Provider<InsightDao>((ref) {
  return InsightDao(ref.watch(appDatabaseProvider));
});

final insightRepositoryProvider = Provider<InsightRepository>((ref) {
  return InsightRepositoryImpl(ref.watch(insightDaoProvider));
});

final deterministicInsightEngineProvider = Provider<DeterministicInsightEngine>(
  (ref) {
    return const DeterministicInsightEngine();
  },
);

final insightSyncProvider = FutureProvider<void>((ref) async {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final nutritionOverview = await ref.watch(
    nutritionDayOverviewProvider.future,
  );
  final workoutHistory = await ref.watch(workoutHistoryProvider.future);
  final bodyLogs = await ref.watch(bodyLogsProvider.future);
  final healthLogs = await ref.watch(healthStatusLogsProvider.future);
  final membership = await ref.watch(gymMembershipStatusProvider.future);
  final activeGoal = await ref.watch(activeGoalProvider.future);
  final macroCalculator = ref.watch(macroCalculatorServiceProvider);
  final workoutRepository = ref.watch(workoutRepositoryProvider);
  final nutritionRepository = ref.watch(nutritionRepositoryProvider);
  final recentNutritionDays = <NutritionInsightDaySnapshot>[];
  for (var offset = 0; offset < 4; offset += 1) {
    final day = today.subtract(Duration(days: offset));
    final mealEntries = await nutritionRepository.getMealEntryDetailsForDay(
      day,
    );
    final hydrationLogs = await nutritionRepository.getHydrationLogsForDay(day);
    recentNutritionDays.add(
      NutritionInsightDaySnapshot(
        day: day,
        totals: macroCalculator.combine(
          mealEntries.map((entry) => entry.macros),
        ),
        hydrationMilliliters: hydrationLogs.fold<double>(
          0,
          (sum, log) => sum + log.amount.canonicalMilliliters,
        ),
      ),
    );
  }
  final recentWorkoutDetails = (await Future.wait(
    (await workoutRepository.getSessions())
        .where((session) => session.endedAt != null)
        .take(8)
        .map((session) => workoutRepository.getSessionDetail(session.id)),
  )).whereType<WorkoutSessionDetail>().toList(growable: false);
  final engine = ref.watch(deterministicInsightEngineProvider);
  final repository = ref.watch(insightRepositoryProvider);

  final generatedInsights = engine.generate(
    now: now,
    hydrationMillilitersToday: nutritionOverview.totalHydrationMilliliters,
    workoutHistory: workoutHistory,
    recentWorkoutDetails: recentWorkoutDetails,
    todayNutritionTotals: nutritionOverview.totals,
    recentNutritionDays: recentNutritionDays,
    activeGoal: activeGoal,
    bodyLogs: bodyLogs,
    activeHealthLogs: healthLogs
        .where((log) => log.isActive)
        .toList(growable: false),
    gymMembershipDaysRemaining: membership?.daysRemaining,
  );

  final existingInsights = await repository.getAllInsights();
  final existingById = {
    for (final insight in existingInsights) insight.id: insight,
  };
  final generatedIds = generatedInsights.map((insight) => insight.id).toSet();

  for (final generatedInsight in generatedInsights) {
    final existing = existingById[generatedInsight.id];
    final resolvedStatus =
        existing?.status == InsightStatus.dismissed ||
            existing?.status == InsightStatus.archived
        ? existing!.status
        : InsightStatus.active;

    await repository.saveInsight(
      generatedInsight.copyWith(
        status: resolvedStatus,
        createdAt: existing?.createdAt ?? generatedInsight.createdAt,
        updatedAt: now,
      ),
    );
  }

  for (final existing in existingInsights) {
    if (existing.status == InsightStatus.active &&
        !generatedIds.contains(existing.id)) {
      await repository.updateStatus(
        insightId: existing.id,
        status: InsightStatus.archived,
      );
    }
  }
});

final activeInsightsProvider = FutureProvider<List<Insight>>((ref) async {
  await ref.watch(insightSyncProvider.future);
  return ref.watch(insightRepositoryProvider).getActiveInsights();
});

final insightsControllerProvider = Provider<InsightsController>((ref) {
  return InsightsController(ref);
});

class InsightsController {
  const InsightsController(this._ref);

  final Ref _ref;

  Future<void> dismissInsight(String insightId) async {
    await _ref
        .read(insightRepositoryProvider)
        .updateStatus(insightId: insightId, status: InsightStatus.dismissed);
    _invalidate();
  }

  Future<void> refresh() async {
    _invalidate();
    await _ref.read(insightSyncProvider.future);
  }

  void _invalidate() {
    _ref.invalidate(insightSyncProvider);
    _ref.invalidate(activeInsightsProvider);
  }
}
