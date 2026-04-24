import 'package:forge/application/services/health_connect_client_base.dart';
import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:forge/domain/entities/health_sync_data_point.dart';

class StubHealthConnectClient implements HealthConnectClient {
  const StubHealthConnectClient();

  @override
  Future<HealthSyncConnectionStatus> getStatus() async {
    return const HealthSyncConnectionStatus(
      availability: HealthSyncAvailability.unsupportedPlatform,
      activityRecognitionGranted: false,
      readPermissionsGranted: false,
      stepPermissionsGranted: false,
      historyAccessGranted: false,
      historyAccessAvailable: false,
    );
  }

  @override
  Future<void> openInstallScreen() async {}

  @override
  Future<List<HealthSyncDataPoint>> readData({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    return const [];
  }

  @override
  Future<HealthSyncConnectionStatus> requestPermissions() {
    return getStatus();
  }
}

HealthConnectClient createPlatformClient() => const StubHealthConnectClient();
