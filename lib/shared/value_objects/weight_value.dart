import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/weight_unit.dart';

part 'weight_value.freezed.dart';

@freezed
class WeightValue with _$WeightValue {
  @Assert('originalValue >= 0', 'Weight cannot be negative.')
  @Assert('canonicalKilograms >= 0', 'Canonical weight cannot be negative.')
  const factory WeightValue({
    required double originalValue,
    required WeightUnit originalUnit,
    required double canonicalKilograms,
  }) = _WeightValue;
}
