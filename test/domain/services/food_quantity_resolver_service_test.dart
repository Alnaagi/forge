import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/entities/food_portion.dart';
import 'package:forge/domain/services/food_quantity_resolver_service.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';

void main() {
  const service = FoodQuantityResolverService();
  final now = DateTime(2026, 4, 17, 12);

  test('resolves gram quantities directly', () {
    final resolved = service.resolve(
      originalValue: 150,
      originalUnit: FoodQuantityUnit.grams,
      portions: const [],
    );

    expect(resolved.canonicalGrams, 150);
    expect(resolved.canonicalMilliliters, isNull);
  });

  test('resolves serving quantities from local portion definitions', () {
    final resolved = service.resolve(
      originalValue: 2,
      originalUnit: FoodQuantityUnit.serving,
      portions: [
        FoodPortion(
          id: 'portion-1',
          foodId: 'food-1',
          unit: FoodQuantityUnit.serving,
          label: 'Serving',
          referenceAmount: 1,
          canonicalGrams: 32,
          canonicalMilliliters: null,
          sortOrder: 0,
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );

    expect(resolved.canonicalGrams, 64);
    expect(resolved.canonicalMilliliters, isNull);
  });

  test('resolves milliliters while preserving ml and gram equivalents', () {
    final resolved = service.resolve(
      originalValue: 250,
      originalUnit: FoodQuantityUnit.milliliters,
      portions: [
        FoodPortion(
          id: 'portion-ml',
          foodId: 'food-liquid',
          unit: FoodQuantityUnit.milliliters,
          label: '1 ml',
          referenceAmount: 1,
          canonicalGrams: 1.03,
          canonicalMilliliters: 1,
          sortOrder: 0,
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );

    expect(resolved.canonicalMilliliters, 250);
    expect(resolved.canonicalGrams, closeTo(257.5, 0.001));
  });
}
