import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/value_objects/measurement_value.dart';
import 'package:forge/shared/value_objects/percentage_value.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

part 'body_log.freezed.dart';

@freezed
class BodyLog with _$BodyLog {
  const factory BodyLog({
    required String id,
    required DateTime loggedAt,
    WeightValue? bodyWeight,
    PercentageValue? bodyFatPercentage,
    MeasurementValue? waist,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BodyLog;
}
