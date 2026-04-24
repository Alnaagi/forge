import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/value_objects/macro_target.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

part 'goal.freezed.dart';

@freezed
class Goal with _$Goal {
  const factory Goal({
    required String id,
    required GoalType type,
    String? title,
    WeightValue? targetWeight,
    required MacroTarget macroTarget,
    required bool isActive,
    required DateTime startedAt,
    DateTime? endedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Goal;
}
