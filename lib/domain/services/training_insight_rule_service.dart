import 'dart:convert';

import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_logged_exercise.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/shared/enums/insight_category.dart';
import 'package:forge/shared/enums/insight_severity.dart';
import 'package:forge/shared/enums/set_type.dart';

import 'e1rm_service.dart';

class TrainingInsightRuleService {
  const TrainingInsightRuleService({
    E1rmService e1rmService = const E1rmService(),
  }) : _e1rmService = e1rmService;

  final E1rmService _e1rmService;

  List<TrainingInsightSignal> evaluate({
    required DateTime now,
    required List<WorkoutSessionDetail> recentSessions,
  }) {
    final completedSessions =
        recentSessions
            .where((detail) => detail.session.endedAt != null)
            .toList(growable: false)
          ..sort(
            (left, right) =>
                right.session.startedAt.compareTo(left.session.startedAt),
          );

    final signals = <TrainingInsightSignal>[];

    final plateauSignal = _buildPlateauSignal(
      now: now,
      sessions: completedSessions,
    );
    if (plateauSignal != null) {
      signals.add(plateauSignal);
    }

    final skippedMuscleGroupSignal = _buildSkippedMuscleGroupSignal(
      now: now,
      sessions: completedSessions,
    );
    if (skippedMuscleGroupSignal != null) {
      signals.add(skippedMuscleGroupSignal);
    }

    final deloadSignal = _buildDeloadSignal(
      now: now,
      sessions: completedSessions,
    );
    if (deloadSignal != null) {
      signals.add(deloadSignal);
    }

    return signals;
  }

  TrainingInsightSignal? _buildPlateauSignal({
    required DateTime now,
    required List<WorkoutSessionDetail> sessions,
  }) {
    final cutoff = now.subtract(const Duration(days: 42));
    final exposuresByExercise = <String, List<_ExerciseExposure>>{};

    for (final session in sessions) {
      if (session.session.startedAt.isBefore(cutoff)) {
        continue;
      }

      for (final loggedExercise in session.exercises) {
        final bestEstimate = _bestEstimatedOneRepMax(loggedExercise);
        if (bestEstimate <= 0) {
          continue;
        }

        exposuresByExercise
            .putIfAbsent(
              loggedExercise.exercise.id,
              () => <_ExerciseExposure>[],
            )
            .add(
              _ExerciseExposure(
                exerciseName: loggedExercise.exercise.name,
                loggedAt: session.session.startedAt,
                estimatedOneRepMaxKilograms: bestEstimate,
              ),
            );
      }
    }

    _PlateauCandidate? bestCandidate;

    for (final exposures in exposuresByExercise.values) {
      exposures.sort((left, right) => right.loggedAt.compareTo(left.loggedAt));
      if (exposures.length < 3) {
        continue;
      }

      final recentThree = exposures.take(3).toList(growable: false);
      final oldestRecent = recentThree.last.loggedAt;
      final newestRecent = recentThree.first.loggedAt;
      final daySpan = newestRecent.difference(oldestRecent).inDays;
      if (daySpan > 28) {
        continue;
      }

      final estimates = recentThree
          .map((exposure) => exposure.estimatedOneRepMaxKilograms)
          .toList(growable: false);
      final highest = estimates.reduce(
        (left, right) => left > right ? left : right,
      );
      final lowest = estimates.reduce(
        (left, right) => left < right ? left : right,
      );
      final average =
          estimates.reduce((left, right) => left + right) / estimates.length;
      if (average <= 0) {
        continue;
      }

      final spreadRatio = (highest - lowest) / average;
      if (spreadRatio > 0.02) {
        continue;
      }

      final candidate = _PlateauCandidate(
        exerciseName: recentThree.first.exerciseName,
        recentSessionCount: recentThree.length,
        lowestEstimateKilograms: lowest,
        highestEstimateKilograms: highest,
        spreadRatio: spreadRatio,
      );

      if (bestCandidate == null ||
          candidate.spreadRatio < bestCandidate.spreadRatio) {
        bestCandidate = candidate;
      }
    }

    if (bestCandidate == null) {
      return null;
    }

    return TrainingInsightSignal(
      id: 'insight-training-plateau',
      category: InsightCategory.training,
      severity: InsightSeverity.medium,
      title: 'Strength output looks flat on one lift',
      shortMessage:
          '${bestCandidate.exerciseName} has stayed in nearly the same estimated strength band across the last ${bestCandidate.recentSessionCount} exposures.',
      fullExplanation:
          'Forge found repeated exposures for the same exercise where the estimated one-rep max has stayed tightly clustered instead of moving up. That does not guarantee a true plateau, but it is a clean signal that load, reps, recovery, or exercise variation may need a small adjustment.',
      evidenceJson: jsonEncode({
        'exerciseName': bestCandidate.exerciseName,
        'recentSessionCount': bestCandidate.recentSessionCount,
        'lowestEstimatedOneRepMaxKg': bestCandidate.lowestEstimateKilograms
            .toStringAsFixed(1),
        'highestEstimatedOneRepMaxKg': bestCandidate.highestEstimateKilograms
            .toStringAsFixed(1),
        'spreadPercent': (bestCandidate.spreadRatio * 100).toStringAsFixed(1),
      }),
      confidence: 0.87,
      suggestedAction:
          'Keep the movement, but change one lever next block: add reps, add a small load jump, or reduce fatigue before the top set so progress can restart.',
    );
  }

