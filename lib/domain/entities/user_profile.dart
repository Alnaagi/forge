import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/activity_level.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/value_objects/measurement_value.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String displayName,
    required WeightUnit preferredWeightUnit,
    required BodyMetricUnit preferredBodyMetricUnit,
    MeasurementValue? height,
    ActivityLevel? activityLevel,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfile;
}
