import 'package:forge/domain/entities/health_profile.dart';
import 'package:forge/domain/entities/health_status_log.dart';

abstract class HealthRepository {
  Future<HealthProfile?> getHealthProfile();
  Future<void> saveHealthProfile(HealthProfile profile);
  Future<List<HealthStatusLog>> getHealthStatusLogs();
  Future<void> saveHealthStatusLog(HealthStatusLog log);
  Future<void> deleteHealthStatusLog(String logId);
}
