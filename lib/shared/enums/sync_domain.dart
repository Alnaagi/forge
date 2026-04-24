enum SyncDomain {
  profile,
  goals,
  workouts,
  nutrition,
  bodyProgress,
  health,
  reminders,
  insights,
  settings,
}

extension SyncDomainLabel on SyncDomain {
  String get label => switch (this) {
    SyncDomain.profile => 'Profile',
    SyncDomain.goals => 'Goals',
    SyncDomain.workouts => 'Workouts',
    SyncDomain.nutrition => 'Nutrition',
    SyncDomain.bodyProgress => 'Body Progress',
    SyncDomain.health => 'Health',
    SyncDomain.reminders => 'Reminders',
    SyncDomain.insights => 'Insights',
    SyncDomain.settings => 'Settings',
  };
}
