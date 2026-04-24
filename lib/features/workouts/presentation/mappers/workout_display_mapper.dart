import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_history_item.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/domain/services/workout_metrics_service.dart';
import 'package:forge/features/workouts/presentation/view_models/workout_display_view_models.dart';
import 'package:forge/features/workouts/presentation/widgets/workout_formatters.dart';

class WorkoutDisplayMapper {
  const WorkoutDisplayMapper({required WorkoutMetricsService metrics})
    : _metrics = metrics;

  final WorkoutMetricsService _metrics;

  WorkoutHistoryItemViewModel toHistoryItem(WorkoutHistoryItem item) {
    return WorkoutHistoryItemViewModel(
      title: item.templateName ?? 'Workout Session',
      subtitle:
          '${WorkoutFormatters.shortDateTime(item.startedAt)} - ${item.exerciseCount} exercises - ${item.setCount} sets',
      volumeLabel: WorkoutFormatters.kilograms(item.totalVolumeKilograms),
      exerciseCountLabel: '${item.exerciseCount} exercises',
      setCountLabel: '${item.setCount} sets',
      dateLabel: WorkoutFormatters.shortDateTime(item.startedAt),
    );
  }

  WorkoutSessionOverviewViewModel toSessionOverview(
    WorkoutSessionDetail detail,
  ) {
    return WorkoutSessionOverviewViewModel(
      startedAtLabel: WorkoutFormatters.shortDateTime(detail.session.startedAt),
      durationLabel:
          'Duration: ${WorkoutFormatters.duration(detail.session.startedAt, detail.session.endedAt)}',
      exerciseCountLabel: 'Exercises: ${detail.exercises.length}',
      setCountLabel: 'Sets: ${detail.totalSets}',
      volumeLabel:
          'Volume: ${WorkoutFormatters.kilograms(detail.totalVolumeKilograms)}',
      headerTitle: detail.session.notes?.trim().isNotEmpty ?? false
          ? detail.session.notes!.trim()
          : 'Session Detail',
    );
  }

  WorkoutSetDisplayViewModel toSetDisplay(
    SetEntry setEntry, {
    required int displayIndex,
  }) {
    final estimatedOneRepMaxLabel = WorkoutFormatters.kilograms(
      _metrics.estimateOneRepMax(setEntry),
    );
    final indexLabel = '#$displayIndex';
    final repsLabel = '${setEntry.reps} reps';
    final weightLabel = WorkoutFormatters.weight(setEntry.weight);
    final setTypeLabel = _setTypeLabel(setEntry.setType.name);
    final summaryLabel = '$repsLabel | $weightLabel | $setTypeLabel';
    final metaParts = <String>[
      if (setEntry.rpe != null) 'RPE ${setEntry.rpe!.toStringAsFixed(1)}',
      if (setEntry.restSeconds != null) '${setEntry.restSeconds}s rest',
      if (setEntry.tempo != null && setEntry.tempo!.isNotEmpty) setEntry.tempo!,
    ];
    final metaLabel = metaParts.isEmpty
        ? 'No extra notes'
        : metaParts.join(' - ');

    return WorkoutSetDisplayViewModel(
      indexLabel: indexLabel,
      summaryLabel: summaryLabel,
      estimatedOneRepMaxLabel: estimatedOneRepMaxLabel,
      detailLabel:
          '$indexLabel - ${setEntry.setType.name} - ${setEntry.reps} reps - ${WorkoutFormatters.weight(setEntry.weight)} - e1RM $estimatedOneRepMaxLabel',
      repsLabel: repsLabel,
      weightLabel: weightLabel,
      setTypeLabel: setTypeLabel,
      metaLabel: metaLabel,
    );
  }

  String templateExerciseCountLabel(int exerciseCount) {
    return '$exerciseCount exercises';
  }

  String _setTypeLabel(String raw) {
    switch (raw) {
      case 'warmUp':
        return 'Warm-up';
      case 'drop':
        return 'Drop';
      case 'failure':
        return 'Failure';
      default:
        return 'Normal';
    }
  }
}
