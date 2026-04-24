import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/domain/entities/saved_meal.dart';
import 'package:forge/domain/entities/saved_meal_item.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';

part 'saved_meal_detail.freezed.dart';

@freezed
class SavedMealFoodItem with _$SavedMealFoodItem {
  const factory SavedMealFoodItem({
    required SavedMealItem item,
    required Food food,
    required NutritionMacros macros,
  }) = _SavedMealFoodItem;
}

@freezed
class SavedMealDetail with _$SavedMealDetail {
  const factory SavedMealDetail({
    required SavedMeal savedMeal,
    required List<SavedMealFoodItem> items,
    required NutritionMacros macros,
  }) = _SavedMealDetail;
}
