import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/entities/meal_entry.dart';
import 'package:forge/features/nutrition/presentation/controllers/nutrition_dashboard_controller.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/enums/meal_type.dart';

final mealLogControllerProvider = Provider<MealLogController>((ref) {
  return MealLogController(ref);
});

class MealLogController {
  MealLogController(this._ref);

  final Ref _ref;

  Future<MealEntry> logFood({
    required FoodDetail foodDetail,
    required MealType mealType,
    required double quantityValue,
    required FoodQuantityUnit quantityUnit,
    String? notes,
    DateTime? loggedAt,
  }) async {
    final repository = _ref.read(nutritionRepositoryProvider);
    final resolver = _ref.read(foodQuantityResolverServiceProvider);
    final uuid = _ref.read(nutritionUuidServiceProvider);
    final now = DateTime.now();
    final resolvedQuantity = resolver.resolve(
      originalValue: quantityValue,
      originalUnit: quantityUnit,
      portions: foodDetail.portions,
    );

    final entry = MealEntry(
      id: 'meal-entry-${uuid.next()}',
      foodId: foodDetail.food.id,
      mealType: mealType,
      quantity: resolvedQuantity,
      loggedAt: loggedAt ?? now,
      notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
      createdAt: now,
      updatedAt: now,
    );
    await repository.saveMealEntry(entry);
    _ref.invalidate(nutritionDayOverviewProvider);
    return entry;
  }

  Future<MealEntry> updateMealEntry({
    required MealEntry existingEntry,
    required FoodDetail foodDetail,
    required MealType mealType,
    required double quantityValue,
    required FoodQuantityUnit quantityUnit,
    String? notes,
    DateTime? loggedAt,
  }) async {
    final repository = _ref.read(nutritionRepositoryProvider);
    final resolver = _ref.read(foodQuantityResolverServiceProvider);
    final resolvedQuantity = resolver.resolve(
      originalValue: quantityValue,
      originalUnit: quantityUnit,
      portions: foodDetail.portions,
    );

    final entry = existingEntry.copyWith(
      foodId: foodDetail.food.id,
      mealType: mealType,
      quantity: resolvedQuantity,
      loggedAt: loggedAt ?? existingEntry.loggedAt,
      notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
      updatedAt: DateTime.now(),
    );
    await repository.saveMealEntry(entry);
    _ref.invalidate(nutritionDayOverviewProvider);
    return entry;
  }

  Future<void> deleteMealEntry(String mealEntryId) async {
    await _ref.read(nutritionRepositoryProvider).deleteMealEntry(mealEntryId);
    _ref.invalidate(nutritionDayOverviewProvider);
  }
}
