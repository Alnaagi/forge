import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_search_result_dto.freezed.dart';

@freezed
class FoodSearchResultDto with _$FoodSearchResultDto {
  const factory FoodSearchResultDto({
    required String name,
    String? brandName,
    String? barcode,
    required int caloriesPer100g,
    @Default(0) double proteinPer100g,
    @Default(0) double carbsPer100g,
    @Default(0) double fatPer100g,
  }) = _FoodSearchResultDto;
}