  TrainingInsightSignal? _buildSkippedMuscleGroupSignal({
    required DateTime now,
    required List<WorkoutSessionDetail> sessions,
  }) {
    final cutoff = now.subtract(const Duration(days: 42));
    final recentTrainingExists = sessions.any(
      (session) => !session.session.startedAt.isBefore(
        now.subtract(const Duration(days: 7)),
      ),
    );
    if (!recentTrainingExists) {
      return null;
    }

    final statsByGroup = <String, _MuscleGroupStats>{};
    for (final session in sessions) {
      if (session.session.startedAt.isBefore(cutoff)) {
        continue;
      }

      final groupsInSession = session.exercises
          .map((exercise) => exercise.exercise.primaryMuscleGroup.trim())
          .where((group) => group.isNotEmpty)
          .map((group) => group.toLowerCase())
          .toSet();

      for (final group in groupsInSession) {
        final existing = statsByGroup[group];
        statsByGroup[group] = _MuscleGroupStats(
          label: _titleCase(group),
          sessionCount: (existing?.sessionCount ?? 0) + 1,
          lastTrainedAt:
              existing == null ||
                  session.session.startedAt.isAfter(existing.lastTrainedAt)
              ? session.session.startedAt
              : existing.lastTrainedAt,
        );
      }
    }

    final candidates =
        statsByGroup.values
            .where((stats) {
              final daysSinceLast = now.difference(stats.lastTrainedAt).inDays;
              return stats.sessionCount >= 2 && daysSinceLast >= 14;
            })
            .toList(growable: false)
          ..sort(
            (left, right) => now
                .difference(right.lastTrainedAt)
                .inDays
                .compareTo(now.difference(left.lastTrainedAt).inDays),
          );

    if (candidates.isEmpty) {
      return null;
    }

    final candidate = candidates.first;
    final daysSinceLast = now.difference(candidate.lastTrainedAt).inDays;

    return TrainingInsightSignal(
      id: 'insight-skipped-muscle-group',
      category: InsightCategory.consistency,
      severity: daysSinceLast >= 21
          ? InsightSeverity.medium
          : InsightSeverity.low,
      title: 'One muscle group is slipping out of the rotation',
      shortMessage:
          '${candidate.label} has not been trained for $daysSinceLast days even though other sessions are still being logged.',
      fullExplanation:
          'Forge compared your recent training sessions by primary muscle group. One group showed up enough to count as part of your rotation, but it has now gone quiet while training continued elsewhere. That kind of drift can turn into an avoidable weak point over time.',
      evidenceJson: jsonEncode({
        'muscleGroup': candidate.label,
        'daysSinceLastTraining': daysSinceLast,
        'recentSessionCountForGroup': candidate.sessionCount,
      }),
      confidence: 0.9,
      suggestedAction:
          'Bring ${candidate.label.toLowerCase()} back into the next few sessions, even with a small amount of work, so coverage stays balanced.',
    );
  }

