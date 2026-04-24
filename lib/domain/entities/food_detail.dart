import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/domain/entities/food_portion.dart';

part 'food_detail.freezed.dart';

@freezed
class FoodDetail with _$FoodDetail {
  const factory FoodDetail({
    required Food food,
    required List<FoodPortion> portions,
  }) = _FoodDetail;
}
