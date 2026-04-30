import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/entities/hydration_log.dart';
import 'package:forge/domain/entities/meal_entry.dart';
import 'package:forge/domain/entities/meal_entry_detail.dart';
import 'package:forge/domain/entities/saved_meal.dart';
import 'package:forge/domain/entities/saved_meal_detail.dart';
import 'package:forge/domain/entities/saved_meal_item.dart';
import 'package:forge/shared/enums/meal_type.dart';

abstract class NutritionRepository {
  Future<List<FoodDetail>> searchFoods(String query);
  Future<FoodDetail?> lookupFoodByBarcode(String barcode);
  Future<FoodDetail?> getFoodDetail(String foodId);
  Future<MealEntryDetail?> getMealEntryDetail(String mealEntryId);
  Future<void> saveFoodDetail(FoodDetail detail);
  Future<void> saveMealEntry(MealEntry mealEntry);
  Future<void> deleteMealEntry(String mealEntryId);
  Future<List<MealEntryDetail>> getMealEntryDetailsForDay(DateTime day);
  Future<List<MealEntryDetail>> getRecentMealEntryDetails({int limit = 6});
  Future<void> saveHydrationLog(HydrationLog hydrationLog);
  Future<void> deleteHydrationLog(String hydrationLogId);
  Future<List<HydrationLog>> getHydrationLogsForDay(DateTime day);
  Future<List<SavedMealDetail>> getSavedMealDetails();
  Future<SavedMealDetail?> getSavedMealDetail(String savedMealId);
  Future<void> saveSavedMeal(SavedMeal savedMeal);
  Future<void> deleteSavedMeal(String savedMealId);
  Future<void> replaceSavedMealItems(
    String savedMealId,
    List<SavedMealItem> items,
  );
  Future<void> logSavedMeal({
    required String savedMealId,
    required MealType mealType,
    required DateTime loggedAt,
  });
}
