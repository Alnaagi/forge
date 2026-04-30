enum ActivityLevel {
  sedentary('Sedentary', 'Mostly sitting, little planned activity'),
  lightlyActive('Lightly active', 'Light movement or training 1-2 days/week'),
  moderatelyActive('Moderately active', 'Training 3-4 days/week'),
  veryActive('Very active', 'Hard training or active work most days'),
  athlete('Athlete', 'High-volume training or sport practice');

  const ActivityLevel(this.label, this.description);

  final String label;
  final String description;
}
