import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/settings_dao.dart';
import 'package:forge/data/repositories/settings_repository_impl.dart';
import 'package:forge/domain/entities/app_setting.dart';
import 'package:forge/domain/repositories/settings_repository.dart';

const _themeModeSettingKey = 'theme_mode';
const _gymMembershipStartDateKey = 'gym_membership_start_date';
const _gymMembershipCycleDaysKey = 'gym_membership_cycle_days';
const _dashboardSectionOrderKey = 'dashboard_section_order';

final settingsDaoProvider = Provider<SettingsDao>((ref) {
  return SettingsDao(ref.watch(appDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(ref.watch(settingsDaoProvider));
});

final themeModePreferenceProvider = FutureProvider<ThemeMode>((ref) async {
  final setting = await ref
      .watch(settingsRepositoryProvider)
      .getByKey(_themeModeSettingKey);
  return _themeModeFromValue(setting?.value);
});

final themeModeControllerProvider = Provider<ThemeModeController>((ref) {
  return ThemeModeController(
    repository: ref.watch(settingsRepositoryProvider),
    ref: ref,
  );
});

final gymMembershipSettingsProvider = FutureProvider<GymMembershipSettings?>((
  ref,
) async {
  final repository = ref.watch(settingsRepositoryProvider);
  final startDateSetting = await repository.getByKey(
    _gymMembershipStartDateKey,
  );
  if (startDateSetting == null || startDateSetting.value.trim().isEmpty) {
    return null;
  }

  final parsedStartDate = DateTime.tryParse(startDateSetting.value.trim());
  if (parsedStartDate == null) {
    return null;
  }

  final cycleDaysSetting = await repository.getByKey(
    _gymMembershipCycleDaysKey,
  );
  final cycleDays = int.tryParse(cycleDaysSetting?.value ?? '') ?? 30;

  return GymMembershipSettings(
    startDate: DateTime(
      parsedStartDate.year,
      parsedStartDate.month,
      parsedStartDate.day,
    ),
    cycleDays: cycleDays,
  );
});

final gymMembershipStatusProvider = FutureProvider<GymMembershipStatus?>((
  ref,
) async {
  final settings = await ref.watch(gymMembershipSettingsProvider.future);
  if (settings == null) {
    return null;
  }
  return GymMembershipStatus.fromSettings(settings, now: DateTime.now());
});

final gymMembershipControllerProvider = Provider<GymMembershipController>((
  ref,
) {
  return GymMembershipController(
    repository: ref.watch(settingsRepositoryProvider),
    ref: ref,
  );
});

final dashboardSectionOrderProvider = FutureProvider<List<DashboardSection>>((
  ref,
) async {
  final setting = await ref
      .watch(settingsRepositoryProvider)
      .getByKey(_dashboardSectionOrderKey);
  return parseDashboardSectionOrder(setting?.value);
});

final dashboardLayoutControllerProvider = Provider<DashboardLayoutController>((
  ref,
) {
  return DashboardLayoutController(
    repository: ref.watch(settingsRepositoryProvider),
    ref: ref,
  );
});

class ThemeModeController {
  const ThemeModeController({required this.repository, required this.ref});

  final SettingsRepository repository;
  final Ref ref;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await repository.save(
      AppSetting(
        key: _themeModeSettingKey,
        value: _themeModeToValue(themeMode),
        updatedAt: DateTime.now(),
      ),
    );
    ref.invalidate(themeModePreferenceProvider);
  }
}

class GymMembershipController {
  const GymMembershipController({required this.repository, required this.ref});

  final SettingsRepository repository;
  final Ref ref;

  Future<void> saveMembership({
    required DateTime startDate,
    int cycleDays = 30,
  }) async {
    final normalizedDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final updatedAt = DateTime.now();

    await repository.save(
      AppSetting(
        key: _gymMembershipStartDateKey,
        value: normalizedDate.toIso8601String(),
        updatedAt: updatedAt,
      ),
    );
    await repository.save(
      AppSetting(
        key: _gymMembershipCycleDaysKey,
        value: cycleDays.toString(),
        updatedAt: updatedAt,
      ),
    );
    _invalidate();
  }

  Future<void> renewToday({int cycleDays = 30}) {
    return saveMembership(startDate: DateTime.now(), cycleDays: cycleDays);
  }

  void _invalidate() {
    ref.invalidate(gymMembershipSettingsProvider);
    ref.invalidate(gymMembershipStatusProvider);
  }
}

class DashboardLayoutController {
  const DashboardLayoutController({
    required this.repository,
    required this.ref,
  });

  final SettingsRepository repository;
  final Ref ref;

  Future<void> saveSectionOrder(List<DashboardSection> sections) async {
    await repository.save(
      AppSetting(
        key: _dashboardSectionOrderKey,
        value: sections.map((section) => section.name).join(','),
        updatedAt: DateTime.now(),
      ),
    );
    ref.invalidate(dashboardSectionOrderProvider);
  }

  Future<void> resetSectionOrder() {
    return saveSectionOrder(defaultDashboardSectionOrder);
  }
}

class GymMembershipSettings {
  const GymMembershipSettings({
    required this.startDate,
    required this.cycleDays,
  });

  final DateTime startDate;
  final int cycleDays;
}

class GymMembershipStatus {
  const GymMembershipStatus({
    required this.startDate,
    required this.cycleDays,
    required this.renewalDate,
    required this.daysElapsed,
    required this.daysRemaining,
    required this.progress,
    required this.isExpired,
    required this.isWarning,
    required this.isNearEnd,
  });

  factory GymMembershipStatus.fromSettings(
    GymMembershipSettings settings, {
    required DateTime now,
  }) {
    final today = DateTime(now.year, now.month, now.day);
    final renewalDate = settings.startDate.add(
      Duration(days: settings.cycleDays),
    );
    final daysElapsed = today
        .difference(settings.startDate)
        .inDays
        .clamp(0, 9999);
    final daysRemaining = renewalDate.difference(today).inDays;
    final rawProgress = daysElapsed / settings.cycleDays;

    return GymMembershipStatus(
      startDate: settings.startDate,
      cycleDays: settings.cycleDays,
      renewalDate: renewalDate,
      daysElapsed: daysElapsed,
      daysRemaining: daysRemaining,
      progress: rawProgress.clamp(0, 1).toDouble(),
      isExpired: daysRemaining <= 0,
      isWarning: daysRemaining > 0 && daysRemaining <= 3,
      isNearEnd: daysRemaining > 3 && daysRemaining <= 7,
    );
  }

  final DateTime startDate;
  final int cycleDays;
  final DateTime renewalDate;
  final int daysElapsed;
  final int daysRemaining;
  final double progress;
  final bool isExpired;
  final bool isWarning;
  final bool isNearEnd;
}

enum DashboardSection {
  systemStatus,
  insights,
  healthWatch,
  gymMembership,
  quickMetrics,
  quickRoutes,
  latestSession,
}

extension DashboardSectionLabel on DashboardSection {
  String get label => switch (this) {
    DashboardSection.systemStatus => 'System Status',
    DashboardSection.insights => 'Insights',
    DashboardSection.healthWatch => 'Health Watch',
    DashboardSection.gymMembership => 'Gym Membership',
    DashboardSection.quickMetrics => 'Quick Metrics',
    DashboardSection.quickRoutes => 'Quick Routes',
    DashboardSection.latestSession => 'Latest Session',
  };

  String get description => switch (this) {
    DashboardSection.systemStatus =>
      'Hydration-led daily readiness and top system note.',
    DashboardSection.insights =>
      'Deterministic coaching signals with evidence and action.',
    DashboardSection.healthWatch => 'Active symptom and recovery awareness.',
    DashboardSection.gymMembership =>
      'Subscription countdown and renewal warning bar.',
    DashboardSection.quickMetrics =>
      'Hydration and recent training snapshot cards.',
    DashboardSection.quickRoutes => 'Fast navigation into core areas.',
    DashboardSection.latestSession => 'Most recent workout summary.',
  };
}

const defaultDashboardSectionOrder = <DashboardSection>[
  DashboardSection.systemStatus,
  DashboardSection.insights,
  DashboardSection.healthWatch,
  DashboardSection.gymMembership,
  DashboardSection.quickMetrics,
  DashboardSection.quickRoutes,
  DashboardSection.latestSession,
];

List<DashboardSection> parseDashboardSectionOrder(String? rawValue) {
  final savedNames = (rawValue ?? '')
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList(growable: false);

  final parsed = <DashboardSection>[];
  for (final name in savedNames) {
    for (final section in DashboardSection.values) {
      if (section.name == name && !parsed.contains(section)) {
        parsed.add(section);
        break;
      }
    }
  }

  for (final section in defaultDashboardSectionOrder) {
    if (!parsed.contains(section)) {
      parsed.add(section);
    }
  }

  return parsed;
}

ThemeMode _themeModeFromValue(String? value) {
  return switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}

String _themeModeToValue(ThemeMode themeMode) {
  return switch (themeMode) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };
}
