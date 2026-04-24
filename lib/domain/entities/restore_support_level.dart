enum RestoreSupportLevel { supported, partial, deferred }

extension RestoreSupportLevelLabel on RestoreSupportLevel {
  String get label => switch (this) {
    RestoreSupportLevel.supported => 'Supported',
    RestoreSupportLevel.partial => 'Partial',
    RestoreSupportLevel.deferred => 'Deferred',
  };
}
