import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/application/providers/goal_providers.dart';
import 'package:forge/application/providers/profile_providers.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';
import 'package:forge/shared/value_objects/macro_target.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

final goalSettingsViewProvider =
    FutureProvider.autoDispose<GoalSettingsViewData>((ref) async {
      final repository = ref.watch(goalRepositoryProvider);
      final activeGoal = await repository.getActiveGoal();
      final goals = await repository.getGoals();
      final profile = await ref.watch(currentUserProfileProvider.future);

      return GoalSettingsViewData(
        activeGoal: activeGoal,
        recentGoals: goals.take(4).toList(growable: false),
        preferredWeightUnit:
            activeGoal?.targetWeight?.originalUnit ??
            profile?.preferredWeightUnit ??
            WeightUnit.kilograms,
      );
    });

final goalSettingsControllerProvider =
    AsyncNotifierProvider.autoDispose<GoalSettingsController, void>(
      GoalSettingsController.new,
    );

class GoalSettingsController extends AutoDisposeAsyncNotifier<void> {
  static const _unitConverter = UnitConverter();
  static const _uuidService = UuidService();

  @override
  FutureOr<void> build() {}

  Future<void> saveActiveGoal({
    Goal? existingGoal,
    required GoalType type,
    required String title,
    required int calories,
    required double proteinGrams,
    required double carbsGrams,
    required double fatGrams,
    double? targetWeightValue,
    required WeightUnit targetWeightUnit,
    DateTime? targetDate,
  }) async {
    state = const AsyncLoading();
    final repository = ref.read(goalRepositoryProvider);
    final now = DateTime.now();
    final trimmedTitle = title.trim();

    final goal = Goal(
      id: existingGoal?.id ?? 'goal-${_uuidService.next()}',
      type: type,
      title: trimmedTitle.isEmpty ? null : trimmedTitle,
      targetWeight: targetWeightValue == null
          ? null
          : WeightValue(
              originalValue: targetWeightValue,
              originalUnit: targetWeightUnit,
              canonicalKilograms: _unitConverter.toKilograms(
                targetWeightValue,
                targetWeightUnit,
              ),
            ),
      macroTarget: MacroTarget(
        calories: calories,
        proteinGrams: proteinGrams,
        carbsGrams: carbsGrams,
        fatGrams: fatGrams,
      ),
      isActive: true,
      startedAt: existingGoal?.startedAt ?? now,
      endedAt: targetDate,
      createdAt: existingGoal?.createdAt ?? now,
      updatedAt: now,
    );

    await repository.saveGoal(goal);
    ref.invalidate(activeGoalProvider);
    ref.invalidate(goalSettingsViewProvider);
    state = const AsyncData(null);
  }
}

class GoalSettingsViewData {
  const GoalSettingsViewData({
    required this.activeGoal,
    required this.recentGoals,
    required this.preferredWeightUnit,
  });

  final Goal? activeGoal;
  final List<Goal> recentGoals;
  final WeightUnit preferredWeightUnit;
}

String goalTypeLabel(GoalType goalType) {
  return switch (goalType) {
    GoalType.cut => 'Cut',
    GoalType.bulk => 'Bulk',
    GoalType.recomp => 'Recomp',
    GoalType.strength => 'Strength',
    GoalType.maintain => 'Maintain',
    GoalType.custom => 'Custom',
  };
}
