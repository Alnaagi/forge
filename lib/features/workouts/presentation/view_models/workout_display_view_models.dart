class WorkoutHistoryItemViewModel {
  const WorkoutHistoryItemViewModel({
    required this.title,
    required this.subtitle,
    required this.volumeLabel,
    required this.exerciseCountLabel,
    required this.setCountLabel,
    required this.dateLabel,
  });

  final String title;
  final String subtitle;
  final String volumeLabel;
  final String exerciseCountLabel;
  final String setCountLabel;
  final String dateLabel;
}

class WorkoutSessionOverviewViewModel {
  const WorkoutSessionOverviewViewModel({
    required this.startedAtLabel,
    required this.durationLabel,
    required this.exerciseCountLabel,
    required this.setCountLabel,
    required this.volumeLabel,
    required this.headerTitle,
  });

  final String startedAtLabel;
  final String durationLabel;
  final String exerciseCountLabel;
  final String setCountLabel;
  final String volumeLabel;
  final String headerTitle;
}

class WorkoutSetDisplayViewModel {
  const WorkoutSetDisplayViewModel({
    required this.indexLabel,
    required this.summaryLabel,
    required this.estimatedOneRepMaxLabel,
    required this.detailLabel,
    required this.repsLabel,
    required this.weightLabel,
    required this.setTypeLabel,
    required this.metaLabel,
  });

  final String indexLabel;
  final String summaryLabel;
  final String estimatedOneRepMaxLabel;
  final String detailLabel;
  final String repsLabel;
  final String weightLabel;
  final String setTypeLabel;
  final String metaLabel;
}
