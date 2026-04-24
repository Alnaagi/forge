import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/daos/nutrition_dao.dart';
import 'package:forge/data/remote/clients/barcode_api_client.dart';
import 'package:forge/data/remote/clients/nutrition_api_client.dart';
import 'package:forge/data/remote/dto/barcode_lookup_result_dto.dart';
import 'package:forge/data/remote/dto/food_search_result_dto.dart';
import 'package:forge/data/remote/mappers/food_dto_mapper.dart';
import 'package:forge/data/repositories/nutrition_repository_impl.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/services/macro_calculator_service.dart';
import 'package:forge/shared/enums/sync_source.dart';

void main() {
  late AppDatabase database;
  late NutritionRepositoryImpl repository;
  late _FakeNutritionApiClient nutritionApiClient;
  late _FakeBarcodeApiClient barcodeApiClient;

  setUp(() {
    database = AppDatabase.test(NativeDatabase.memory());
    nutritionApiClient = _FakeNutritionApiClient();
    barcodeApiClient = _FakeBarcodeApiClient();
    repository = NutritionRepositoryImpl(
      dao: NutritionDao(database),
      nutritionApiClient: nutritionApiClient,
      barcodeApiClient: barcodeApiClient,
      foodDtoMapper: const FoodDtoMapper(),
      macroCalculatorService: const MacroCalculatorService(),
      uuidService: const UuidService(),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('lookupFoodByBarcode caches assistive remote foods locally', () async {
    barcodeApiClient.result = const BarcodeLookupResultDto(
      barcode: '0123456789012',
      name: 'Remote Yogurt',
      brandName: 'Forge Foods',
      caloriesPer100g: 120,
      proteinPer100g: 12,
      carbsPer100g: 9,
      fatPer100g: 3,
    );

    final firstLookup = await repository.lookupFoodByBarcode('0123456789012');
    expect(firstLookup, isNotNull);
    expect(firstLookup!.food.name, 'Remote Yogurt');
    expect(firstLookup.food.source, SyncSource.barcodeLookup);

    barcodeApiClient.result = null;

    final secondLookup = await repository.lookupFoodByBarcode('0123456789012');
    expect(secondLookup, isNotNull);
    expect(secondLookup!.food.id, firstLookup.food.id);
    expect(secondLookup.food.name, 'Remote Yogurt');
  });

  test(
    'searchFoods persists remote assistive matches into the local cache',
    () async {
      nutritionApiClient.results = const [
        FoodSearchResultDto(
          name: 'Instant Oats',
          brandName: 'Forge Pantry',
          barcode: '9988776655443',
          caloriesPer100g: 380,
          proteinPer100g: 13,
          carbsPer100g: 67,
          fatPer100g: 7,
        ),
      ];

      final firstSearch = await repository.searchFoods('oats');
      expect(firstSearch, hasLength(1));
      expect(firstSearch.single.food.name, 'Instant Oats');

      nutritionApiClient.results = const [];

      final secondSearch = await repository.searchFoods('oats');
      expect(
        secondSearch.map((detail) => detail.food.name),
        contains('Instant Oats'),
      );
    },
  );

  test(
    'local manually corrected foods win barcode lookups over remote data',
    () async {
      final now = DateTime(2026, 4, 17, 9);
      await repository.saveFoodDetail(
        FoodDetail(
          food: Food(
            id: 'food-local',
            name: 'Trusted Peanut Butter',
            brandName: 'Home Jar',
            barcode: '1111222233334',
            caloriesPer100g: 610,
            proteinPer100g: 26,
            carbsPer100g: 18,
            fatPer100g: 49,
            source: SyncSource.local,
            isUserEdited: true,
            createdAt: now,
            updatedAt: now,
          ),
          portions: const [],
        ),
      );

      barcodeApiClient.result = const BarcodeLookupResultDto(
        barcode: '1111222233334',
        name: 'Remote Peanut Butter',
        brandName: 'Remote Brand',
        caloriesPer100g: 580,
        proteinPer100g: 22,
        carbsPer100g: 21,
        fatPer100g: 45,
      );

      final detail = await repository.lookupFoodByBarcode('1111222233334');

      expect(detail, isNotNull);
      expect(detail!.food.name, 'Trusted Peanut Butter');
      expect(detail.food.source, SyncSource.local);
      expect(detail.food.isUserEdited, isTrue);
    },
  );
}

class _FakeNutritionApiClient implements NutritionApiClient {
  List<FoodSearchResultDto> results = const [];

  @override
  Future<List<FoodSearchResultDto>> searchFoods(String query) async {
    return results;
  }
}

class _FakeBarcodeApiClient implements BarcodeApiClient {
  BarcodeLookupResultDto? result;

  @override
  Future<BarcodeLookupResultDto?> lookupBarcode(String barcode) async {
    return result;
  }
}
