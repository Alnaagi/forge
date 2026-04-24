import 'package:forge/domain/entities/app_setting.dart';

abstract class SettingsRepository {
  Future<List<AppSetting>> getAll();
  Future<void> save(AppSetting setting);
  Future<AppSetting?> getByKey(String key);
}
