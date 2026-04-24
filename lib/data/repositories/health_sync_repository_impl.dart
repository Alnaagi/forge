import 'dart:convert';

import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/application/services/health_connect_client.dart';
import 'package:forge/data/local/db/daos/health_sync_dao.dart';
import 'package:forge/data/local/db/mappers/health_sync_mapper.dart';
import 'package:forge/domain/entities/app_setting.dart';
import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:forge/domain/entities/health_sync_data_point.dart';
import 'package:forge/domain/entities/health_sync_record.dart';
import 'package:forge/domain/entities/health_sync_run_result.dart';
import 'package:forge/domain/repositories/body_metrics_repository.dart';
import 'package:forge/domain/repositories/health_sync_repository.dart';
import 'package:forge/domain/repositories/settings_repository.dart';
import 'package:forge/shared/enums/sync_source.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

const _healthConnectLastSyncAtKey = 'health_connect_last_sync_at';
const _healthConnectLastSyncErrorKey = 'health_connect_last_sync_error';

class HealthSyncRepositoryImpl implements HealthSyncRepository {
  HealthSyncRepositoryImpl(
    this._dao, {
    required HealthConnectClient client,
    required SettingsRepository settingsRepository,
    required BodyMetricsRepository bodyMetricsRepository,
    required UnitConverter unitConverter,
    required UuidService uuidService,
    DateTime Function()? clock,
  }) : _client = client,
       _settingsRepository = settingsRepository,
       _bodyMetricsRepository = bodyMetricsRepository,
       _unitConverter = unitConverter,
       _uuidService = uuidService,
       _clock = clock ?? DateTime.now;

  final HealthSyncDao _dao;
  final HealthConnectClient _client;
  final SettingsRepository _settingsRepository;
  final BodyMetricsRepository _bodyMetricsRepository;
  final UnitConverter _unitConverter;
  final UuidService _uuidService;
  final DateTime Function() _clock;

  @override
  Future<List<HealthSyncRecord>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<void> upsertRecords(List<HealthSyncRecord> records) {
    return _dao.upsertMany(
      records.map((record) => record.toCompanion()).toList(growable: false),
    );
  }

  @override
  Future<HealthSyncConnectionStatus> getConnectionStatus() {
    return _client.getStatus();
  }

  @override
  Future<HealthSyncConnectionStatus> requestPermissions() {
    return _client.requestPermissions();
  }

  @override
  Future<void> openInstallScreen() {
    return _client.openInstallScreen();
  }

  @override
  Future<DateTime?> getLastSyncAt() async {
    final setting = await _settingsRepository.getByKey(
      _healthConnectLastSyncAtKey,
    );
    final rawValue = setting?.value.trim();
    if (rawValue == null || rawValue.isEmpty) {
      return null;
    }
    return DateTime.tryParse(rawValue);
  }

  @override
  Future<String?> getLastSyncError() async {
    final setting = await _settingsRepository.getByKey(
      _healthConnectLastSyncErrorKey,
    );
    final value = setting?.value.trim();
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }

  @override
  Future<HealthSyncRunResult> syncNow() async {
    final status = await _client.getStatus();
    if (!status.canSync) {
      throw StateError(_statusFailureMessage(status));
    }

    final syncFinishedAt = _clock();
    final lastSyncAt = await getLastSyncAt();
    final syncStart = _resolveSyncStart(lastSyncAt, syncFinishedAt);

    try {
      final importedPoints = await _client.readData(
        startTime: syncStart,
        endTime: syncFinishedAt,
      );
      final existingRecords = await getAll();
      final existingKeys = existingRecords
          .map(
            (record) =>
                '${record.source.name}|${record.recordType}|${record.externalId ?? ''}',
          )
          .toSet();
      final records = importedPoints
          .map((point) => _toHealthSyncRecord(point, syncFinishedAt))
          .toList(growable: false);
      final newRecordCount = records
          .where(
            (record) => !existingKeys.contains(
              '${record.source.name}|${record.recordType}|${record.externalId ?? ''}',
            ),
          )
          .length;
      await upsertRecords(records);

      final importedBodyWeights = await _mirrorBodyWeights(importedPoints);
      await _saveSetting(
        _healthConnectLastSyncAtKey,
        syncFinishedAt.toIso8601String(),
      );
      await _saveSetting(_healthConnectLastSyncErrorKey, '');

      return HealthSyncRunResult(
        importedRecordCount: newRecordCount,
        importedBodyWeightCount: importedBodyWeights,
        syncedAt: syncFinishedAt,
      );
    } catch (error) {
      await _saveSetting(_healthConnectLastSyncErrorKey, error.toString());
      rethrow;
    }
  }

