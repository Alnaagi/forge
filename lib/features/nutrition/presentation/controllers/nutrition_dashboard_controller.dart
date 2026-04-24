import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/hydration_log.dart';
import 'package:forge/domain/entities/meal_entry_detail.dart';
import 'package:forge/shared/enums/meal_type.dart';
import 'package:forge/shared/enums/volume_unit.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';
import 'package:forge/shared/value_objects/volume_value.dart';

final nutritionSelectedDayProvider = StateProvider.autoDispose<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final nutritionDayOverviewProvider =
    FutureProvider.autoDispose<NutritionDayOverview>((ref) async {
      final repository = ref.watch(nutritionRepositoryProvider);
      final macroCalculator = ref.watch(macroCalculatorServiceProvider);
      final day = ref.watch(nutritionSelectedDayProvider);
      final mealEntries = await repository.getMealEntryDetailsForDay(day);
      final hydrationLogs = await repository.getHydrationLogsForDay(day);

      final mealGroups = <MealType, List<MealEntryDetail>>{
        for (final mealType in MealType.values)
          mealType: mealEntries
              .where((entry) => entry.entry.mealType == mealType)
              .toList(growable: false),
      };

      return NutritionDayOverview(
        day: day,
        mealGroups: mealGroups,
        totals: macroCalculator.combine(
          mealEntries.map((entry) => entry.macros),
        ),
        hydrationLogs: hydrationLogs,
        totalHydrationMilliliters: hydrationLogs.fold<double>(
          0,
          (sum, log) => sum + log.amount.canonicalMilliliters,
        ),
      );
    });

final nutritionActionsProvider = Provider<NutritionActions>((ref) {
  return NutritionActions(ref);
});

class NutritionDayOverview {
  const NutritionDayOverview({
    required this.day,
    required this.mealGroups,
    required this.totals,
    required this.hydrationLogs,
    required this.totalHydrationMilliliters,
  });

  final DateTime day;
  final Map<MealType, List<MealEntryDetail>> mealGroups;
  final NutritionMacros totals;
  final List<HydrationLog> hydrationLogs;
  final double totalHydrationMilliliters;

  List<MealEntryDetail> entriesFor(MealType mealType) {
    return mealGroups[mealType] ?? const <MealEntryDetail>[];
  }
}

class NutritionActions {
  NutritionActions(this._ref);

  final Ref _ref;

  Future<void> addHydration({
    required double amount,
    required VolumeUnit unit,
    DateTime? loggedAt,
  }) async {
    final repository = _ref.read(nutritionRepositoryProvider);
    final uuid = _ref.read(nutritionUuidServiceProvider);
    final now = DateTime.now();
    final time = loggedAt ?? now;

    await repository.saveHydrationLog(
      HydrationLog(
        id: 'hydration-${uuid.next()}',
        amount: VolumeValue(
          originalValue: amount,
          originalUnit: unit,
          canonicalMilliliters: _toMilliliters(amount, unit),
        ),
        loggedAt: time,
        createdAt: now,
        updatedAt: now,
      ),
    );

    _ref.invalidate(nutritionDayOverviewProvider);
  }

  Future<void> updateHydrationLog({
    required HydrationLog existingLog,
    required double amount,
    required VolumeUnit unit,
    DateTime? loggedAt,
  }) async {
    final repository = _ref.read(nutritionRepositoryProvider);

    await repository.saveHydrationLog(
      existingLog.copyWith(
        amount: VolumeValue(
          originalValue: amount,
          originalUnit: unit,
          canonicalMilliliters: _toMilliliters(amount, unit),
        ),
        loggedAt: loggedAt ?? existingLog.loggedAt,
        updatedAt: DateTime.now(),
      ),
    );

    _ref.invalidate(nutritionDayOverviewProvider);
  }

  Future<void> deleteHydrationLog(String hydrationLogId) async {
    await _ref
        .read(nutritionRepositoryProvider)
        .deleteHydrationLog(hydrationLogId);
    _ref.invalidate(nutritionDayOverviewProvider);
  }

  double _toMilliliters(double amount, VolumeUnit unit) {
    switch (unit) {
      case VolumeUnit.milliliters:
        return amount;
      case VolumeUnit.fluidOunces:
        return amount * 29.5735;
    }
  }
}
