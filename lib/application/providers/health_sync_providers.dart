import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/application/providers/body_metrics_providers.dart';
import 'package:forge/application/providers/settings_providers.dart';
import 'package:forge/application/services/health_connect_client.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/health_sync_dao.dart';
import 'package:forge/data/repositories/health_sync_repository_impl.dart';
import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:forge/domain/entities/health_sync_data_point.dart';
import 'package:forge/domain/entities/health_sync_record.dart';
import 'package:forge/domain/entities/health_sync_run_result.dart';
import 'package:forge/domain/repositories/health_sync_repository.dart';
import 'package:forge/features/body_metrics/presentation/controllers/body_progress_controller.dart';

final healthSyncUuidServiceProvider = Provider<UuidService>((ref) {
  return const UuidService();
});

final healthConnectClientProvider = Provider<HealthConnectClient>((ref) {
  return createHealthConnectClient();
});

final healthSyncDaoProvider = Provider<HealthSyncDao>((ref) {
  return HealthSyncDao(ref.watch(appDatabaseProvider));
});

final healthSyncRepositoryProvider = Provider<HealthSyncRepository>((ref) {
  return HealthSyncRepositoryImpl(
    ref.watch(healthSyncDaoProvider),
    client: ref.watch(healthConnectClientProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
    bodyMetricsRepository: ref.watch(bodyMetricsRepositoryProvider),
    unitConverter: ref.watch(bodyMetricsUnitConverterProvider),
    uuidService: ref.watch(healthSyncUuidServiceProvider),
  );
});

final healthSyncConnectionStatusProvider =
    FutureProvider.autoDispose<HealthSyncConnectionStatus>((ref) {
      return ref.watch(healthSyncRepositoryProvider).getConnectionStatus();
    });

final healthSyncRecordsProvider =
    FutureProvider.autoDispose<List<HealthSyncRecord>>((ref) {
      return ref.watch(healthSyncRepositoryProvider).getAll();
    });

final healthSyncLastSyncAtProvider = FutureProvider.autoDispose<DateTime?>((
  ref,
) {
  return ref.watch(healthSyncRepositoryProvider).getLastSyncAt();
});

final healthSyncLastSyncErrorProvider = FutureProvider.autoDispose<String?>((
  ref,
) {
  return ref.watch(healthSyncRepositoryProvider).getLastSyncError();
});

final healthSyncOverviewProvider =
    FutureProvider.autoDispose<HealthSyncOverview>((ref) async {
      final repository = ref.watch(healthSyncRepositoryProvider);
      final status = await repository.getConnectionStatus();
      final records = await repository.getAll();
      final lastSyncAt = await repository.getLastSyncAt();
      final lastSyncError = await repository.getLastSyncError();

      return HealthSyncOverview.fromRecords(
        status: status,
        records: records,
        lastSyncAt: lastSyncAt,
        lastSyncError: lastSyncError,
        now: DateTime.now(),
      );
    });

final healthSyncControllerProvider = Provider<HealthSyncController>((ref) {
  return HealthSyncController(ref);
});

class HealthSyncController {
  HealthSyncController(this._ref);

  final Ref _ref;

  Future<HealthSyncConnectionStatus> requestPermissions() async {
    final status = await _ref
        .read(healthSyncRepositoryProvider)
        .requestPermissions();
    _invalidate();
    return status;
  }

  Future<void> openInstallScreen() async {
    await _ref.read(healthSyncRepositoryProvider).openInstallScreen();
  }

  Future<HealthSyncRunResult> syncNow() async {
    final result = await _ref.read(healthSyncRepositoryProvider).syncNow();
    _invalidate();
    return result;
  }

  void _invalidate() {
    _ref.invalidate(healthSyncConnectionStatusProvider);
    _ref.invalidate(healthSyncRecordsProvider);
    _ref.invalidate(healthSyncLastSyncAtProvider);
    _ref.invalidate(healthSyncLastSyncErrorProvider);
    _ref.invalidate(healthSyncOverviewProvider);
    _ref.invalidate(bodyLogsProvider);
    _ref.invalidate(bodyProgressSummaryProvider);
  }
}

class HealthSyncOverview {
  const HealthSyncOverview({
    required this.status,
    required this.records,
    required this.lastSyncAt,
    required this.lastSyncError,
    required this.totalImportedRecords,
    required this.todaySteps,
    required this.latestHeartRate,
    required this.latestSleepSession,
    required this.latestBodyWeight,
  });

  factory HealthSyncOverview.fromRecords({
    required HealthSyncConnectionStatus status,
    required List<HealthSyncRecord> records,
    required DateTime? lastSyncAt,
    required String? lastSyncError,
    required DateTime now,
  }) {
    final points = records
        .map(_decodeRecord)
        .whereType<HealthSyncDataPoint>()
        .toList(growable: false);

    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    var todaySteps = 0;
    for (final point in points) {
      if (point.type != HealthSyncDataType.steps) {
        continue;
      }
      final overlapsToday =
          point.endAt.isAfter(startOfDay) && point.startAt.isBefore(endOfDay);
      if (!overlapsToday) {
        continue;
      }
      todaySteps += point.numericValue.round();
    }

    return HealthSyncOverview(
      status: status,
      records: records,
      lastSyncAt: lastSyncAt,
      lastSyncError: lastSyncError,
      totalImportedRecords: records.length,
      todaySteps: todaySteps == 0 ? null : todaySteps,
      latestHeartRate: _latestPoint(points, HealthSyncDataType.heartRate),
      latestSleepSession: _latestPoint(points, HealthSyncDataType.sleep),
      latestBodyWeight: _latestPoint(points, HealthSyncDataType.bodyWeight),
    );
  }

  final HealthSyncConnectionStatus status;
  final List<HealthSyncRecord> records;
  final DateTime? lastSyncAt;
  final String? lastSyncError;
  final int totalImportedRecords;
  final int? todaySteps;
  final HealthSyncDataPoint? latestHeartRate;
  final HealthSyncDataPoint? latestSleepSession;
  final HealthSyncDataPoint? latestBodyWeight;

  bool get hasImportedData =>
      todaySteps != null ||
      latestHeartRate != null ||
      latestSleepSession != null ||
      latestBodyWeight != null;

  static HealthSyncDataPoint? _latestPoint(
    List<HealthSyncDataPoint> points,
    HealthSyncDataType type,
  ) {
    final matches = points
        .where((point) => point.type == type)
        .toList(growable: false);
    if (matches.isEmpty) {
      return null;
    }
    return matches.reduce(
      (latest, current) =>
          current.recordedAt.isAfter(latest.recordedAt) ? current : latest,
    );
  }

  static HealthSyncDataPoint? _decodeRecord(HealthSyncRecord record) {
    try {
      return HealthSyncDataPoint.fromJson(
        jsonDecode(record.payloadJson) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }
}
