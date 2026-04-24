import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/body_metrics_providers.dart';
import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/value_objects/trend_point.dart';
import 'package:forge/shared/value_objects/measurement_value.dart';
import 'package:forge/shared/value_objects/percentage_value.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

final bodyLogsProvider = FutureProvider.autoDispose<List<BodyLog>>((ref) async {
  return ref.watch(bodyMetricsRepositoryProvider).getBodyLogs();
});

final bodyProgressSummaryProvider = Provider.autoDispose<BodyProgressSummary>((
  ref,
) {
  final logs = ref.watch(bodyLogsProvider).valueOrNull ?? const <BodyLog>[];
  return BodyProgressSummary.fromLogs(logs);
});

final bodyMetricsControllerProvider = Provider<BodyProgressController>((ref) {
  return BodyProgressController(ref);
});

class BodyProgressController {
  BodyProgressController(this._ref);

  final Ref _ref;

  Future<void> saveBodyLog({
    BodyLog? existingLog,
    double? weightValue,
    WeightUnit? weightUnit,
    double? bodyFatPercentage,
    double? waistValue,
    BodyMetricUnit? waistUnit,
    String? notes,
    DateTime? loggedAt,
  }) async {
    if (weightValue == null &&
        bodyFatPercentage == null &&
        waistValue == null) {
      throw StateError('Enter at least one body metric.');
    }
    if (weightValue != null && (weightUnit == null || weightValue <= 0)) {
      throw StateError('Enter a valid bodyweight.');
    }
    if (waistValue != null && (waistUnit == null || waistValue <= 0)) {
      throw StateError('Enter a valid waist measurement.');
    }
    if (bodyFatPercentage != null &&
        (bodyFatPercentage < 0 || bodyFatPercentage > 100)) {
      throw StateError('Body fat percentage must be between 0 and 100.');
    }

    final repository = _ref.read(bodyMetricsRepositoryProvider);
    final uuid = _ref.read(bodyMetricsUuidServiceProvider);
    final unitConverter = _ref.read(bodyMetricsUnitConverterProvider);
    final now = DateTime.now();

    final bodyLog = BodyLog(
      id: existingLog?.id ?? 'body-log-${uuid.next()}',
      loggedAt: loggedAt ?? existingLog?.loggedAt ?? now,
      bodyWeight: weightValue == null
          ? null
          : WeightValue(
              originalValue: weightValue,
              originalUnit: weightUnit!,
              canonicalKilograms: unitConverter.toKilograms(
                weightValue,
                weightUnit,
              ),
            ),
      bodyFatPercentage: bodyFatPercentage == null
          ? null
          : PercentageValue(value: bodyFatPercentage),
      waist: waistValue == null
          ? null
          : MeasurementValue(
              originalValue: waistValue,
              originalUnit: waistUnit!,
              canonicalCentimeters: unitConverter.toCentimeters(
                waistValue,
                waistUnit,
              ),
            ),
      notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
      createdAt: existingLog?.createdAt ?? now,
      updatedAt: now,
    );

    await repository.saveBodyLog(bodyLog);
    _ref.invalidate(bodyLogsProvider);
  }

  Future<void> deleteBodyLog(String bodyLogId) async {
    await _ref.read(bodyMetricsRepositoryProvider).deleteBodyLog(bodyLogId);
    _ref.invalidate(bodyLogsProvider);
  }
}

class BodyProgressSummary {
  const BodyProgressSummary({
    required this.totalLogs,
    required this.latestLog,
    required this.latestWeight,
    required this.weightDeltaKilograms,
    required this.latestWaist,
    required this.waistDeltaCentimeters,
    required this.latestBodyFatPercentage,
    required this.bodyFatDeltaPercentage,
    required this.weightTrend,
    required this.waistTrend,
    required this.bodyFatTrend,
  });

  factory BodyProgressSummary.fromLogs(List<BodyLog> logs) {
    final latest = logs.isEmpty ? null : logs.first;
    final previousWeight = _firstPrevious(
      logs,
      selector: (log) => log.bodyWeight?.canonicalKilograms,
    );
    final previousWaist = _firstPrevious(
      logs,
      selector: (log) => log.waist?.canonicalCentimeters,
    );
    final previousBodyFat = _firstPrevious(
      logs,
      selector: (log) => log.bodyFatPercentage?.value,
    );

    return BodyProgressSummary(
      totalLogs: logs.length,
      latestLog: latest,
      latestWeight: latest?.bodyWeight?.canonicalKilograms,
      weightDeltaKilograms:
          latest?.bodyWeight?.canonicalKilograms == null ||
              previousWeight == null
          ? null
          : latest!.bodyWeight!.canonicalKilograms - previousWeight,
      latestWaist: latest?.waist?.canonicalCentimeters,
      waistDeltaCentimeters:
          latest?.waist?.canonicalCentimeters == null || previousWaist == null
          ? null
          : latest!.waist!.canonicalCentimeters - previousWaist,
      latestBodyFatPercentage: latest?.bodyFatPercentage?.value,
      bodyFatDeltaPercentage:
          latest?.bodyFatPercentage?.value == null || previousBodyFat == null
          ? null
          : latest!.bodyFatPercentage!.value - previousBodyFat,
      weightTrend: _buildTrend(
        logs,
        selector: (log) => log.bodyWeight?.canonicalKilograms,
      ),
      waistTrend: _buildTrend(
        logs,
        selector: (log) => log.waist?.canonicalCentimeters,
      ),
      bodyFatTrend: _buildTrend(
        logs,
        selector: (log) => log.bodyFatPercentage?.value,
      ),
    );
  }

  final int totalLogs;
  final BodyLog? latestLog;
  final double? latestWeight;
  final double? weightDeltaKilograms;
  final double? latestWaist;
  final double? waistDeltaCentimeters;
  final double? latestBodyFatPercentage;
  final double? bodyFatDeltaPercentage;
  final List<TrendPoint> weightTrend;
  final List<TrendPoint> waistTrend;
  final List<TrendPoint> bodyFatTrend;

  static double? _firstPrevious(
    List<BodyLog> logs, {
    required double? Function(BodyLog log) selector,
  }) {
    if (logs.length < 2) {
      return null;
    }
    for (final log in logs.skip(1)) {
      final value = selector(log);
      if (value != null) {
        return value;
      }
    }
    return null;
  }

  static List<TrendPoint> _buildTrend(
    List<BodyLog> logs, {
    required double? Function(BodyLog log) selector,
  }) {
    final series = logs.reversed
        .map((log) {
          final value = selector(log);
          if (value == null) {
            return null;
          }
          return TrendPoint(label: _shortLabel(log.loggedAt), value: value);
        })
        .whereType<TrendPoint>()
        .toList(growable: false);

    if (series.length <= 6) {
      return series;
    }
    return series.sublist(series.length - 6);
  }

  static String _shortLabel(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${local.month}/${local.day}';
  }
}
