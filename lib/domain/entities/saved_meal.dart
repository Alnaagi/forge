import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_meal.freezed.dart';

@freezed
class SavedMeal with _$SavedMeal {
  const factory SavedMeal({
    required String id,
    required String name,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SavedMeal;
}
