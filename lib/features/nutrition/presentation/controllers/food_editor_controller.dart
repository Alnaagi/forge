import 'package:forge/app/core/services/uuid_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/entities/food_portion.dart';
import 'package:forge/features/nutrition/presentation/controllers/barcode_lookup_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/food_search_controller.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/enums/sync_source.dart';

final foodEditorControllerProvider = Provider<FoodEditorController>((ref) {
  return FoodEditorController(ref);
});

class FoodEditorController {
  FoodEditorController(this._ref);

  final Ref _ref;

  Future<FoodDetail> save({
    String? foodId,
    String? barcode,
    required String name,
    String? brandName,
    required int caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    double? gramsPerServing,
    double? gramsPerSlice,
    double? gramsPerUnit,
    double? gramsPerMilliliter,
  }) async {
    final repository = _ref.read(nutritionRepositoryProvider);
    final uuid = _ref.read(nutritionUuidServiceProvider);
    final existing = foodId == null
        ? null
        : await repository.getFoodDetail(foodId);
    final now = DateTime.now();
    final resolvedName = name.trim();
    final resolvedBrandName = brandName?.trim().isEmpty ?? true
        ? null
        : brandName?.trim();
    final resolvedBarcode = barcode?.trim().isEmpty ?? true
        ? null
        : barcode?.trim();

    final food = Food(
      id: existing?.food.id ?? 'food-${uuid.next()}',
      name: resolvedName,
      brandName: resolvedBrandName,
      barcode: resolvedBarcode,
      caloriesPer100g: caloriesPer100g,
      proteinPer100g: proteinPer100g,
      carbsPer100g: carbsPer100g,
      fatPer100g: fatPer100g,
      source: SyncSource.local,
      isUserEdited: true,
      createdAt: existing?.food.createdAt ?? now,
      updatedAt: now,
    );

    final portions = <FoodPortion>[
      if (gramsPerServing != null && gramsPerServing > 0)
        _buildPortion(
          uuid: uuid,
          foodId: food.id,
          unit: FoodQuantityUnit.serving,
          label: 'Serving',
          canonicalGrams: gramsPerServing,
          canonicalMilliliters: null,
          sortOrder: 0,
          createdAt: now,
          updatedAt: now,
        ),
      if (gramsPerSlice != null && gramsPerSlice > 0)
        _buildPortion(
          uuid: uuid,
          foodId: food.id,
          unit: FoodQuantityUnit.slice,
          label: 'Slice',
          canonicalGrams: gramsPerSlice,
          canonicalMilliliters: null,
          sortOrder: 1,
          createdAt: now,
          updatedAt: now,
        ),
      if (gramsPerUnit != null && gramsPerUnit > 0)
        _buildPortion(
          uuid: uuid,
          foodId: food.id,
          unit: FoodQuantityUnit.unit,
          label: 'Unit',
          canonicalGrams: gramsPerUnit,
          canonicalMilliliters: null,
          sortOrder: 2,
          createdAt: now,
          updatedAt: now,
        ),
      if (gramsPerMilliliter != null && gramsPerMilliliter > 0)
        _buildPortion(
          uuid: uuid,
          foodId: food.id,
          unit: FoodQuantityUnit.milliliters,
          label: '1 ml',
          canonicalGrams: gramsPerMilliliter,
          canonicalMilliliters: 1,
          sortOrder: 3,
          createdAt: now,
          updatedAt: now,
        ),
    ];

    final detail = FoodDetail(food: food, portions: portions);
    await repository.saveFoodDetail(detail);

    _ref.invalidate(foodSearchResultsProvider);
    _ref.invalidate(barcodeLookupResultProvider);

    if (resolvedBarcode != null) {
      final savedByBarcode = await repository.lookupFoodByBarcode(
        resolvedBarcode,
      );
      if (savedByBarcode != null) {
        return savedByBarcode;
      }
    }

    return (await repository.getFoodDetail(food.id)) ?? detail;
  }

  FoodPortion _buildPortion({
    required UuidService uuid,
    required String foodId,
    required FoodQuantityUnit unit,
    required String label,
    required double? canonicalGrams,
    required double? canonicalMilliliters,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) {
    return FoodPortion(
      id: 'food-portion-${uuid.next()}',
      foodId: foodId,
      unit: unit,
      label: label,
      referenceAmount: 1,
      canonicalGrams: canonicalGrams,
      canonicalMilliliters: canonicalMilliliters,
      sortOrder: sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
