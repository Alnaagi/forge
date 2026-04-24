import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:forge/domain/entities/health_sync_data_point.dart';

abstract class HealthConnectClient {
  Future<HealthSyncConnectionStatus> getStatus();
  Future<HealthSyncConnectionStatus> requestPermissions();
  Future<void> openInstallScreen();
  Future<List<HealthSyncDataPoint>> readData({
    required DateTime startTime,
    required DateTime endTime,
  });
}
