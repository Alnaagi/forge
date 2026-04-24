import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String displayName,
    required WeightUnit preferredWeightUnit,
    required BodyMetricUnit preferredBodyMetricUnit,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfile;
}
