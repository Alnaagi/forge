import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_history_item.freezed.dart';

@freezed
class WorkoutHistoryItem with _$WorkoutHistoryItem {
  const factory WorkoutHistoryItem({
    required String sessionId,
    String? templateName,
    required DateTime startedAt,
    DateTime? endedAt,
    required int exerciseCount,
    required int setCount,
    required double totalVolumeKilograms,
  }) = _WorkoutHistoryItem;
}