  DateTime _resolveSyncStart(DateTime? lastSyncAt, DateTime now) {
    if (lastSyncAt == null) {
      return now.subtract(const Duration(days: 30));
    }
    return lastSyncAt.subtract(const Duration(hours: 12));
  }

  HealthSyncRecord _toHealthSyncRecord(
    HealthSyncDataPoint point,
    DateTime createdAt,
  ) {
    final recordId =
        'health-connect-${point.type.storageKey}-${point.externalId}';
    return HealthSyncRecord(
      id: recordId,
      source: SyncSource.healthConnect,
      recordType: point.type.storageKey,
      externalId: point.externalId,
      payloadJson: jsonEncode(point.toJson()),
      recordedAt: point.recordedAt,
      createdAt: createdAt,
    );
  }

  Future<int> _mirrorBodyWeights(
    List<HealthSyncDataPoint> importedPoints,
  ) async {
    final weightPoints = importedPoints
        .where((point) => point.type == HealthSyncDataType.bodyWeight)
        .toList(growable: false);
    if (weightPoints.isEmpty) {
      return 0;
    }

    final existingLogs = [...await _bodyMetricsRepository.getBodyLogs()];
    var importedCount = 0;

    for (final point in weightPoints) {
      if (_hasMatchingWeightLog(existingLogs, point)) {
        continue;
      }

      final bodyLog = BodyLog(
        id: 'body-log-health-connect-${_uuidService.next()}',
        loggedAt: point.recordedAt,
        bodyWeight: WeightValue(
          originalValue: point.numericValue,
          originalUnit: WeightUnit.kilograms,
          canonicalKilograms: _unitConverter.toKilograms(
            point.numericValue,
            WeightUnit.kilograms,
          ),
        ),
        bodyFatPercentage: null,
        waist: null,
        notes: 'Imported from Health Connect',
        createdAt: _clock(),
        updatedAt: _clock(),
      );
      await _bodyMetricsRepository.saveBodyLog(bodyLog);
      existingLogs.insert(0, bodyLog);
      importedCount += 1;
    }

    return importedCount;
  }

  bool _hasMatchingWeightLog(
    List<BodyLog> existingLogs,
    HealthSyncDataPoint point,
  ) {
    for (final log in existingLogs) {
      final bodyWeight = log.bodyWeight;
      if (bodyWeight == null) {
        continue;
      }
      final isSameMoment =
          log.loggedAt.toUtc().millisecondsSinceEpoch ==
          point.recordedAt.toUtc().millisecondsSinceEpoch;
      final isSameWeight =
          (bodyWeight.canonicalKilograms - point.numericValue).abs() < 0.001;
      if (isSameMoment && isSameWeight) {
        return true;
      }
    }
    return false;
  }

  String _statusFailureMessage(HealthSyncConnectionStatus status) {
    return switch (status.availability) {
      HealthSyncAvailability.unsupportedPlatform =>
        'Health Connect is only available on supported Android devices.',
      HealthSyncAvailability.unavailable =>
        'Health Connect is not available on this device yet.',
      HealthSyncAvailability.providerUpdateRequired =>
        'Health Connect needs to be installed or updated before syncing.',
      HealthSyncAvailability.available
          when !status.readPermissionsGranted && !status.stepPermissionsGranted =>
        'Grant Health Connect permissions before syncing.',
      HealthSyncAvailability.available =>
        'Health Connect is not ready to sync yet.',
    };
  }

  Future<void> _saveSetting(String key, String value) {
    return _settingsRepository.save(
      AppSetting(key: key, value: value, updatedAt: _clock()),
    );
  }
}
