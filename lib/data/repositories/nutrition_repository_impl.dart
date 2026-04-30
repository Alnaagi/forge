import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/data/local/db/daos/nutrition_dao.dart';
import 'package:forge/data/local/db/mappers/nutrition_mapper.dart';
import 'package:forge/data/remote/clients/barcode_api_client.dart';
import 'package:forge/data/remote/clients/nutrition_api_client.dart';
import 'package:forge/data/remote/mappers/food_dto_mapper.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/entities/food_portion.dart';
import 'package:forge/domain/entities/hydration_log.dart';
import 'package:forge/domain/entities/meal_entry.dart';
import 'package:forge/domain/entities/meal_entry_detail.dart';
import 'package:forge/domain/entities/saved_meal.dart';
import 'package:forge/domain/entities/saved_meal_detail.dart';
import 'package:forge/domain/entities/saved_meal_item.dart';
import 'package:forge/domain/repositories/nutrition_repository.dart';
import 'package:forge/domain/services/macro_calculator_service.dart';
import 'package:forge/shared/enums/meal_type.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  const NutritionRepositoryImpl({
    required NutritionDao dao,
    required NutritionApiClient nutritionApiClient,
    required BarcodeApiClient barcodeApiClient,
    required FoodDtoMapper foodDtoMapper,
    required MacroCalculatorService macroCalculatorService,
    required UuidService uuidService,
  }) : _dao = dao,
       _nutritionApiClient = nutritionApiClient,
       _barcodeApiClient = barcodeApiClient,
       _foodDtoMapper = foodDtoMapper,
       _macroCalculatorService = macroCalculatorService,
       _uuidService = uuidService;

  final NutritionDao _dao;
  final NutritionApiClient _nutritionApiClient;
  final BarcodeApiClient _barcodeApiClient;
  final FoodDtoMapper _foodDtoMapper;
  final MacroCalculatorService _macroCalculatorService;
  final UuidService _uuidService;

  @override
  Future<List<FoodDetail>> searchFoods(String query) async {
    final normalized = query.trim();
    final localDetails = _mapFoodDetails(
      await _dao.searchFoodDetails(normalized),
    );
    if (normalized.isEmpty) {
      return localDetails;
    }

    final existingBarcodes = {
      for (final detail in localDetails)
        if (detail.food.barcode != null) detail.food.barcode!,
    };
    final existingNameKeys = {
      for (final detail in localDetails)
        _nameBrandKey(detail.food.name, detail.food.brandName),
    };

    final remoteResults = await _nutritionApiClient.searchFoods(normalized);
    final merged = <FoodDetail>[...localDetails];

    for (final dto in remoteResults) {
      if (dto.barcode != null && existingBarcodes.contains(dto.barcode!)) {
        continue;
      }

      final nameKey = _nameBrandKey(dto.name, dto.brandName);
      if (existingNameKeys.contains(nameKey)) {
        continue;
      }

      final matchedLocalFood = dto.barcode != null
          ? await _dao.getFoodByBarcode(dto.barcode!)
          : await _dao.getFoodByNameAndBrand(dto.name, dto.brandName);
      if (matchedLocalFood != null) {
        final detail = await getFoodDetail(matchedLocalFood.id);
        if (detail != null) {
          merged.add(detail);
          existingNameKeys.add(nameKey);
          if (matchedLocalFood.barcode != null) {
            existingBarcodes.add(matchedLocalFood.barcode!);
          }
        }
        continue;
      }

      final detail = FoodDetail(
        food: _foodDtoMapper.fromSearchDto(
          dto,
          id: 'food-${_uuidService.next()}',
        ),
        portions: const [],
      );
      await saveFoodDetail(detail);
      merged.add(detail);
      existingNameKeys.add(nameKey);
      if (detail.food.barcode != null) {
        existingBarcodes.add(detail.food.barcode!);
      }
    }

    return merged;
  }

  @override
  Future<FoodDetail?> lookupFoodByBarcode(String barcode) async {
    final normalized = barcode.trim();
    final localFood = await _dao.getFoodByBarcode(normalized);
    if (localFood != null) {
      return getFoodDetail(localFood.id);
    }

    final remoteResult = await _barcodeApiClient.lookupBarcode(normalized);
    if (remoteResult == null) {
      return null;
    }

    final detail = FoodDetail(
      food: _foodDtoMapper.fromBarcodeDto(
        remoteResult,
        id: 'food-${_uuidService.next()}',
      ),
      portions: const [],
    );
    await saveFoodDetail(detail);
    return getFoodDetail(detail.food.id);
  }

  @override
  Future<FoodDetail?> getFoodDetail(String foodId) async {
    final rows = await _dao.getFoodDetailRows(foodId: foodId);
    if (rows.isEmpty) {
      return null;
    }
    return _mapFoodDetails(rows).single;
  }

  @override
  Future<MealEntryDetail?> getMealEntryDetail(String mealEntryId) async {
    final row = await _dao.getMealEntryDetailById(mealEntryId);
    if (row == null) {
      return null;
    }

    final entry = row.entry.toDomain();
    final food = row.food.toDomain();
    return MealEntryDetail(
      entry: entry,
      food: food,
      macros: _macroCalculatorService.calculateForQuantity(
        food: food,
        quantity: entry.quantity,
      ),
    );
  }

  @override
  Future<void> saveFoodDetail(FoodDetail detail) async {
    var food = detail.food;
    if (food.barcode != null) {
      final existingByBarcode = await _dao.getFoodByBarcode(food.barcode!);
      if (existingByBarcode != null && existingByBarcode.id != food.id) {
        food = food.copyWith(
          id: existingByBarcode.id,
          createdAt: existingByBarcode.createdAt,
        );
      }
    }

    await _dao.upsertFood(food.toCompanion());
    await _dao.replaceFoodPortions(
      food.id,
      detail.portions
          .asMap()
          .entries
          .map(
            (entry) => entry.value
                .copyWith(
                  foodId: food.id,
                  sortOrder: entry.key,
                  createdAt: entry.value.createdAt,
                  updatedAt: food.updatedAt,
                )
                .toCompanion(),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> saveMealEntry(MealEntry mealEntry) {
    return _dao.upsertMealEntry(mealEntry.toCompanion());
  }

  @override
  Future<void> deleteMealEntry(String mealEntryId) {
    return _dao.deleteMealEntry(mealEntryId);
  }

  @override
  Future<List<MealEntryDetail>> getMealEntryDetailsForDay(DateTime day) async {
    final rows = await _dao.getMealEntryDetailsForDay(day);
    return rows
        .map(
          (row) => MealEntryDetail(
            entry: row.entry.toDomain(),
            food: row.food.toDomain(),
            macros: _macroCalculatorService.calculateForQuantity(
              food: row.food.toDomain(),
              quantity: row.entry.toDomain().quantity,
            ),
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<MealEntryDetail>> getRecentMealEntryDetails({
    int limit = 6,
  }) async {
    final rows = await _dao.getRecentMealEntryDetails(limit: limit);
    return rows
        .map(
          (row) => MealEntryDetail(
            entry: row.entry.toDomain(),
            food: row.food.toDomain(),
            macros: _macroCalculatorService.calculateForQuantity(
              food: row.food.toDomain(),
              quantity: row.entry.toDomain().quantity,
            ),
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveHydrationLog(HydrationLog hydrationLog) {
    return _dao.upsertHydrationLog(hydrationLog.toCompanion());
  }

  @override
  Future<void> deleteHydrationLog(String hydrationLogId) {
    return _dao.deleteHydrationLog(hydrationLogId);
  }

  @override
  Future<List<HydrationLog>> getHydrationLogsForDay(DateTime day) async {
    final rows = await _dao.getHydrationLogsForDay(day);
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<List<SavedMealDetail>> getSavedMealDetails() async {
    final rows = await _dao.getSavedMealDetailRows();
    return _mapSavedMealDetails(rows);
  }

  @override
  Future<SavedMealDetail?> getSavedMealDetail(String savedMealId) async {
    final rows = await _dao.getSavedMealDetailRows(savedMealId: savedMealId);
    if (rows.isEmpty) {
      return null;
    }
    return _mapSavedMealDetails(rows).single;
  }

  @override
  Future<void> saveSavedMeal(SavedMeal savedMeal) {
    return _dao.upsertSavedMeal(savedMeal.toCompanion());
  }

  @override
  Future<void> deleteSavedMeal(String savedMealId) {
    return _dao.deleteSavedMeal(savedMealId);
  }

  @override
  Future<void> replaceSavedMealItems(
    String savedMealId,
    List<SavedMealItem> items,
  ) {
    return _dao.replaceSavedMealItems(
      savedMealId,
      items
          .asMap()
          .entries
          .map(
            (entry) => entry.value
                .copyWith(savedMealId: savedMealId, orderIndex: entry.key)
                .toCompanion(),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> logSavedMeal({
    required String savedMealId,
    required MealType mealType,
    required DateTime loggedAt,
  }) async {
    final detail = await getSavedMealDetail(savedMealId);
    if (detail == null) {
      throw StateError('Saved meal $savedMealId was not found.');
    }

    final now = DateTime.now();
    for (final item in detail.items) {
      await saveMealEntry(
        MealEntry(
          id: 'meal-entry-${_uuidService.next()}',
          foodId: item.food.id,
          mealType: mealType,
          quantity: item.item.quantity,
          loggedAt: loggedAt,
          notes: item.item.notes,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
  }

  List<FoodDetail> _mapFoodDetails(List<FoodDetailRow> rows) {
    final accumulators = <String, _FoodDetailAccumulator>{};

    for (final row in rows) {
      final accumulator = accumulators.putIfAbsent(
        row.food.id,
        () => _FoodDetailAccumulator(food: row.food.toDomain()),
      );

      final portion = row.portion;
      if (portion != null) {
        accumulator.portions.add(portion.toDomain());
      }
    }

    return accumulators.values
        .map(
          (accumulator) => FoodDetail(
            food: accumulator.food,
            portions: List.unmodifiable(accumulator.portions),
          ),
        )
        .toList(growable: false);
  }

  List<SavedMealDetail> _mapSavedMealDetails(List<SavedMealDetailRow> rows) {
    final accumulators = <String, _SavedMealDetailAccumulator>{};

    for (final row in rows) {
      final accumulator = accumulators.putIfAbsent(
        row.savedMeal.id,
        () => _SavedMealDetailAccumulator(savedMeal: row.savedMeal.toDomain()),
      );

      final item = row.item;
      final food = row.food;
      if (item != null && food != null) {
        final domainItem = item.toDomain();
        accumulator.items.add(
          SavedMealFoodItem(
            item: domainItem,
            food: food.toDomain(),
            macros: _macroCalculatorService.calculateForQuantity(
              food: food.toDomain(),
              quantity: domainItem.quantity,
            ),
          ),
        );
      }
    }

    return accumulators.values
        .map(
          (accumulator) => SavedMealDetail(
            savedMeal: accumulator.savedMeal,
            items: List.unmodifiable(accumulator.items),
            macros: _macroCalculatorService.combine(
              accumulator.items.map((item) => item.macros),
            ),
          ),
        )
        .toList(growable: false);
  }

  String _nameBrandKey(String name, String? brandName) {
    final normalizedBrand = brandName?.trim().toLowerCase() ?? '';
    return '${name.trim().toLowerCase()}|$normalizedBrand';
  }
}

class _FoodDetailAccumulator {
  _FoodDetailAccumulator({required this.food});

  final Food food;
  final List<FoodPortion> portions = <FoodPortion>[];
}

class _SavedMealDetailAccumulator {
  _SavedMealDetailAccumulator({required this.savedMeal});

  final SavedMeal savedMeal;
  final List<SavedMealFoodItem> items = <SavedMealFoodItem>[];
}
