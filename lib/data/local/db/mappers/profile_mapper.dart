import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/user_profile.dart';
import 'package:forge/shared/value_objects/measurement_value.dart';

extension UserProfileDataMapper on UsersTableData {
  UserProfile toDomain() {
    return UserProfile(
      id: id,
      displayName: displayName,
      preferredWeightUnit: preferredWeightUnit,
      preferredBodyMetricUnit: preferredBodyMetricUnit,
      height:
          originalHeightValue != null &&
              originalHeightUnit != null &&
              canonicalHeightCentimeters != null
          ? MeasurementValue(
              originalValue: originalHeightValue!,
              originalUnit: originalHeightUnit!,
              canonicalCentimeters: canonicalHeightCentimeters!,
            )
          : null,
      activityLevel: activityLevel,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UserProfileCompanionMapper on UserProfile {
  UsersTableCompanion toCompanion() {
    return UsersTableCompanion(
      id: Value(id),
      displayName: Value(displayName),
      preferredWeightUnit: Value(preferredWeightUnit),
      preferredBodyMetricUnit: Value(preferredBodyMetricUnit),
      originalHeightValue: Value(height?.originalValue),
      originalHeightUnit: Value(height?.originalUnit),
      canonicalHeightCentimeters: Value(height?.canonicalCentimeters),
      activityLevel: Value(activityLevel),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
