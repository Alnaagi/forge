import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/value_objects/quantity_value.dart';

part 'saved_meal_item.freezed.dart';

@freezed
class SavedMealItem with _$SavedMealItem {
  const factory SavedMealItem({
    required String id,
    required String savedMealId,
    required String foodId,
    required QuantityValue quantity,
    required int orderIndex,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SavedMealItem;
}
