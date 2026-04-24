import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/domain/entities/exercise.dart';
import 'package:forge/domain/entities/workout_template.dart';
import 'package:forge/domain/entities/workout_template_item.dart';

part 'workout_template_detail.freezed.dart';

@freezed
class WorkoutTemplateExerciseItem with _$WorkoutTemplateExerciseItem {
  const factory WorkoutTemplateExerciseItem({
    required WorkoutTemplateItem item,
    required Exercise exercise,
  }) = _WorkoutTemplateExerciseItem;
}

@freezed
class WorkoutTemplateDetail with _$WorkoutTemplateDetail {
  const factory WorkoutTemplateDetail({
    required WorkoutTemplate template,
    required List<WorkoutTemplateExerciseItem> items,
  }) = _WorkoutTemplateDetail;
}