  TrainingInsightSignal? _buildDeloadSignal({
    required DateTime now,
    required List<WorkoutSessionDetail> sessions,
  }) {
    final cutoff = now.subtract(const Duration(days: 7));
    final recentSessions = sessions
        .where((session) => !session.session.startedAt.isBefore(cutoff))
        .toList(growable: false);

    if (recentSessions.length < 4) {
      return null;
    }

    final totalSets = recentSessions.fold<int>(
      0,
      (sum, session) => sum + session.totalSets,
    );
    final totalVolume = recentSessions.fold<double>(
      0,
      (sum, session) => sum + session.totalVolumeKilograms,
    );
    final hardSessions = recentSessions.where((session) {
      return session.totalSets >= 18 || session.totalVolumeKilograms >= 6000;
    }).length;

    if (totalSets < 72 && hardSessions < 4) {
      return null;
    }

    final severity = totalSets >= 90 || totalVolume >= 30000
        ? InsightSeverity.high
        : InsightSeverity.medium;

    return TrainingInsightSignal(
      id: 'insight-deload-trigger',
      category: InsightCategory.recovery,
      severity: severity,
      title: 'Recent training load is stacking up',
      shortMessage:
          '${recentSessions.length} sessions, $totalSets sets, and ${totalVolume.toStringAsFixed(0)} kg of logged volume landed inside the last 7 days.',
      fullExplanation:
          'Forge is flagging a possible deload or recovery pivot because session density and workload have stacked into a short window. That is not automatically bad, but it is a clean point to ask whether fatigue is still productive or whether performance would benefit from backing off briefly.',
      evidenceJson: jsonEncode({
        'recentSessionCount': recentSessions.length,
        'totalSetsLast7Days': totalSets,
        'totalVolumeKilogramsLast7Days': totalVolume.toStringAsFixed(0),
        'hardSessionCount': hardSessions,
      }),
      confidence: 0.84,
      suggestedAction:
          'Consider one lighter session, fewer top sets, or a short deload block if readiness feels blunt instead of sharp.',
    );
  }

  double _bestEstimatedOneRepMax(WorkoutLoggedExercise exercise) {
    return exercise.sets
        .where(_isPlateauEligibleSet)
        .map(_estimateOneRepMax)
        .fold<double>(0, (best, current) => current > best ? current : best);
  }

  bool _isPlateauEligibleSet(SetEntry setEntry) {
    return setEntry.setType == SetType.normal &&
        (setEntry.weight?.canonicalKilograms ?? 0) > 0 &&
        setEntry.reps > 0;
  }

  double _estimateOneRepMax(SetEntry setEntry) {
    final kilograms = setEntry.weight?.canonicalKilograms ?? 0;
    if (kilograms <= 0) {
      return 0;
    }
    return _e1rmService.estimate(
      weightKilograms: kilograms,
      reps: setEntry.reps,
    );
  }
}

class TrainingInsightSignal {
  const TrainingInsightSignal({
    required this.id,
    required this.category,
    required this.severity,
    required this.title,
    required this.shortMessage,
    required this.fullExplanation,
    required this.evidenceJson,
    required this.confidence,
    required this.suggestedAction,
  });

  final String id;
  final InsightCategory category;
  final InsightSeverity severity;
  final String title;
  final String shortMessage;
  final String fullExplanation;
  final String evidenceJson;
  final double confidence;
  final String suggestedAction;
}

class _ExerciseExposure {
  const _ExerciseExposure({
    required this.exerciseName,
    required this.loggedAt,
    required this.estimatedOneRepMaxKilograms,
  });

  final String exerciseName;
  final DateTime loggedAt;
  final double estimatedOneRepMaxKilograms;
}

class _PlateauCandidate {
  const _PlateauCandidate({
    required this.exerciseName,
    required this.recentSessionCount,
    required this.lowestEstimateKilograms,
    required this.highestEstimateKilograms,
    required this.spreadRatio,
  });

  final String exerciseName;
  final int recentSessionCount;
  final double lowestEstimateKilograms;
  final double highestEstimateKilograms;
  final double spreadRatio;
}

class _MuscleGroupStats {
  const _MuscleGroupStats({
    required this.label,
    required this.sessionCount,
    required this.lastTrainedAt,
  });

  final String label;
  final int sessionCount;
  final DateTime lastTrainedAt;
}

String _titleCase(String raw) {
  final words = raw.split(RegExp(r'\s+')).where((word) => word.isNotEmpty);
  return words
      .map(
        (word) => '${word.substring(0, 1).toUpperCase()}${word.substring(1)}',
      )
      .join(' ');
}
