import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

part 'set_entry.freezed.dart';

@freezed
class SetEntry with _$SetEntry {
  const factory SetEntry({
    required String id,
    required String exerciseEntryId,
    required SetType setType,
    required int orderIndex,
    required int reps,
    WeightValue? weight,
    double? rpe,
    String? tempo,
    int? restSeconds,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SetEntry;
}
