import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_session.freezed.dart';

@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    String? templateId,
    required DateTime startedAt,
    DateTime? endedAt,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkoutSession;
}
