import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_macros.freezed.dart';

@freezed
class NutritionMacros with _$NutritionMacros {
  const factory NutritionMacros({
    required int calories,
    required double protein,
    required double carbs,
    required double fat,
  }) = _NutritionMacros;

  const NutritionMacros._();

  static const zero = NutritionMacros(
    calories: 0,
    protein: 0,
    carbs: 0,
    fat: 0,
  );

  NutritionMacros add(NutritionMacros other) {
    return NutritionMacros(
      calories: calories + other.calories,
      protein: protein + other.protein,
      carbs: carbs + other.carbs,
      fat: fat + other.fat,
    );
  }
}
