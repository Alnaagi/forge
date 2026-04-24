import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/body_metrics_providers.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/domain/entities/workout_history_item.dart';
import 'package:forge/shared/value_objects/trend_point.dart';

final analyticsOverviewProvider = FutureProvider.autoDispose<AnalyticsOverview>(
  (ref) async {
    final bodyLogs = await ref
        .watch(bodyMetricsRepositoryProvider)
        .getBodyLogs();
    final workoutHistory = await ref
        .watch(workoutRepositoryProvider)
        .getHistoryItems();
    return AnalyticsOverview.fromData(
      bodyLogs: bodyLogs,
      workoutHistory: workoutHistory,
    );
  },
);

class AnalyticsOverview {
  const AnalyticsOverview({required this.body, required this.workouts});

  factory AnalyticsOverview.fromData({
    required List<BodyLog> bodyLogs,
    required List<WorkoutHistoryItem> workoutHistory,
  }) {
    return AnalyticsOverview(
      body: BodyAnalyticsSummary.fromLogs(bodyLogs),
      workouts: WorkoutAnalyticsSummary.fromHistory(workoutHistory),
    );
  }

  final BodyAnalyticsSummary body;
  final WorkoutAnalyticsSummary workouts;
}

class BodyAnalyticsSummary {
  const BodyAnalyticsSummary({
    required this.checkInCount,
    required this.latestWeightKilograms,
    required this.weightDeltaKilograms,
    required this.latestWaistCentimeters,
    required this.waistDeltaCentimeters,
    required this.latestBodyFatPercentage,
    required this.bodyFatDeltaPercentage,
    required this.weightTrend,
  });

  factory BodyAnalyticsSummary.fromLogs(List<BodyLog> logs) {
    final latest = logs.isEmpty ? null : logs.first;
    final previousWeight = _previousValue(
      logs,
      selector: (log) => log.bodyWeight?.canonicalKilograms,
    );
    final previousWaist = _previousValue(
      logs,
      selector: (log) => log.waist?.canonicalCentimeters,
    );
    final previousBodyFat = _previousValue(
      logs,
      selector: (log) => log.bodyFatPercentage?.value,
    );

    return BodyAnalyticsSummary(
      checkInCount: logs.length,
      latestWeightKilograms: latest?.bodyWeight?.canonicalKilograms,
      weightDeltaKilograms:
          latest?.bodyWeight?.canonicalKilograms == null ||
              previousWeight == null
          ? null
          : latest!.bodyWeight!.canonicalKilograms - previousWeight,
      latestWaistCentimeters: latest?.waist?.canonicalCentimeters,
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
    );
  }

  final int checkInCount;
  final double? latestWeightKilograms;
  final double? weightDeltaKilograms;
  final double? latestWaistCentimeters;
  final double? waistDeltaCentimeters;
  final double? latestBodyFatPercentage;
  final double? bodyFatDeltaPercentage;
  final List<TrendPoint> weightTrend;

  static double? _previousValue(
    List<BodyLog> logs, {
    required double? Function(BodyLog log) selector,
  }) {
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

class WorkoutAnalyticsSummary {
  const WorkoutAnalyticsSummary({
    required this.totalSessions,
    required this.totalSets,
    required this.totalVolumeKilograms,
    required this.sessionsLast30Days,
    required this.volumeLast30Days,
    required this.volumeTrend,
  });

  factory WorkoutAnalyticsSummary.fromHistory(List<WorkoutHistoryItem> items) {
    final since = DateTime.now().subtract(const Duration(days: 30));
    final last30Days = items
        .where((item) => item.startedAt.isAfter(since))
        .toList(growable: false);

    return WorkoutAnalyticsSummary(
      totalSessions: items.length,
      totalSets: items.fold<int>(0, (sum, item) => sum + item.setCount),
      totalVolumeKilograms: items.fold<double>(
        0,
        (sum, item) => sum + item.totalVolumeKilograms,
      ),
      sessionsLast30Days: last30Days.length,
      volumeLast30Days: last30Days.fold<double>(
        0,
        (sum, item) => sum + item.totalVolumeKilograms,
      ),
      volumeTrend: _buildVolumeTrend(items),
    );
  }

  final int totalSessions;
  final int totalSets;
  final double totalVolumeKilograms;
  final int sessionsLast30Days;
  final double volumeLast30Days;
  final List<TrendPoint> volumeTrend;

  static List<TrendPoint> _buildVolumeTrend(List<WorkoutHistoryItem> items) {
    final ordered = items.reversed.take(6).toList(growable: false).reversed;
    return ordered
        .map(
          (item) => TrendPoint(
            label: _shortLabel(item.startedAt),
            value: item.totalVolumeKilograms,
          ),
        )
        .toList(growable: false);
  }

  static String _shortLabel(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${local.month}/${local.day}';
  }
}
