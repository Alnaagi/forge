import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/user_profile.dart';

extension UserProfileDataMapper on UsersTableData {
  UserProfile toDomain() {
    return UserProfile(
      id: id,
      displayName: displayName,
      preferredWeightUnit: preferredWeightUnit,
      preferredBodyMetricUnit: preferredBodyMetricUnit,
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
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
