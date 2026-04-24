import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/meal_entry_detail.dart';
import 'package:forge/domain/entities/saved_meal.dart';
import 'package:forge/domain/entities/saved_meal_detail.dart';
import 'package:forge/domain/entities/saved_meal_item.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/features/nutrition/presentation/controllers/nutrition_dashboard_controller.dart';
import 'package:forge/shared/enums/meal_type.dart';

final savedMealsProvider = FutureProvider.autoDispose<List<SavedMealDetail>>((
  ref,
) async {
  return ref.watch(nutritionRepositoryProvider).getSavedMealDetails();
});

final savedMealsControllerProvider = Provider<SavedMealsController>((ref) {
  return SavedMealsController(ref);
});

class SavedMealsController {
  SavedMealsController(this._ref);

  final Ref _ref;

  Future<SavedMealDetail?> saveFromEntries({
    required String name,
    String? notes,
    required List<MealEntryDetail> entries,
  }) async {
    if (entries.isEmpty) {
      return null;
    }

    final repository = _ref.read(nutritionRepositoryProvider);
    final uuid = _ref.read(nutritionUuidServiceProvider);
    final now = DateTime.now();
    final savedMealId = 'saved-meal-${uuid.next()}';

    await repository.saveSavedMeal(
      SavedMeal(
        id: savedMealId,
        name: name.trim(),
        notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
        createdAt: now,
        updatedAt: now,
      ),
    );

    await repository.replaceSavedMealItems(
      savedMealId,
      entries
          .asMap()
          .entries
          .map((entry) {
            final detail = entry.value;
            return SavedMealItem(
              id: 'saved-meal-item-${uuid.next()}',
              savedMealId: savedMealId,
              foodId: detail.food.id,
              quantity: detail.entry.quantity,
              orderIndex: entry.key,
              notes: detail.entry.notes,
              createdAt: now,
              updatedAt: now,
            );
          })
          .toList(growable: false),
    );

    _ref.invalidate(savedMealsProvider);
    return repository.getSavedMealDetail(savedMealId);
  }

  Future<void> logSavedMeal({
    required String savedMealId,
    required MealType mealType,
    DateTime? loggedAt,
  }) async {
    await _ref
        .read(nutritionRepositoryProvider)
        .logSavedMeal(
          savedMealId: savedMealId,
          mealType: mealType,
          loggedAt: loggedAt ?? DateTime.now(),
        );
    _ref.invalidate(nutritionDayOverviewProvider);
  }

  Future<SavedMealDetail?> updateSavedMeal({
    required SavedMeal existingSavedMeal,
    required String name,
    String? notes,
    required List<SavedMealItemDraft> items,
  }) async {
    final repository = _ref.read(nutritionRepositoryProvider);
    final resolver = _ref.read(foodQuantityResolverServiceProvider);
    final now = DateTime.now();

    await repository.saveSavedMeal(
      existingSavedMeal.copyWith(
        name: name.trim(),
        notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
        updatedAt: now,
      ),
    );

    await repository.replaceSavedMealItems(
      existingSavedMeal.id,
      items
          .asMap()
          .entries
          .map((entry) {
            final draft = entry.value;
            return draft.item.copyWith(
              quantity: resolver.resolve(
                originalValue: draft.quantityValue,
                originalUnit: draft.quantityUnit,
                portions: draft.foodDetail.portions,
              ),
              orderIndex: entry.key,
              notes: draft.notes?.trim().isEmpty ?? true
                  ? null
                  : draft.notes?.trim(),
              updatedAt: now,
            );
          })
          .toList(growable: false),
    );

    _ref.invalidate(savedMealsProvider);
    return repository.getSavedMealDetail(existingSavedMeal.id);
  }

  Future<void> deleteSavedMeal(String savedMealId) async {
    await _ref.read(nutritionRepositoryProvider).deleteSavedMeal(savedMealId);
    _ref.invalidate(savedMealsProvider);
  }
}

class SavedMealItemDraft {
  const SavedMealItemDraft({
    required this.item,
    required this.foodDetail,
    required this.quantityValue,
    required this.quantityUnit,
    this.notes,
  });

  final SavedMealItem item;
  final FoodDetail foodDetail;
  final double quantityValue;
  final FoodQuantityUnit quantityUnit;
  final String? notes;
}
