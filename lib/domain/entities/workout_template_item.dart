import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_template_item.freezed.dart';

@freezed
class WorkoutTemplateItem with _$WorkoutTemplateItem {
  const factory WorkoutTemplateItem({
    required String id,
    required String templateId,
    required String exerciseId,
    required int orderIndex,
    required int targetSets,
    required String targetReps,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkoutTemplateItem;
}
