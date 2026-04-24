import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/domain/entities/food_portion.dart';
import 'package:forge/domain/entities/hydration_log.dart';
import 'package:forge/domain/entities/meal_entry.dart';
import 'package:forge/domain/entities/saved_meal.dart';
import 'package:forge/domain/entities/saved_meal_item.dart';
import 'package:forge/shared/value_objects/quantity_value.dart';
import 'package:forge/shared/value_objects/volume_value.dart';

extension FoodDataMapper on FoodsTableData {
  Food toDomain() {
    return Food(
      id: id,
      name: name,
      brandName: brandName,
      barcode: barcode,
      caloriesPer100g: caloriesPer100g,
      proteinPer100g: proteinPer100g,
      carbsPer100g: carbsPer100g,
      fatPer100g: fatPer100g,
      source: source,
      isUserEdited: isUserEdited,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension FoodCompanionMapper on Food {
  FoodsTableCompanion toCompanion() {
    return FoodsTableCompanion(
      id: Value(id),
      name: Value(name),
      brandName: Value(brandName),
      barcode: Value(barcode),
      caloriesPer100g: Value(caloriesPer100g),
      proteinPer100g: Value(proteinPer100g),
      carbsPer100g: Value(carbsPer100g),
      fatPer100g: Value(fatPer100g),
      source: Value(source),
      isUserEdited: Value(isUserEdited),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension FoodPortionDataMapper on FoodPortionsTableData {
  FoodPortion toDomain() {
    return FoodPortion(
      id: id,
      foodId: foodId,
      unit: unit,
      label: label,
      referenceAmount: referenceAmount,
      canonicalGrams: canonicalGrams,
      canonicalMilliliters: canonicalMilliliters,
      sortOrder: sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension FoodPortionCompanionMapper on FoodPortion {
  FoodPortionsTableCompanion toCompanion() {
    return FoodPortionsTableCompanion(
      id: Value(id),
      foodId: Value(foodId),
      unit: Value(unit),
      label: Value(label),
      referenceAmount: Value(referenceAmount),
      canonicalGrams: Value(canonicalGrams),
      canonicalMilliliters: Value(canonicalMilliliters),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension MealEntryDataMapper on MealEntriesTableData {
  MealEntry toDomain() {
    return MealEntry(
      id: id,
      foodId: foodId,
      mealType: mealType,
      quantity: QuantityValue(
        originalValue: originalQuantityValue,
        originalUnit: originalQuantityUnit,
        canonicalGrams: canonicalQuantityGrams,
        canonicalMilliliters: canonicalQuantityMilliliters,
      ),
      loggedAt: loggedAt,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension MealEntryCompanionMapper on MealEntry {
  MealEntriesTableCompanion toCompanion() {
    return MealEntriesTableCompanion(
      id: Value(id),
      foodId: Value(foodId),
      mealType: Value(mealType),
      originalQuantityValue: Value(quantity.originalValue),
      originalQuantityUnit: Value(quantity.originalUnit),
      canonicalQuantityGrams: Value(quantity.canonicalGrams),
      canonicalQuantityMilliliters: Value(quantity.canonicalMilliliters),
      loggedAt: Value(loggedAt),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension SavedMealDataMapper on SavedMealsTableData {
  SavedMeal toDomain() {
    return SavedMeal(
      id: id,
      name: name,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension SavedMealCompanionMapper on SavedMeal {
  SavedMealsTableCompanion toCompanion() {
    return SavedMealsTableCompanion(
      id: Value(id),
      name: Value(name),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension SavedMealItemDataMapper on SavedMealItemsTableData {
  SavedMealItem toDomain() {
    return SavedMealItem(
      id: id,
      savedMealId: savedMealId,
      foodId: foodId,
      quantity: QuantityValue(
        originalValue: originalQuantityValue,
        originalUnit: originalQuantityUnit,
        canonicalGrams: canonicalQuantityGrams,
        canonicalMilliliters: canonicalQuantityMilliliters,
      ),
      orderIndex: orderIndex,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension SavedMealItemCompanionMapper on SavedMealItem {
  SavedMealItemsTableCompanion toCompanion() {
    return SavedMealItemsTableCompanion(
      id: Value(id),
      savedMealId: Value(savedMealId),
      foodId: Value(foodId),
      originalQuantityValue: Value(quantity.originalValue),
      originalQuantityUnit: Value(quantity.originalUnit),
      canonicalQuantityGrams: Value(quantity.canonicalGrams),
      canonicalQuantityMilliliters: Value(quantity.canonicalMilliliters),
      orderIndex: Value(orderIndex),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension HydrationLogDataMapper on HydrationLogsTableData {
  HydrationLog toDomain() {
    return HydrationLog(
      id: id,
      amount: VolumeValue(
        originalValue: originalAmountValue,
        originalUnit: originalAmountUnit,
        canonicalMilliliters: canonicalMilliliters,
      ),
      loggedAt: loggedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension HydrationLogCompanionMapper on HydrationLog {
  HydrationLogsTableCompanion toCompanion() {
    return HydrationLogsTableCompanion(
      id: Value(id),
      originalAmountValue: Value(amount.originalValue),
      originalAmountUnit: Value(amount.originalUnit),
      canonicalMilliliters: Value(amount.canonicalMilliliters),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
