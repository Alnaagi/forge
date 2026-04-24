import 'package:forge/domain/entities/app_setting.dart';
import 'package:forge/domain/repositories/settings_repository.dart';

class UpdateUnitPreferences {
  const UpdateUnitPreferences(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppSetting setting) {
    return _repository.save(setting);
  }
}
