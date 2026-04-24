import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/volume_unit.dart';

part 'volume_value.freezed.dart';

@freezed
class VolumeValue with _$VolumeValue {
  @Assert('originalValue >= 0', 'Volume cannot be negative.')
  @Assert('canonicalMilliliters >= 0', 'Canonical volume cannot be negative.')
  const factory VolumeValue({
    required double originalValue,
    required VolumeUnit originalUnit,
    required double canonicalMilliliters,
  }) = _VolumeValue;
}
