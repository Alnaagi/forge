import 'package:dio/dio.dart';
import 'package:forge/data/remote/dto/barcode_lookup_result_dto.dart';

abstract class BarcodeApiClient {
  Future<BarcodeLookupResultDto?> lookupBarcode(String barcode);
}

class OpenFoodFactsBarcodeApiClient implements BarcodeApiClient {
  const OpenFoodFactsBarcodeApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<BarcodeLookupResultDto?> lookupBarcode(String barcode) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/v2/product/$barcode',
        queryParameters: {'fields': 'code,product_name,brands,nutriments'},
      );
      final data = response.data;
      if (data == null || data['status'] != 1) {
        return null;
      }

      final product = data['product'];
      if (product is! Map<String, dynamic>) {
        return null;
      }

      final name = (product['product_name'] as String?)?.trim();
      if (name == null || name.isEmpty) {
        return null;
      }

      final nutriments = product['nutriments'];
      final nutrimentMap = nutriments is Map<String, dynamic>
          ? nutriments
          : const <String, dynamic>{};

      return BarcodeLookupResultDto(
        barcode: barcode,
        name: name,
        brandName: _cleanOptionalString(product['brands']),
        caloriesPer100g: _readNumber(nutrimentMap, 'energy-kcal_100g').round(),
        proteinPer100g: _readNumber(nutrimentMap, 'proteins_100g'),
        carbsPer100g: _readNumber(nutrimentMap, 'carbohydrates_100g'),
        fatPer100g: _readNumber(nutrimentMap, 'fat_100g'),
      );
    } on DioException {
      return null;
    } on FormatException {
      return null;
    }
  }
}

class NoopBarcodeApiClient implements BarcodeApiClient {
  const NoopBarcodeApiClient();

  @override
  Future<BarcodeLookupResultDto?> lookupBarcode(String barcode) async {
    return null;
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
