import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';

part 'food_portion.freezed.dart';

@freezed
class FoodPortion with _$FoodPortion {
  const factory FoodPortion({
    required String id,
    required String foodId,
    required FoodQuantityUnit unit,
    required String label,
    required double referenceAmount,
    double? canonicalGrams,
    double? canonicalMilliliters,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FoodPortion;
}
