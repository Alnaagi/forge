import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';

part 'measurement_value.freezed.dart';

@freezed
class MeasurementValue with _$MeasurementValue {
  @Assert('originalValue >= 0', 'Measurement cannot be negative.')
  @Assert(
    'canonicalCentimeters >= 0',
    'Canonical measurement cannot be negative.',
  )
  const factory MeasurementValue({
    required double originalValue,
    required BodyMetricUnit originalUnit,
    required double canonicalCentimeters,
  }) = _MeasurementValue;
}
