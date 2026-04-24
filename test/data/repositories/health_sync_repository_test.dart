import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/application/services/health_connect_client_base.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/daos/body_metrics_dao.dart';
import 'package:forge/data/local/db/daos/health_sync_dao.dart';
import 'package:forge/data/local/db/daos/settings_dao.dart';
import 'package:forge/data/repositories/body_metrics_repository_impl.dart';
import 'package:forge/data/repositories/health_sync_repository_impl.dart';
import 'package:forge/data/repositories/settings_repository_impl.dart';
import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:forge/domain/entities/health_sync_data_point.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';

void main() {
  late AppDatabase database;
  late FakeHealthConnectClient client;
  late HealthSyncRepositoryImpl repository;
  late BodyMetricsRepositoryImpl bodyMetricsRepository;

  setUp(() {
    database = AppDatabase.test(NativeDatabase.memory());
    client = FakeHealthConnectClient();
    bodyMetricsRepository = BodyMetricsRepositoryImpl(BodyMetricsDao(database));
    repository = HealthSyncRepositoryImpl(
      HealthSyncDao(database),
      client: client,
      settingsRepository: SettingsRepositoryImpl(SettingsDao(database)),
      bodyMetricsRepository: bodyMetricsRepository,
      unitConverter: const UnitConverter(),
      uuidService: const UuidService(),
      clock: () => DateTime(2026, 4, 22, 12),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('syncNow imports records and mirrors body weight safely', () async {
    client.status = const HealthSyncConnectionStatus(
      availability: HealthSyncAvailability.available,
      activityRecognitionGranted: true,
      readPermissionsGranted: true,
      stepPermissionsGranted: true,
      historyAccessGranted: true,
      historyAccessAvailable: true,
    );
    client.points = [
      _point(
        type: HealthSyncDataType.steps,
        externalId: 'steps-1',
        numericValue: 4200,
        unit: 'COUNT',
        startAt: DateTime(2026, 4, 22, 7),
        endAt: DateTime(2026, 4, 22, 8),
      ),
      _point(
        type: HealthSyncDataType.sleep,
        externalId: 'sleep-1',
        numericValue: 435,
        unit: 'MINUTE',
        startAt: DateTime(2026, 4, 21, 23),
        endAt: DateTime(2026, 4, 22, 6, 15),
      ),
      _point(
        type: HealthSyncDataType.bodyWeight,
        externalId: 'weight-1',
        numericValue: 82.4,
        unit: 'KILOGRAM',
        startAt: DateTime(2026, 4, 22, 8, 30),
        endAt: DateTime(2026, 4, 22, 8, 30),
      ),
    ];

    final result = await repository.syncNow();
    final records = await repository.getAll();
    final bodyLogs = await bodyMetricsRepository.getBodyLogs();
    final lastSyncAt = await repository.getLastSyncAt();

    expect(result.importedRecordCount, 3);
    expect(result.importedBodyWeightCount, 1);
    expect(records, hasLength(3));
    expect(bodyLogs, hasLength(1));
    expect(bodyLogs.first.bodyWeight?.canonicalKilograms, closeTo(82.4, 0.001));
    expect(bodyLogs.first.notes, 'Imported from Health Connect');
    expect(lastSyncAt, DateTime(2026, 4, 22, 12));
  });

  test(
    'repeat sync does not duplicate external records or body weight logs',
    () async {
      client.status = const HealthSyncConnectionStatus(
        availability: HealthSyncAvailability.available,
        activityRecognitionGranted: true,
        readPermissionsGranted: true,
        stepPermissionsGranted: true,
        historyAccessGranted: false,
        historyAccessAvailable: false,
      );
      client.points = [
        _point(
          type: HealthSyncDataType.bodyWeight,
          externalId: 'weight-1',
          numericValue: 81.0,
          unit: 'KILOGRAM',
          startAt: DateTime(2026, 4, 22, 8),
          endAt: DateTime(2026, 4, 22, 8),
        ),
      ];

      await repository.syncNow();
      final secondResult = await repository.syncNow();

      final records = await repository.getAll();
      final bodyLogs = await bodyMetricsRepository.getBodyLogs();

      expect(secondResult.importedRecordCount, 0);
      expect(secondResult.importedBodyWeightCount, 0);
      expect(records, hasLength(1));
      expect(bodyLogs, hasLength(1));
    },
  );

  test('syncNow fails clearly when permissions are not ready', () async {
    client.status = const HealthSyncConnectionStatus(
      availability: HealthSyncAvailability.available,
      activityRecognitionGranted: false,
      readPermissionsGranted: false,
      stepPermissionsGranted: false,
      historyAccessGranted: false,
      historyAccessAvailable: true,
    );

    expect(repository.syncNow, throwsA(isA<StateError>()));
  });

  test('syncNow still imports core data when step permission path is blocked', () async {
    client.status = const HealthSyncConnectionStatus(
      availability: HealthSyncAvailability.available,
      activityRecognitionGranted: false,
      readPermissionsGranted: true,
      stepPermissionsGranted: false,
      historyAccessGranted: true,
      historyAccessAvailable: true,
    );
    client.points = [
      _point(
        type: HealthSyncDataType.heartRate,
        externalId: 'heart-1',
        numericValue: 71,
        unit: 'BEATS_PER_MINUTE',
        startAt: DateTime(2026, 4, 22, 9),
        endAt: DateTime(2026, 4, 22, 9, 5),
      ),
    ];

    final result = await repository.syncNow();
    final records = await repository.getAll();

    expect(result.importedRecordCount, 1);
    expect(records, hasLength(1));
    expect(records.first.recordType, 'heart_rate');
  });
}

class FakeHealthConnectClient implements HealthConnectClient {
  HealthSyncConnectionStatus status = const HealthSyncConnectionStatus(
    availability: HealthSyncAvailability.unavailable,
    activityRecognitionGranted: false,
    readPermissionsGranted: false,
    stepPermissionsGranted: false,
    historyAccessGranted: false,
    historyAccessAvailable: false,
  );

  List<HealthSyncDataPoint> points = const [];

  @override
  Future<HealthSyncConnectionStatus> getStatus() async => status;

  @override
  Future<void> openInstallScreen() async {}

  @override
  Future<List<HealthSyncDataPoint>> readData({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    return points;
  }

  @override
  Future<HealthSyncConnectionStatus> requestPermissions() async => status;
}

HealthSyncDataPoint _point({
  required HealthSyncDataType type,
  required String externalId,
  required double numericValue,
  required String unit,
  required DateTime startAt,
  required DateTime endAt,
}) {
  return HealthSyncDataPoint(
    type: type,
    externalId: externalId,
    numericValue: numericValue,
    unit: unit,
    startAt: startAt,
    endAt: endAt,
    recordedAt: endAt,
    sourceId: 'health-connect',
    sourceName: 'Health Connect',
    sourceDeviceId: 'device',
    recordingMethod: 'automatic',
    rawPayload: const {'sample': true},
  );
}
