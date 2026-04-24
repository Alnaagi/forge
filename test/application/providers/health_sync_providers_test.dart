import 'package:flutter_test/flutter_test.dart';
import 'package:forge/application/providers/health_sync_providers.dart';
import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:forge/domain/entities/health_sync_data_point.dart';
import 'package:forge/domain/entities/health_sync_record.dart';
import 'package:forge/shared/enums/sync_source.dart';

void main() {
  test('HealthSyncOverview builds useful summaries from imported records', () {
    final now = DateTime(2026, 4, 22, 16);
    final overview = HealthSyncOverview.fromRecords(
      status: const HealthSyncConnectionStatus(
        availability: HealthSyncAvailability.available,
        activityRecognitionGranted: true,
        readPermissionsGranted: true,
        stepPermissionsGranted: true,
        historyAccessGranted: true,
        historyAccessAvailable: true,
      ),
      records: [
        _record(
          _point(
            type: HealthSyncDataType.steps,
            externalId: 'steps-1',
            numericValue: 3600,
            unit: 'COUNT',
            startAt: DateTime(2026, 4, 22, 9),
            endAt: DateTime(2026, 4, 22, 10),
          ),
        ),
        _record(
          _point(
            type: HealthSyncDataType.heartRate,
            externalId: 'heart-1',
            numericValue: 78,
            unit: 'BEATS_PER_MINUTE',
            startAt: DateTime(2026, 4, 22, 10),
            endAt: DateTime(2026, 4, 22, 10, 5),
          ),
        ),
        _record(
          _point(
            type: HealthSyncDataType.sleep,
            externalId: 'sleep-1',
            numericValue: 430,
            unit: 'MINUTE',
            startAt: DateTime(2026, 4, 21, 23),
            endAt: DateTime(2026, 4, 22, 6, 10),
          ),
        ),
      ],
      lastSyncAt: DateTime(2026, 4, 22, 12),
      lastSyncError: null,
      now: now,
    );

    expect(overview.todaySteps, 3600);
    expect(overview.latestHeartRate?.numericValue, 78);
    expect(overview.latestSleepSession?.numericValue, 430);
    expect(overview.hasImportedData, isTrue);
  });
}

HealthSyncRecord _record(HealthSyncDataPoint point) {
  return HealthSyncRecord(
    id: 'record-${point.externalId}',
    source: SyncSource.healthConnect,
    recordType: point.type.storageKey,
    externalId: point.externalId,
    payloadJson:
        '{"type":"${point.type.storageKey}","externalId":"${point.externalId}","numericValue":${point.numericValue},"unit":"${point.unit}","startAt":"${point.startAt.toIso8601String()}","endAt":"${point.endAt.toIso8601String()}","recordedAt":"${point.recordedAt.toIso8601String()}","sourceId":"${point.sourceId}","sourceName":"${point.sourceName}","sourceDeviceId":"${point.sourceDeviceId}","recordingMethod":"${point.recordingMethod}","rawPayload":{"sample":true}}',
    recordedAt: point.recordedAt,
    createdAt: point.recordedAt,
  );
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
