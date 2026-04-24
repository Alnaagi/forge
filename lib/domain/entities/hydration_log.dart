import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/value_objects/volume_value.dart';

part 'hydration_log.freezed.dart';

@freezed
class HydrationLog with _$HydrationLog {
  const factory HydrationLog({
    required String id,
    required VolumeValue amount,
    required DateTime loggedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _HydrationLog;
}
