import 'package:forge/data/local/db/daos/body_metrics_dao.dart';
import 'package:forge/data/local/db/mappers/body_metrics_mapper.dart';
import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/domain/repositories/body_metrics_repository.dart';

class BodyMetricsRepositoryImpl implements BodyMetricsRepository {
  const BodyMetricsRepositoryImpl(this._dao);

  final BodyMetricsDao _dao;

  @override
  Future<List<BodyLog>> getBodyLogs() async {
    final rows = await _dao.getBodyLogs();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<void> saveBodyLog(BodyLog bodyLog) {
    return _dao.upsert(bodyLog.toCompanion());
  }

  @override
  Future<void> deleteBodyLog(String bodyLogId) {
    return _dao.delete(bodyLogId);
  }

  @override
  Future<BodyLog?> getLatestBodyLog() async {
    final row = await _dao.getLatestBodyLog();
    return row?.toDomain();
  }
}
