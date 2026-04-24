import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/health_sync_providers.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:go_router/go_router.dart';

class IntegrationsScreen extends ConsumerWidget {
  const IntegrationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(healthSyncOverviewProvider);

    return AppScaffold(
      title: 'Integrations',
      eyebrow: 'Connected Systems',
      subtitle:
          'Health Connect imports external records into Forge locally. Your Drift database stays the source of truth.',
      child: overviewAsync.when(
        data: (overview) => ListView(
          children: [
            _HealthConnectStatusPanel(overview: overview),
            const SizedBox(height: AppSpacing.md),
            _HealthConnectDataPanel(overview: overview),
            const SizedBox(height: AppSpacing.md),
            AppPanel(
              gradient: AppColors.orangePanelGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Local-First Boundary',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Health Connect is treated as an external feed. Forge stores the imported records locally, dedupes repeat syncs, and only mirrors bodyweight into progress when the mapping is safe.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () =>
            const AppLoadingView(label: 'Loading Health Connect status'),
      ),
    );
  }
}

class _HealthConnectStatusPanel extends ConsumerWidget {
  const _HealthConnectStatusPanel({required this.overview});

  final HealthSyncOverview overview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(healthSyncControllerProvider);
    final status = overview.status;
    final theme = Theme.of(context);

    return AppPanel(
      gradient: AppColors.bluePanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Health Connect', style: theme.textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _statusHeadline(status),
            style: theme.textTheme.titleLarge?.copyWith(
              color: _statusAccent(status),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(_statusDescription(status), style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _StatusChip(
                label: _availabilityLabel(status.availability),
                accent: _statusAccent(status),
              ),
              _StatusChip(
                label: status.activityRecognitionGranted
                    ? 'Activity permission ready'
                    : 'Activity permission needed',
                accent: status.activityRecognitionGranted
                    ? AppColors.neonGreen
                    : AppColors.vividOrange,
              ),
              _StatusChip(
                label: status.readPermissionsGranted
                    ? 'Core health reads ready'
                    : 'Core health reads needed',
                accent: status.readPermissionsGranted
                    ? AppColors.neonGreen
                    : AppColors.vividOrange,
              ),
              _StatusChip(
                label: status.canSyncSteps
                    ? 'Steps ready'
                    : status.stepPermissionsGranted
                    ? 'Steps blocked by activity permission'
                    : 'Steps permission needed',
                accent: status.canSyncSteps
                    ? AppColors.neonGreen
                    : AppColors.vividOrange,
              ),
              if (status.historyAccessAvailable)
                _StatusChip(
                  label: status.historyAccessGranted
                      ? 'History access enabled'
                      : 'History access optional',
                  accent: status.historyAccessGranted
                      ? AppColors.neonGreen
                      : AppColors.electricBlue,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            overview.lastSyncAt == null
                ? 'Last successful sync: not run yet'
                : 'Last successful sync: ${_formatDateTime(overview.lastSyncAt!)}',
            style: theme.textTheme.bodySmall,
          ),
          if ((overview.lastSyncError ?? '').isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Most recent sync error: ${overview.lastSyncError}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.crimson,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Read-only import only. Forge does not write training, nutrition, or health logs back into Health Connect in this milestone.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              if (status.canInstallProvider)
                FilledButton.icon(
                  onPressed: () async {
                    await controller.openInstallScreen();
                  },
                  icon: const Icon(Icons.download_outlined),
                  label: Text(
                    status.availability ==
                            HealthSyncAvailability.providerUpdateRequired
                        ? 'Update Health Connect'
                        : 'Install Health Connect',
                  ),
                )
              else if (_shouldShowPermissionAction(status))
                FilledButton.icon(
                  onPressed: () async {
                    final updatedStatus = await controller.requestPermissions();
                    if (!context.mounted) {
                      return;
                    }
                    final granted = updatedStatus.canSync;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          granted
                              ? 'Health Connect is ready to sync.'
                              : 'Health Connect still needs more permission before the full import set is available.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.health_and_safety_outlined),
                  label: const Text('Grant Permissions'),
                ),
              if (status.canSync)
                FilledButton.tonalIcon(
                  onPressed: () async {
                    try {
                      final result = await controller.syncNow();
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            result.importedRecordCount == 0 &&
                                    result.importedBodyWeightCount == 0
                                ? 'Sync finished. No new records were added.'
                                : 'Sync finished with ${result.importedRecordCount} new records and ${result.importedBodyWeightCount} new bodyweight imports.',
                          ),
                        ),
                      );
                    } catch (error) {
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(error.toString())));
                    }
                  },
                  icon: const Icon(Icons.sync),
                  label: const Text('Sync Now'),
                ),
              OutlinedButton.icon(
                onPressed: () =>
                    context.pushNamed(RouteNames.healthConnectPrivacy),
                icon: const Icon(Icons.privacy_tip_outlined),
                label: const Text('Privacy & Permissions'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HealthConnectDataPanel extends StatelessWidget {
  const _HealthConnectDataPanel({required this.overview});

  final HealthSyncOverview overview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Imported Data', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            overview.totalImportedRecords == 0
                ? 'No Health Connect records have been imported into Forge yet.'
                : '${overview.totalImportedRecords} imported records are stored locally and safe to re-sync.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          _DataTypeTile(
            title: 'Steps',
            accent: AppColors.neonGreen,
            value: overview.todaySteps == null
                ? 'No data yet'
                : '${overview.todaySteps} today',
            subtitle: 'Summed from today\'s imported step records.',
          ),
          const SizedBox(height: AppSpacing.sm),
          _DataTypeTile(
            title: 'Heart Rate',
            accent: AppColors.electricBlue,
            value: overview.latestHeartRate == null
                ? 'No data yet'
                : '${overview.latestHeartRate!.numericValue.round()} bpm',
            subtitle: overview.latestHeartRate == null
                ? 'Latest imported sample will appear here.'
                : 'Latest sample ${_formatDateTime(overview.latestHeartRate!.recordedAt)}',
          ),
          const SizedBox(height: AppSpacing.sm),
          _DataTypeTile(
            title: 'Sleep',
            accent: AppColors.vividOrange,
            value: overview.latestSleepSession == null
                ? 'No data yet'
                : _formatSleepMinutes(
                    overview.latestSleepSession!.numericValue,
                  ),
            subtitle: overview.latestSleepSession == null
                ? 'Latest imported sleep session will appear here.'
                : 'Latest session ended ${_formatDateTime(overview.latestSleepSession!.recordedAt)}',
          ),
          const SizedBox(height: AppSpacing.sm),
          _DataTypeTile(
            title: 'Body Weight',
            accent: AppColors.electricBlue,
            value: overview.latestBodyWeight == null
                ? 'No data yet'
                : '${_formatNumber(overview.latestBodyWeight!.numericValue)} kg',
            subtitle: overview.latestBodyWeight == null
                ? 'Latest imported weight will appear here.'
                : 'Latest imported weight ${_formatDateTime(overview.latestBodyWeight!.recordedAt)}',
          ),
        ],
      ),
    );
  }
}

