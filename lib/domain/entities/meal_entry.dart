import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/meal_type.dart';
import 'package:forge/shared/value_objects/quantity_value.dart';

part 'meal_entry.freezed.dart';

@freezed
class MealEntry with _$MealEntry {
  const factory MealEntry({
    required String id,
    required String foodId,
    required MealType mealType,
    required QuantityValue quantity,
    required DateTime loggedAt,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MealEntry;
}
