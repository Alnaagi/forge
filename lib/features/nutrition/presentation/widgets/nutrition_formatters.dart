import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/entities/meal_entry_detail.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';
import 'package:forge/shared/value_objects/quantity_value.dart';

class NutritionFormatters {
  const NutritionFormatters._();

  static String macros(NutritionMacros macros) {
    return '${macros.calories} kcal | P ${_trim(macros.protein)} | C ${_trim(macros.carbs)} | F ${_trim(macros.fat)}';
  }

  static String quantity(QuantityValue quantity) {
    return '${_trim(quantity.originalValue)} ${quantity.originalUnit.symbol}';
  }

  static String hydrationMilliliters(double milliliters) {
    return '${_trim(milliliters)} ml';
  }

  static String foodSubtitle(FoodDetail detail) {
    final brand = detail.food.brandName;
    if (brand == null || brand.isEmpty) {
      return macros(
        NutritionMacros(
          calories: detail.food.caloriesPer100g,
          protein: detail.food.proteinPer100g,
          carbs: detail.food.carbsPer100g,
          fat: detail.food.fatPer100g,
        ),
      );
    }
    return '$brand - ${detail.food.caloriesPer100g} kcal / 100 g';
  }

  static String mealEntrySubtitle(MealEntryDetail detail) {
    return '${quantity(detail.entry.quantity)} - ${macros(detail.macros)}';
  }

  static String _trim(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }
}
