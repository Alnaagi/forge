import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    @Default(false) bool isBuiltIn,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Exercise;
}
