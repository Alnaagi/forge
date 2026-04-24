import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/sync_source.dart';

part 'food.freezed.dart';

@freezed
class Food with _$Food {
  const factory Food({
    required String id,
    required String name,
    String? brandName,
    String? barcode,
    required int caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    required SyncSource source,
    @Default(false) bool isUserEdited,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Food;
}
