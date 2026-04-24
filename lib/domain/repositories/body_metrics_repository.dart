import 'package:forge/domain/entities/body_log.dart';

abstract class BodyMetricsRepository {
  Future<List<BodyLog>> getBodyLogs();
  Future<void> saveBodyLog(BodyLog bodyLog);
  Future<void> deleteBodyLog(String bodyLogId);
  Future<BodyLog?> getLatestBodyLog();
}
