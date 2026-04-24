import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/domain/entities/workout_logged_exercise.dart';
import 'package:forge/domain/entities/workout_session.dart';

part 'workout_session_detail.freezed.dart';

@freezed
class WorkoutSessionDetail with _$WorkoutSessionDetail {
  const factory WorkoutSessionDetail({
    required WorkoutSession session,
    required List<WorkoutLoggedExercise> exercises,
    required int totalSets,
    required double totalVolumeKilograms,
  }) = _WorkoutSessionDetail;
}
