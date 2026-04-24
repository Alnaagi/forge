import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_exercise_entry.freezed.dart';

@freezed
class WorkoutExerciseEntry with _$WorkoutExerciseEntry {
  const factory WorkoutExerciseEntry({
    required String id,
    required String sessionId,
    required String exerciseId,
    required int orderIndex,
    String? notes,
    String? supersetGroupId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkoutExerciseEntry;
}
