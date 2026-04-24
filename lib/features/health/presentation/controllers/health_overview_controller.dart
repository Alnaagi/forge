import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/health_providers.dart';
import 'package:forge/domain/entities/health_profile.dart';
import 'package:forge/domain/entities/health_status_log.dart';
import 'package:forge/domain/services/health_caution_service.dart';
import 'package:forge/shared/enums/health_entry_type.dart';

final healthProfileProvider = FutureProvider.autoDispose<HealthProfile?>((ref) {
  return ref.watch(healthRepositoryProvider).getHealthProfile();
});

final healthStatusLogsProvider =
    FutureProvider.autoDispose<List<HealthStatusLog>>((ref) {
      return ref.watch(healthRepositoryProvider).getHealthStatusLogs();
    });

final healthOverviewProvider = Provider.autoDispose<HealthOverview>((ref) {
  final profile = ref.watch(healthProfileProvider).valueOrNull;
  final logs = ref.watch(healthStatusLogsProvider).valueOrNull ?? const [];
  final service = ref.watch(healthCautionServiceProvider);
  return HealthOverview.fromData(
    profile: profile,
    logs: logs,
    cautionService: service,
  );
});

final healthTrackingControllerProvider = Provider<HealthTrackingController>((
  ref,
) {
  return HealthTrackingController(ref);
});

class HealthTrackingController {
  HealthTrackingController(this._ref);

  final Ref _ref;

  Future<void> saveHealthProfile({
    HealthProfile? existingProfile,
    required String healthConditions,
    required String medications,
    required String allergies,
    String? notes,
    required int checkInCadenceHours,
  }) async {
    final repository = _ref.read(healthRepositoryProvider);
    final uuid = _ref.read(healthUuidServiceProvider);
    final now = DateTime.now();

    final profile = HealthProfile(
      id: existingProfile?.id ?? 'health-profile-${uuid.next()}',
      healthConditions: _splitList(healthConditions),
      medications: _splitList(medications),
      allergies: _splitList(allergies),
      notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
      checkInCadenceHours: checkInCadenceHours,
      createdAt: existingProfile?.createdAt ?? now,
      updatedAt: now,
    );

    await repository.saveHealthProfile(profile);
    _invalidate();
  }

  Future<void> saveHealthLog({
    HealthStatusLog? existingLog,
    required HealthEntryType type,
    required String title,
    required int severity,
    DateTime? loggedAt,
    DateTime? startedAt,
    DateTime? resolvedAt,
    int? energyLevel,
    String? bodyArea,
    String? symptomTags,
    String? possibleTrigger,
    String? notes,
  }) async {
    if (title.trim().isEmpty) {
      throw StateError('Enter a health status title.');
    }
    if (severity < 1 || severity > 5) {
      throw StateError('Severity must be between 1 and 5.');
    }
    if (energyLevel != null && (energyLevel < 1 || energyLevel > 5)) {
      throw StateError('Energy must be between 1 and 5.');
    }
    if (resolvedAt != null &&
        startedAt != null &&
        resolvedAt.isBefore(startedAt)) {
      throw StateError('Resolved time cannot be before the start time.');
    }

    final repository = _ref.read(healthRepositoryProvider);
    final uuid = _ref.read(healthUuidServiceProvider);
    final now = DateTime.now();
    final log = HealthStatusLog(
      id: existingLog?.id ?? 'health-log-${uuid.next()}',
      type: type,
      title: title.trim(),
      severity: severity,
      loggedAt: loggedAt ?? existingLog?.loggedAt ?? now,
      startedAt: startedAt,
      resolvedAt: resolvedAt,
      energyLevel: energyLevel,
      bodyArea: bodyArea?.trim().isEmpty ?? true ? null : bodyArea?.trim(),
      symptomTags: _splitList(symptomTags ?? ''),
      possibleTrigger: possibleTrigger?.trim().isEmpty ?? true
          ? null
          : possibleTrigger?.trim(),
      notes: notes?.trim().isEmpty ?? true ? null : notes?.trim(),
      createdAt: existingLog?.createdAt ?? now,
      updatedAt: now,
    );
    await repository.saveHealthStatusLog(log);
    _invalidate();
  }

  Future<void> deleteHealthLog(String logId) async {
    await _ref.read(healthRepositoryProvider).deleteHealthStatusLog(logId);
    _invalidate();
  }

  void _invalidate() {
    _ref.invalidate(healthProfileProvider);
    _ref.invalidate(healthStatusLogsProvider);
  }
}

class HealthOverview {
  const HealthOverview({
    required this.profile,
    required this.logs,
    required this.activeLogs,
    required this.generalAdvice,
    required this.commonTriggers,
    required this.commonSymptoms,
  });

  factory HealthOverview.fromData({
    required HealthProfile? profile,
    required List<HealthStatusLog> logs,
    required HealthCautionService cautionService,
  }) {
    final activeLogs = logs
        .where((log) => log.isActive)
        .toList(growable: false);
    return HealthOverview(
      profile: profile,
      logs: logs,
      activeLogs: activeLogs,
      generalAdvice: cautionService.buildGeneralAdvice(
        profile: profile,
        activeLogs: activeLogs,
      ),
      commonTriggers: _rankSignals(
        logs.map((log) => log.possibleTrigger).whereType<String>(),
      ),
      commonSymptoms: _rankSignals(
        logs.expand((log) => [log.title, ...log.symptomTags]),
      ),
    );
  }

  final HealthProfile? profile;
  final List<HealthStatusLog> logs;
  final List<HealthStatusLog> activeLogs;
  final List<String> generalAdvice;
  final List<HealthPatternCount> commonTriggers;
  final List<HealthPatternCount> commonSymptoms;
}

class HealthPatternCount {
  const HealthPatternCount({required this.label, required this.count});

  final String label;
  final int count;
}

List<HealthPatternCount> _rankSignals(Iterable<String> rawValues) {
  final counts = <String, int>{};
  for (final rawValue in rawValues) {
    final normalized = rawValue.trim();
    if (normalized.isEmpty) {
      continue;
    }
    counts.update(normalized, (count) => count + 1, ifAbsent: () => 1);
  }

  final items =
      counts.entries
          .map(
            (entry) => HealthPatternCount(label: entry.key, count: entry.value),
          )
          .toList(growable: false)
        ..sort((left, right) => right.count.compareTo(left.count));

  if (items.length <= 5) {
    return items;
  }
  return items.take(5).toList(growable: false);
}

List<String> _splitList(String rawValue) {
  return rawValue
      .split(RegExp(r'[\n,]'))
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList(growable: false);
}
