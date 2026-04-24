import 'package:forge/data/remote/dto/barcode_lookup_result_dto.dart';
import 'package:forge/data/remote/dto/food_search_result_dto.dart';
import 'package:forge/domain/entities/food.dart';
import 'package:forge/shared/enums/sync_source.dart';

class FoodDtoMapper {
  const FoodDtoMapper();

  Food fromSearchDto(FoodSearchResultDto dto, {required String id}) {
    final now = DateTime.now();
    return Food(
      id: id,
      name: dto.name,
      brandName: dto.brandName,
      barcode: dto.barcode,
      caloriesPer100g: dto.caloriesPer100g,
      proteinPer100g: dto.proteinPer100g,
      carbsPer100g: dto.carbsPer100g,
      fatPer100g: dto.fatPer100g,
      source: SyncSource.remoteApi,
      isUserEdited: false,
      createdAt: now,
      updatedAt: now,
    );
  }

  Food fromBarcodeDto(BarcodeLookupResultDto dto, {required String id}) {
    final now = DateTime.now();
    return Food(
      id: id,
      name: dto.name,
      brandName: dto.brandName,
      barcode: dto.barcode,
      caloriesPer100g: dto.caloriesPer100g ?? 0,
      proteinPer100g: dto.proteinPer100g ?? 0,
      carbsPer100g: dto.carbsPer100g ?? 0,
      fatPer100g: dto.fatPer100g ?? 0,
      source: SyncSource.barcodeLookup,
      isUserEdited: false,
      createdAt: now,
      updatedAt: now,
    );
  }
}
