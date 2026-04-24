import 'package:forge/data/local/db/daos/insight_dao.dart';
import 'package:forge/data/local/db/mappers/insight_mapper.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/domain/repositories/insight_repository.dart';
import 'package:forge/shared/enums/insight_status.dart';

class InsightRepositoryImpl implements InsightRepository {
  const InsightRepositoryImpl(this._dao);

  final InsightDao _dao;

  @override
  Future<List<Insight>> getAllInsights() async {
    final rows = await _dao.getAllInsights();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<List<Insight>> getActiveInsights() async {
    final rows = await _dao.getActiveInsights();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<void> saveInsight(Insight insight) {
    return _dao.upsert(insight.toCompanion());
  }

  @override
  Future<void> updateStatus({
    required String insightId,
    required InsightStatus status,
  }) {
    return _dao.updateStatus(insightId: insightId, status: status);
  }
}
