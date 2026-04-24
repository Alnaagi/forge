import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/reminder_providers.dart';
import 'package:forge/application/services/reminder_notification_scheduler.dart';
import 'package:forge/application/providers/settings_providers.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/domain/entities/reminder.dart';
import 'package:forge/shared/enums/reminder_type.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModePreferenceProvider);
    final selectedThemeMode = themeModeAsync.valueOrNull ?? ThemeMode.system;
    final gymMembershipAsync = ref.watch(gymMembershipStatusProvider);
    final smartRemindersAsync = ref.watch(smartRemindersProvider);
    final reminderDeliveryStatusAsync = ref.watch(
      reminderNotificationStatusProvider,
    );

    return AppScaffold(
      title: 'Settings',
      eyebrow: 'Control Room',
      subtitle:
          'Keep the real controls here tight and truthful: appearance, goals, reminders, and gym cycle tracking.',
      child: ListView(
        children: [
          AppPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.electricBlue,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Choose whether Forge follows your system theme or stays locked to a specific mode.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                SegmentedButton<ThemeMode>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.system,
                      icon: Icon(Icons.settings_suggest_outlined),
                      label: Text('System'),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.light,
                      icon: Icon(Icons.light_mode_outlined),
                      label: Text('Light'),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.dark,
                      icon: Icon(Icons.dark_mode_outlined),
                      label: Text('Dark'),
                    ),
                  ],
                  selected: {selectedThemeMode},
                  onSelectionChanged: (selection) {
                    ref
                        .read(themeModeControllerProvider)
                        .setThemeMode(selection.first);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPanel(
            gradient: AppColors.bluePanelGradient,
            onTap: () => context.pushNamed(RouteNames.backupSync),
            child: const _SettingsLink(
              title: 'Backup & Sync',
              subtitle:
                  'Optional account linking, local sync queue status, and honest cloud backup state.',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPanel(
            gradient: AppColors.greenPanelGradient,
            onTap: () => context.pushNamed(RouteNames.goals),
            child: const _SettingsLink(
              title: 'Active Goal',
              subtitle:
                  'Set the current goal Forge should use for nutrition and insight decisions.',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          smartRemindersAsync.when(
            data: (reminders) => AppPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Smart Reminders',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(color: AppColors.neonGreen),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Refresh smart reminders',
                        onPressed: () async {
                          await ref
                              .read(reminderNotificationControllerProvider)
                              .refresh();
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _smartReminderSummary(
                      reminders: reminders,
                      deliveryStatus: reminderDeliveryStatusAsync.valueOrNull,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (reminderDeliveryStatusAsync.valueOrNull
                      case final status?) ...[
                    const SizedBox(height: AppSpacing.md),
                    _ReminderDeliveryStatusRow(status: status),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        if (status.isSupported &&
                            !status.areNotificationsEnabled)
                          FilledButton.tonal(
                            onPressed: () async {
                              final granted = await ref
                                  .read(reminderNotificationControllerProvider)
                                  .requestPermissions();
                              if (!context.mounted) {
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    granted
                                        ? 'Notifications enabled for Forge.'
                                        : 'Notification permission is still off.',
                                  ),
                                ),
                              );
                            },
                            child: const Text('Enable Notifications'),
                          ),
                        OutlinedButton(
                          onPressed: () async {
                            await ref
                                .read(reminderNotificationControllerProvider)
                                .refresh();
                          },
                          child: const Text('Resync Device Delivery'),
                        ),
                      ],
                    ),
                  ],
                  if (reminders.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    for (final reminder in reminders) ...[
                      _ReminderRow(reminder: reminder),
                      if (reminder != reminders.last)
                        const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
                ],
              ),
            ),
            error: (error, stackTrace) =>
                AppPanel(child: Text(error.toString())),
            loading: () => const AppPanel(
              child: AppLoadingView(label: 'Loading smart reminders'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          gymMembershipAsync.when(
            data: (membership) => AppPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gym Membership',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.vividOrange,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    membership == null
                        ? 'No start date saved yet.'
                        : membership.isExpired
                        ? 'Expired on ${_formatDate(membership.renewalDate)}.'
                        : '${membership.daysRemaining} day${membership.daysRemaining == 1 ? '' : 's'} left in the current cycle.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    membership == null
                        ? 'Set the first day of your monthly gym subscription and Forge will track the cycle on the dashboard.'
                        : 'Started ${_formatDate(membership.startDate)} and renews ${_formatDate(membership.renewalDate)}.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      FilledButton.tonal(
                        onPressed: () => _pickGymMembershipDate(context, ref),
                        child: Text(
                          membership == null
                              ? 'Set Start Date'
                              : 'Edit Start Date',
                        ),
                      ),
                      if (membership != null)
                        OutlinedButton(
                          onPressed: () => ref
                              .read(gymMembershipControllerProvider)
                              .renewToday(cycleDays: membership.cycleDays),
                          child: const Text('Renew Today'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) =>
                AppPanel(child: Text(error.toString())),
            loading: () => const AppPanel(
              child: AppLoadingView(label: 'Loading gym membership'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPanel(
            gradient: AppColors.orangePanelGradient,
            onTap: () => context.pushNamed(RouteNames.integrations),
            child: const _SettingsLink(
              title: 'Integrations',
              subtitle:
                  'Health Connect read-only sync status, permissions, and imported device data.',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPanel(
            gradient: AppColors.bluePanelGradient,
            onTap: () => context.pushNamed(RouteNames.reports),
            child: const _SettingsLink(
              title: 'Reports & Export',
              subtitle:
                  'Exports are intentionally deferred until reporting rules are finalized.',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickGymMembershipDate(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final settings = await ref.read(gymMembershipSettingsProvider.future);
    if (!context.mounted) {
      return;
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: settings?.startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate == null) {
      return;
    }

    await ref
        .read(gymMembershipControllerProvider)
        .saveMembership(
          startDate: pickedDate,
          cycleDays: settings?.cycleDays ?? 30,
        );
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Gym membership updated.')));
  }
}

class _SettingsLink extends StatelessWidget {
  const _SettingsLink({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow({required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(theme.brightness),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    reminder.isEnabled
                        ? Icons.notifications_active_outlined
                        : Icons.notifications_off_outlined,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminder.title,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          '${_reminderLabel(reminder.type)} at ${reminder.timeOfDay}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: reminder.isEnabled,
                    onChanged: (value) async {
                      await ref
                          .read(reminderNotificationControllerProvider)
                          .setReminderEnabled(
                            reminder: reminder,
                            isEnabled: value,
                          );
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _pickReminderTime(context, ref, reminder),
                    icon: const Icon(Icons.schedule_outlined),
                    label: const Text('Edit Time'),
                  ),
                  if (!reminder.isEnabled)
                    Text(
                      'Disabled until you turn it back on.',
                      style: theme.textTheme.bodySmall,
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickReminderTime(
    BuildContext context,
    WidgetRef ref,
    Reminder reminder,
  ) async {
    final parts = reminder.timeOfDay.split(':');
    final initialTime = TimeOfDay(
      hour: int.tryParse(parts.first) ?? 9,
      minute: parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
    );

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime == null) {
      return;
    }

    final formatted =
        '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
    await ref
        .read(reminderNotificationControllerProvider)
        .setReminderTimeOfDay(reminder: reminder, timeOfDay: formatted);
  }
}

class _ReminderDeliveryStatusRow extends StatelessWidget {
  const _ReminderDeliveryStatusRow({required this.status});

  final ReminderNotificationDeliveryStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeColor = !status.isSupported
        ? AppColors.vividOrange
        : status.areNotificationsEnabled
        ? AppColors.neonGreen
        : AppColors.vividOrange;
    final label = !status.isSupported
        ? 'Web preview only'
        : status.areNotificationsEnabled
        ? 'Device delivery active'
        : 'Permission needed';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(theme.brightness),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            status.areNotificationsEnabled
                ? Icons.notifications_active
                : Icons.notifications_off_outlined,
            color: badgeColor,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  status.isSupported
                      ? '${status.scheduledReminderCount} reminder slot${status.scheduledReminderCount == 1 ? '' : 's'} scheduled on this device.'
                      : 'Smart reminders still render here, but scheduled delivery is only active on the installed Android app.',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _reminderLabel(ReminderType reminderType) {
  return switch (reminderType) {
    ReminderType.workout => 'Workout',
    ReminderType.meal => 'Meal',
    ReminderType.water => 'Water',
    ReminderType.weighIn => 'Weigh-in',
    ReminderType.sleep => 'Sleep',
    ReminderType.progressCheck => 'Progress check',
  };
}

String _smartReminderSummary({
  required List<Reminder> reminders,
  required ReminderNotificationDeliveryStatus? deliveryStatus,
}) {
  if (reminders.isEmpty) {
    return 'No smart reminders are active yet. Forge will create them when active insights or health check cadence call for one.';
  }
  if (deliveryStatus == null) {
    return 'Forge is syncing smart reminders from active insights and health cadence.';
  }
  if (!deliveryStatus.isSupported) {
    return 'Forge is planning smart reminders locally. This web view keeps them visible for testing, while real scheduled delivery happens on Android builds.';
  }
  if (!deliveryStatus.areNotificationsEnabled) {
    return 'Forge has a live reminder plan, but Android notification permission is still off. Enable it to get actual reminder delivery.';
  }
  final enabledCount = reminders.where((reminder) => reminder.isEnabled).length;
  return 'Forge is scheduling $enabledCount of ${reminders.length} smart reminder slot${reminders.length == 1 ? '' : 's'} on this device.';
}

String _formatDate(DateTime value) {
  final local = value.toLocal();
  return '${local.month}/${local.day}/${local.year}';
}
