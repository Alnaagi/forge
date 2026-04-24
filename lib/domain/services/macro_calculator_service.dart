import 'package:forge/domain/entities/food.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';
import 'package:forge/shared/value_objects/quantity_value.dart';

class MacroCalculatorService {
  const MacroCalculatorService();

  NutritionMacros calculateForQuantity({
    required Food food,
    required QuantityValue quantity,
  }) {
    final grams = quantity.canonicalGrams;
    if (grams == null || grams <= 0) {
      return NutritionMacros.zero;
    }

    final factor = grams / 100;
    return NutritionMacros(
      calories: (food.caloriesPer100g * factor).round(),
      protein: food.proteinPer100g * factor,
      carbs: food.carbsPer100g * factor,
      fat: food.fatPer100g * factor,
    );
  }

  NutritionMacros combine(Iterable<NutritionMacros> macros) {
    var total = NutritionMacros.zero;
    for (final item in macros) {
      total = total.add(item);
    }
    return total;
  }
}
