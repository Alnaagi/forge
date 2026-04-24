import 'package:forge/data/local/db/daos/health_tracking_dao.dart';
import 'package:forge/data/local/db/mappers/health_tracking_mapper.dart';
import 'package:forge/domain/entities/health_profile.dart';
import 'package:forge/domain/entities/health_status_log.dart';
import 'package:forge/domain/repositories/health_repository.dart';

class HealthRepositoryImpl implements HealthRepository {
  const HealthRepositoryImpl(this._dao);

  final HealthTrackingDao _dao;

  @override
  Future<HealthProfile?> getHealthProfile() async {
    final row = await _dao.getHealthProfile();
    return row?.toDomain();
  }

  @override
  Future<void> saveHealthProfile(HealthProfile profile) {
    return _dao.upsertHealthProfile(profile.toCompanion());
  }

  @override
  Future<List<HealthStatusLog>> getHealthStatusLogs() async {
    final rows = await _dao.getHealthStatusLogs();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<void> saveHealthStatusLog(HealthStatusLog log) {
    return _dao.upsertHealthStatusLog(log.toCompanion());
  }

  @override
  Future<void> deleteHealthStatusLog(String logId) {
    return _dao.deleteHealthStatusLog(logId);
  }
}
