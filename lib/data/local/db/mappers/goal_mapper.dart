import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/shared/value_objects/macro_target.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

extension GoalDataMapper on GoalsTableData {
  Goal toDomain() {
    return Goal(
      id: id,
      type: type,
      title: title,
      targetWeight:
          originalTargetWeightValue != null &&
              originalTargetWeightUnit != null &&
              canonicalTargetWeightKilograms != null
          ? WeightValue(
              originalValue: originalTargetWeightValue!,
              originalUnit: originalTargetWeightUnit!,
              canonicalKilograms: canonicalTargetWeightKilograms!,
            )
          : null,
      macroTarget: MacroTarget(
        calories: targetCalories,
        proteinGrams: targetProteinGrams,
        carbsGrams: targetCarbsGrams,
        fatGrams: targetFatGrams,
      ),
      isActive: isActive,
      startedAt: startedAt,
      endedAt: endedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension GoalCompanionMapper on Goal {
  GoalsTableCompanion toCompanion() {
    return GoalsTableCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      originalTargetWeightValue: Value(targetWeight?.originalValue),
      originalTargetWeightUnit: Value(targetWeight?.originalUnit),
      canonicalTargetWeightKilograms: Value(targetWeight?.canonicalKilograms),
      targetCalories: Value(macroTarget.calories),
      targetProteinGrams: Value(macroTarget.proteinGrams),
      targetCarbsGrams: Value(macroTarget.carbsGrams),
      targetFatGrams: Value(macroTarget.fatGrams),
      isActive: Value(isActive),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
