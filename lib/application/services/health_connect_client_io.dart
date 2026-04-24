import 'dart:convert';
import 'dart:io';

import 'package:forge/application/services/health_connect_client_base.dart';
import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:forge/domain/entities/health_sync_data_point.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class IoHealthConnectClient implements HealthConnectClient {
  IoHealthConnectClient({Health? health}) : _health = health ?? Health();

  final Health _health;
  bool _isConfigured = false;

  static const _coreTypes = <HealthDataType>[
    HealthDataType.HEART_RATE,
    HealthDataType.SLEEP_SESSION,
    HealthDataType.WEIGHT,
  ];
  static const _stepTypes = <HealthDataType>[HealthDataType.STEPS];
  static const _allTypes = <HealthDataType>[
    HealthDataType.STEPS,
    ..._coreTypes,
  ];

  @override
  Future<HealthSyncConnectionStatus> getStatus() async {
    if (!Platform.isAndroid) {
      return const HealthSyncConnectionStatus(
        availability: HealthSyncAvailability.unsupportedPlatform,
        activityRecognitionGranted: false,
        readPermissionsGranted: false,
        stepPermissionsGranted: false,
        historyAccessGranted: false,
        historyAccessAvailable: false,
      );
    }

    await _configureIfNeeded();
    final sdkStatus = await _health.getHealthConnectSdkStatus();
    final availability = _mapAvailability(sdkStatus);
    if (availability != HealthSyncAvailability.available) {
      return HealthSyncConnectionStatus(
        availability: availability,
        activityRecognitionGranted: false,
        readPermissionsGranted: false,
        stepPermissionsGranted: false,
        historyAccessGranted: false,
        historyAccessAvailable: false,
      );
    }

    final activityRecognitionGranted =
        (await Permission.activityRecognition.status).isGranted;
    final readPermissionsGranted =
        await _health.hasPermissions(_coreTypes) ?? false;
    final stepPermissionsGranted =
        await _health.hasPermissions(_stepTypes) ?? false;
    final historyAccessAvailable = await _health.isHealthDataHistoryAvailable();
    final historyAccessGranted = historyAccessAvailable
        ? await _health.isHealthDataHistoryAuthorized()
        : false;

    return HealthSyncConnectionStatus(
      availability: availability,
      activityRecognitionGranted: activityRecognitionGranted,
      readPermissionsGranted: readPermissionsGranted,
      stepPermissionsGranted: stepPermissionsGranted,
      historyAccessGranted: historyAccessGranted,
      historyAccessAvailable: historyAccessAvailable,
    );
  }

  @override
  Future<HealthSyncConnectionStatus> requestPermissions() async {
    if (!Platform.isAndroid) {
      return getStatus();
    }

    final status = await getStatus();
    if (status.availability != HealthSyncAvailability.available) {
      return status;
    }

    await Permission.activityRecognition.request();
    await _health.requestAuthorization(_allTypes);

    if (await _health.isHealthDataHistoryAvailable()) {
      await _health.requestHealthDataHistoryAuthorization();
    }

    return getStatus();
  }

  @override
  Future<void> openInstallScreen() async {
    if (!Platform.isAndroid) {
      return;
    }
    await _configureIfNeeded();
    await _health.installHealthConnect();
  }

  @override
  Future<List<HealthSyncDataPoint>> readData({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    await _configureIfNeeded();
    final status = await getStatus();
    final allowedTypes = <HealthDataType>[
      if (status.canSyncCoreData) ..._coreTypes,
      if (status.canSyncSteps) ..._stepTypes,
    ];
    if (allowedTypes.isEmpty) {
      return const [];
    }
    final points = await _health.getHealthDataFromTypes(
      startTime: startTime,
      endTime: endTime,
      types: allowedTypes,
    );

    return points
        .map(_mapPoint)
        .whereType<HealthSyncDataPoint>()
        .toList(growable: false);
  }

  Future<void> _configureIfNeeded() async {
    if (_isConfigured) {
      return;
    }
    await _health.configure();
    _isConfigured = true;
  }

  HealthSyncAvailability _mapAvailability(HealthConnectSdkStatus? status) {
    if (!Platform.isAndroid) {
      return HealthSyncAvailability.unsupportedPlatform;
    }
    return switch (status) {
      HealthConnectSdkStatus.sdkAvailable => HealthSyncAvailability.available,
      HealthConnectSdkStatus.sdkUnavailableProviderUpdateRequired =>
        HealthSyncAvailability.providerUpdateRequired,
      _ => HealthSyncAvailability.unavailable,
    };
  }

  HealthSyncDataPoint? _mapPoint(HealthDataPoint point) {
    final numericValue = switch (point.value) {
      NumericHealthValue value => value.numericValue.toDouble(),
      _ => null,
    };
    if (numericValue == null) {
      return null;
    }

    final type = switch (point.type) {
      HealthDataType.STEPS => HealthSyncDataType.steps,
      HealthDataType.HEART_RATE => HealthSyncDataType.heartRate,
      HealthDataType.SLEEP_SESSION => HealthSyncDataType.sleep,
      HealthDataType.WEIGHT => HealthSyncDataType.bodyWeight,
      _ => null,
    };
    if (type == null) {
      return null;
    }

    final externalId = _stableExternalId(point, numericValue);
    return HealthSyncDataPoint(
      type: type,
      externalId: externalId,
      numericValue: numericValue,
      unit: point.unit.name,
      startAt: point.dateFrom,
      endAt: point.dateTo,
      recordedAt: point.dateTo,
      sourceId: point.sourceId,
      sourceName: point.sourceName,
      sourceDeviceId: point.sourceDeviceId,
      recordingMethod: point.recordingMethod.name,
      rawPayload: Map<String, dynamic>.from(
        jsonDecode(jsonEncode(point.toJson())) as Map,
      ),
    );
  }

  String _stableExternalId(HealthDataPoint point, double numericValue) {
    if (point.uuid.trim().isNotEmpty) {
      return point.uuid.trim();
    }
    final seed = [
      point.type.name,
      point.dateFrom.toIso8601String(),
      point.dateTo.toIso8601String(),
      point.sourceId,
      point.sourceName,
      numericValue.toStringAsFixed(4),
    ].join('|');
    var hash = 0xcbf29ce484222325;
    for (final codeUnit in seed.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x100000001b3) & 0x7fffffffffffffff;
    }
    return '${point.type.name.toLowerCase()}-${hash.toRadixString(16)}';
  }
}

HealthConnectClient createPlatformClient() => IoHealthConnectClient();
