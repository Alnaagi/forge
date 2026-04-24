import 'package:forge/data/local/db/daos/settings_dao.dart';
import 'package:forge/data/local/db/mappers/app_setting_mapper.dart';
import 'package:forge/domain/entities/app_setting.dart';
import 'package:forge/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._dao);

  final SettingsDao _dao;

  @override
  Future<List<AppSetting>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<void> save(AppSetting setting) async {
    await _dao.upsert(setting.toCompanion());
  }

  @override
  Future<AppSetting?> getByKey(String key) async {
    final row = await _dao.getByKey(key);
    return row?.toDomain();
  }
}
