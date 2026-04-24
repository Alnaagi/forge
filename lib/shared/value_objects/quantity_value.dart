import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';

part 'quantity_value.freezed.dart';

@freezed
class QuantityValue with _$QuantityValue {
  @Assert('originalValue >= 0', 'Quantity cannot be negative.')
  @Assert(
    'canonicalGrams == null || canonicalGrams >= 0',
    'Canonical grams cannot be negative.',
  )
  @Assert(
    'canonicalMilliliters == null || canonicalMilliliters >= 0',
    'Canonical milliliters cannot be negative.',
  )
  const factory QuantityValue({
    required double originalValue,
    required FoodQuantityUnit originalUnit,
    double? canonicalGrams,
    double? canonicalMilliliters,
  }) = _QuantityValue;
}
