import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/app_setting.dart';

extension AppSettingDataMapper on AppSettingsTableData {
  AppSetting toDomain() {
    return AppSetting(key: key, value: value, updatedAt: updatedAt);
  }
}

extension AppSettingCompanionMapper on AppSetting {
  AppSettingsTableCompanion toCompanion() {
    return AppSettingsTableCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }
}
