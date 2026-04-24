import 'package:dio/dio.dart';
import 'package:forge/app/core/constants/app_constants.dart';
import 'package:forge/data/remote/dto/food_search_result_dto.dart';

abstract class NutritionApiClient {
  Future<List<FoodSearchResultDto>> searchFoods(String query);
}

class OpenFoodFactsNutritionApiClient implements NutritionApiClient {
  const OpenFoodFactsNutritionApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<FoodSearchResultDto>> searchFoods(String query) async {
    final normalized = query.trim();
    if (normalized.length < 3) {
      return const [];
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/v2/search',
        queryParameters: {
          'search_terms': normalized,
          'page_size': AppConstants.assistiveNutritionSearchLimit,
          'fields': 'code,product_name,brands,nutriments',
        },
      );
      final data = response.data;
      if (data == null) {
        return const [];
      }

      final rawProducts = data['products'];
      if (rawProducts is! List) {
        return const [];
      }

      return rawProducts
          .whereType<Map<String, dynamic>>()
          .map(_mapProduct)
          .whereType<FoodSearchResultDto>()
          .toList(growable: false);
    } on DioException {
      return const [];
    } on FormatException {
      return const [];
    }
  }

  FoodSearchResultDto? _mapProduct(Map<String, dynamic> product) {
    final name = (product['product_name'] as String?)?.trim();
    if (name == null || name.isEmpty) {
      return null;
    }

    final nutriments = product['nutriments'];
    final nutrimentMap = nutriments is Map<String, dynamic>
        ? nutriments
        : const <String, dynamic>{};

    return FoodSearchResultDto(
      name: name,
      brandName: _cleanOptionalString(product['brands']),
      barcode: _cleanOptionalString(product['code']),
      caloriesPer100g: _readNumber(nutrimentMap, 'energy-kcal_100g').round(),
      proteinPer100g: _readNumber(nutrimentMap, 'proteins_100g'),
      carbsPer100g: _readNumber(nutrimentMap, 'carbohydrates_100g'),
      fatPer100g: _readNumber(nutrimentMap, 'fat_100g'),
    );
  }
}

class NoopNutritionApiClient implements NutritionApiClient {
  const NoopNutritionApiClient();

  @override
  Future<List<FoodSearchResultDto>> searchFoods(String query) async {
    return const [];
  }
}

double _readNumber(Map<String, dynamic> source, String key) {
  final value = source[key];
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

String? _cleanOptionalString(Object? value) {
  final stringValue = value?.toString().trim();
  if (stringValue == null || stringValue.isEmpty) {
    return null;
  }
  return stringValue;
}