class _DataTypeTile extends StatelessWidget {
  const _DataTypeTile({
    required this.title,
    required this.accent,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final Color accent;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: accent),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: accent),
      ),
    );
  }
}

String _statusHeadline(HealthSyncConnectionStatus status) {
  if (status.availability == HealthSyncAvailability.unsupportedPlatform) {
    return 'Only available on supported Android devices';
  }
  if (status.availability == HealthSyncAvailability.providerUpdateRequired) {
    return 'Health Connect needs an update';
  }
  if (status.availability == HealthSyncAvailability.unavailable) {
    return 'Health Connect is not installed yet';
  }
  if (status.canSyncCoreData && !status.canSyncSteps) {
    return 'Core imports are ready, but step sync still needs Activity Recognition';
  }
  if (!status.readPermissionsGranted && !status.stepPermissionsGranted) {
    return 'Connect permissions before syncing';
  }
  return 'Ready to import steps, sleep, heart rate, and body weight';
}

String _statusDescription(HealthSyncConnectionStatus status) {
  if (status.availability == HealthSyncAvailability.unsupportedPlatform) {
    return 'Forge keeps the integration screen visible on unsupported platforms, but actual Health Connect syncing only runs on Android with the provider available.';
  }
  if (status.availability == HealthSyncAvailability.providerUpdateRequired) {
    return 'The Health Connect provider is present but needs an update before Forge can request read access and import records.';
  }
  if (status.availability == HealthSyncAvailability.unavailable) {
    return 'Install Health Connect first, then return here to grant read permissions and start syncing.';
  }
  if (status.canSyncCoreData && !status.canSyncSteps) {
    return 'Heart rate, sleep, and body weight can already sync. Step import is still blocked until Android Activity Recognition is granted.';
  }
  if (!status.readPermissionsGranted && !status.stepPermissionsGranted) {
    return 'Forge is ready, but Health Connect read access has not been granted for the supported data types yet.';
  }
  return status.historyAccessGranted
      ? 'Forge can safely re-sync at any time. Imported records stay local, duplicate records are ignored, and bodyweight imports are mirrored into progress only when they do not collide with an existing log.'
      : 'Forge can safely re-sync at any time. Imported records stay local, duplicate records are ignored, and bodyweight imports are mirrored into progress only when they do not collide with an existing log. Without history access, Health Connect may limit how far back reads can go.';
}

String _availabilityLabel(HealthSyncAvailability availability) {
  return switch (availability) {
    HealthSyncAvailability.unsupportedPlatform => 'Unsupported platform',
    HealthSyncAvailability.unavailable => 'Not installed',
    HealthSyncAvailability.providerUpdateRequired => 'Update required',
    HealthSyncAvailability.available => 'Available',
  };
}

Color _statusAccent(HealthSyncConnectionStatus status) {
  return switch (status.availability) {
    HealthSyncAvailability.available when status.canSync => AppColors.neonGreen,
    HealthSyncAvailability.available => AppColors.vividOrange,
    HealthSyncAvailability.providerUpdateRequired => AppColors.vividOrange,
    _ => AppColors.crimson,
  };
}

bool _shouldShowPermissionAction(HealthSyncConnectionStatus status) {
  if (!status.canRequestPermissions) {
    return false;
  }
  return !status.readPermissionsGranted ||
      !status.stepPermissionsGranted ||
      !status.activityRecognitionGranted;
}

String _formatSleepMinutes(double minutes) {
  final duration = Duration(minutes: minutes.round());
  final hours = duration.inHours;
  final remainingMinutes = duration.inMinutes.remainder(60);
  return '${hours}h ${remainingMinutes}m';
}

String _formatNumber(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}

String _formatDateTime(DateTime value) {
  final local = value.toLocal();
  final hour = local.hour == 0
      ? 12
      : (local.hour > 12 ? local.hour - 12 : local.hour);
  final minute = local.minute.toString().padLeft(2, '0');
  final period = local.hour >= 12 ? 'PM' : 'AM';
  return '${local.month}/${local.day}/${local.year} $hour:$minute $period';
}
