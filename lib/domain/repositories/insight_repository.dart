import 'package:forge/domain/entities/insight.dart';
import 'package:forge/shared/enums/insight_status.dart';

abstract class InsightRepository {
  Future<List<Insight>> getAllInsights();
  Future<List<Insight>> getActiveInsights();
  Future<void> saveInsight(Insight insight);
  Future<void> updateStatus({
    required String insightId,
    required InsightStatus status,
  });
}
