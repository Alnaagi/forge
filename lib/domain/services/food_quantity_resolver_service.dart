import 'package:forge/domain/entities/food_portion.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/value_objects/quantity_value.dart';

class FoodQuantityResolverService {
  const FoodQuantityResolverService();

  QuantityValue resolve({
    required double originalValue,
    required FoodQuantityUnit originalUnit,
    required List<FoodPortion> portions,
  }) {
    switch (originalUnit) {
      case FoodQuantityUnit.grams:
        return QuantityValue(
          originalValue: originalValue,
          originalUnit: originalUnit,
          canonicalGrams: originalValue,
        );
      case FoodQuantityUnit.milliliters:
        final portion = _findPortion(portions, FoodQuantityUnit.milliliters);
        final multiplier = portion == null
            ? null
            : originalValue / portion.referenceAmount;
        final gramsPerMilliliter = portion?.canonicalGrams;
        return QuantityValue(
          originalValue: originalValue,
          originalUnit: originalUnit,
          canonicalGrams: multiplier == null || gramsPerMilliliter == null
              ? null
              : gramsPerMilliliter * multiplier,
          canonicalMilliliters: originalValue,
        );
      case FoodQuantityUnit.serving:
      case FoodQuantityUnit.slice:
      case FoodQuantityUnit.unit:
        final portion = _findRequiredPortion(portions, originalUnit);
        final multiplier = originalValue / portion.referenceAmount;
        return QuantityValue(
          originalValue: originalValue,
          originalUnit: originalUnit,
          canonicalGrams: portion.canonicalGrams == null
              ? null
              : portion.canonicalGrams! * multiplier,
          canonicalMilliliters: portion.canonicalMilliliters == null
              ? null
              : portion.canonicalMilliliters! * multiplier,
        );
    }
  }

  FoodPortion? _findPortion(List<FoodPortion> portions, FoodQuantityUnit unit) {
    for (final portion in portions) {
      if (portion.unit == unit) {
        return portion;
      }
    }
    return null;
  }

  FoodPortion _findRequiredPortion(
    List<FoodPortion> portions,
    FoodQuantityUnit unit,
  ) {
    final portion = _findPortion(portions, unit);
    if (portion == null) {
      throw StateError('Food does not define a $unit portion.');
    }
    return portion;
  }
}
