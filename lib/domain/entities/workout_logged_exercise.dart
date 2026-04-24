import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/domain/entities/exercise.dart';
import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_exercise_entry.dart';

part 'workout_logged_exercise.freezed.dart';

@freezed
class WorkoutLoggedExercise with _$WorkoutLoggedExercise {
  const factory WorkoutLoggedExercise({
    required WorkoutExerciseEntry entry,
    required Exercise exercise,
    required List<SetEntry> sets,
  }) = _WorkoutLoggedExercise;
}
