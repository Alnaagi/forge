import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/domain/services/macro_calculator_service.dart';
import 'package:forge/shared/enums/sync_source.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/value_objects/quantity_value.dart';

void main() {
  const service = MacroCalculatorService();
  final now = DateTime(2026, 4, 17, 12);

  test('calculates macros from canonical grams', () {
    final food = Food(
      id: 'oats',
      name: 'Oats',
      brandName: null,
      barcode: null,
      caloriesPer100g: 389,
      proteinPer100g: 16.9,
      carbsPer100g: 66.3,
      fatPer100g: 6.9,
      source: SyncSource.local,
      isUserEdited: false,
      createdAt: now,
      updatedAt: now,
    );

    final macros = service.calculateForQuantity(
      food: food,
      quantity: const QuantityValue(
        originalValue: 1.5,
        originalUnit: FoodQuantityUnit.serving,
        canonicalGrams: 60,
        canonicalMilliliters: null,
      ),
    );

    expect(macros.calories, 233);
    expect(macros.protein, closeTo(10.14, 0.001));
    expect(macros.carbs, closeTo(39.78, 0.001));
    expect(macros.fat, closeTo(4.14, 0.001));
  });
}
