import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:forge/app/core/constants/app_constants.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/nutrition_dao.dart';
import 'package:forge/data/remote/clients/barcode_api_client.dart';
import 'package:forge/data/remote/clients/nutrition_api_client.dart';
import 'package:forge/data/remote/mappers/food_dto_mapper.dart';
import 'package:forge/data/repositories/nutrition_repository_impl.dart';
import 'package:forge/domain/repositories/nutrition_repository.dart';
import 'package:forge/domain/services/food_quantity_resolver_service.dart';
import 'package:forge/domain/services/macro_calculator_service.dart';

final nutritionUuidServiceProvider = Provider<UuidService>((ref) {
  return const UuidService();
});

final nutritionDaoProvider = Provider<NutritionDao>((ref) {
  return NutritionDao(ref.watch(appDatabaseProvider));
});

final assistiveNutritionDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppConstants.openFoodFactsBaseUrl,
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
      headers: const {'User-Agent': 'Forge/0.1 (assistive nutrition lookup)'},
    ),
  );
});

final nutritionApiClientProvider = Provider<NutritionApiClient>((ref) {
  return OpenFoodFactsNutritionApiClient(
    dio: ref.watch(assistiveNutritionDioProvider),
  );
});

final barcodeApiClientProvider = Provider<BarcodeApiClient>((ref) {
  return OpenFoodFactsBarcodeApiClient(
    dio: ref.watch(assistiveNutritionDioProvider),
  );
});

final foodDtoMapperProvider = Provider<FoodDtoMapper>((ref) {
  return const FoodDtoMapper();
});

final foodQuantityResolverServiceProvider =
    Provider<FoodQuantityResolverService>((ref) {
      return const FoodQuantityResolverService();
    });

final macroCalculatorServiceProvider = Provider<MacroCalculatorService>((ref) {
  return const MacroCalculatorService();
});

final nutritionRepositoryProvider = Provider<NutritionRepository>((ref) {
  return NutritionRepositoryImpl(
    dao: ref.watch(nutritionDaoProvider),
    nutritionApiClient: ref.watch(nutritionApiClientProvider),
    barcodeApiClient: ref.watch(barcodeApiClientProvider),
    foodDtoMapper: ref.watch(foodDtoMapperProvider),
    macroCalculatorService: ref.watch(macroCalculatorServiceProvider),
    uuidService: ref.watch(nutritionUuidServiceProvider),
  );
});
