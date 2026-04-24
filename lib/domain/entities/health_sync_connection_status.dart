import 'package:forge/domain/entities/health_sync_data_point.dart';

enum HealthSyncAvailability {
  unsupportedPlatform,
  unavailable,
  providerUpdateRequired,
  available,
}

class HealthSyncConnectionStatus {
  const HealthSyncConnectionStatus({
    required this.availability,
    required this.activityRecognitionGranted,
    required this.readPermissionsGranted,
    required this.stepPermissionsGranted,
    required this.historyAccessGranted,
    required this.historyAccessAvailable,
    this.supportedTypes = const [
      HealthSyncDataType.steps,
      HealthSyncDataType.heartRate,
      HealthSyncDataType.sleep,
      HealthSyncDataType.bodyWeight,
    ],
  });

  final HealthSyncAvailability availability;
  final bool activityRecognitionGranted;
  final bool readPermissionsGranted;
  final bool stepPermissionsGranted;
  final bool historyAccessGranted;
  final bool historyAccessAvailable;
  final List<HealthSyncDataType> supportedTypes;

  bool get canInstallProvider =>
      availability == HealthSyncAvailability.unavailable ||
      availability == HealthSyncAvailability.providerUpdateRequired;

  bool get canRequestPermissions =>
      availability == HealthSyncAvailability.available;

  bool get canSyncCoreData =>
      availability == HealthSyncAvailability.available && readPermissionsGranted;

  bool get canSyncSteps =>
      availability == HealthSyncAvailability.available &&
      stepPermissionsGranted &&
      activityRecognitionGranted;

  bool get canSync =>
      availability == HealthSyncAvailability.available &&
      (canSyncCoreData || canSyncSteps);
}
