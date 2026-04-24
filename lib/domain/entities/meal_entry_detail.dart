import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/domain/entities/meal_entry.dart';
import 'package:forge/shared/value_objects/nutrition_macros.dart';

part 'meal_entry_detail.freezed.dart';

@freezed
class MealEntryDetail with _$MealEntryDetail {
  const factory MealEntryDetail({
    required MealEntry entry,
    required Food food,
    required NutritionMacros macros,
  }) = _MealEntryDetail;
}
