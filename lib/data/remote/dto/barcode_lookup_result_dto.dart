import 'package:freezed_annotation/freezed_annotation.dart';

part 'barcode_lookup_result_dto.freezed.dart';

@freezed
class BarcodeLookupResultDto with _$BarcodeLookupResultDto {
  const factory BarcodeLookupResultDto({
    required String barcode,
    required String name,
    String? brandName,
    int? caloriesPer100g,
    double? proteinPer100g,
    double? carbsPer100g,
    double? fatPer100g,
  }) = _BarcodeLookupResultDto;
}
