enum HealthEntryType { symptom, mood, pain, injury }

extension HealthEntryTypeLabel on HealthEntryType {
  String get label => switch (this) {
    HealthEntryType.symptom => 'Symptom',
    HealthEntryType.mood => 'Mood',
    HealthEntryType.pain => 'Pain',
    HealthEntryType.injury => 'Injury',
  };
}
