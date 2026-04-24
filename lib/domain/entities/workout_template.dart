import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_template.freezed.dart';

@freezed
class WorkoutTemplate with _$WorkoutTemplate {
  const factory WorkoutTemplate({
    required String id,
    required String name,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkoutTemplate;
}
