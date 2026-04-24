import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/auth_providers.dart';
import 'package:forge/application/providers/sync_providers.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/domain/entities/auth_session_state.dart';
import 'package:forge/domain/entities/remote_backup_preview.dart';
import 'package:forge/domain/entities/remote_backup_summary.dart';
import 'package:forge/domain/entities/restore_support_level.dart';
import 'package:forge/features/settings/presentation/controllers/restore_import_controller.dart';
import 'package:forge/shared/enums/sync_domain.dart';

class RestoreImportScreen extends ConsumerStatefulWidget {
  const RestoreImportScreen({super.key});

  @override
  ConsumerState<RestoreImportScreen> createState() =>
      _RestoreImportScreenState();
}

class _RestoreImportScreenState extends ConsumerState<RestoreImportScreen> {
  String? _selectedInstallationId;

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(authSessionStateProvider);
    final session =
        sessionAsync.valueOrNull ?? const AuthSessionState.unconfigured();
    final actionState = ref.watch(restoreImportControllerProvider);

    return AppScaffold(
      title: 'Restore & Import',
      eyebrow: 'Cloud Backup',
      subtitle:
          'Review uploaded backups before importing. Forge only imports the safest supported data and never overwrites local data automatically.',
      child: !session.isBackendConfigured
          ? const _RestoreStatePanel(
              title: 'Cloud backup is not configured in this build',
              message:
                  'Forge still works fully offline. Add Supabase credentials only when you want to browse or import uploaded backup snapshots.',
            )
          : !session.isSignedIn
          ? const _RestoreStatePanel(
              title: 'Sign in to browse backups',
              message:
                  'Restore and import are optional. Forge only shows cloud backups after you sign in to the account that owns them.',
            )
          : _buildSignedInView(context, actionState),
    );
  }

  Widget _buildSignedInView(
    BuildContext context,
    AsyncValue<void> actionState,
  ) {
    final backupsAsync = ref.watch(remoteBackupSummariesProvider);
    return backupsAsync.when(
      data: (backups) {
        if (backups.isEmpty) {
          return const _RestoreStatePanel(
            title: 'No cloud backups yet',
            message:
                'This account does not have any uploaded snapshot batches yet. Upload from a linked device first, then come back here to preview import options.',
          );
        }

        final selectedInstallationId =
            _selectedInstallationId != null &&
                backups.any(
                  (backup) => backup.installationId == _selectedInstallationId,
                )
            ? _selectedInstallationId!
            : backups.first.installationId;
        if (_selectedInstallationId != selectedInstallationId) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _selectedInstallationId = selectedInstallationId);
            }
          });
        }

        return ListView(
          children: [
            AppPanel(
              gradient: AppColors.bluePanelGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Backups',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Each card is the latest uploaded snapshot set for one installation. Forge marks whether it looks like this device or another linked device.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final backup in backups) ...[
              _BackupCard(
                backup: backup,
                isSelected: backup.installationId == selectedInstallationId,
                onTap: () => setState(
                  () => _selectedInstallationId = backup.installationId,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            _RestorePreviewPanel(
              installationId: selectedInstallationId,
              isBusy: actionState.isLoading,
            ),
          ],
        );
      },
      error: (error, stackTrace) => AppErrorState(message: error.toString()),
      loading: () => const AppLoadingView(label: 'Loading cloud backups'),
    );
  }
}

class _RestorePreviewPanel extends ConsumerWidget {
  const _RestorePreviewPanel({
    required this.installationId,
    required this.isBusy,
  });

  final String installationId;
  final bool isBusy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previewAsync = ref.watch(remoteBackupPreviewProvider(installationId));
    return previewAsync.when(
      data: (preview) => AppPanel(
        gradient: AppColors.greenPanelGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Import Preview',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(preview.notice, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            for (final domain in preview.domains) ...[
              _PreviewDomainRow(domain: domain),
              if (domain != preview.domains.last)
                const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                FilledButton.tonal(
                  onPressed: !preview.hasImportableDomains || isBusy
                      ? null
                      : () => _confirmImport(context, ref, preview),
                  child: Text(
                    isBusy ? 'Importing...' : 'Import Supported Data',
                  ),
                ),
                if (!preview.hasImportableDomains)
                  Text(
                    'Nothing in this backup is eligible for safe import yet.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ],
        ),
      ),
      error: (error, stackTrace) => AppErrorState(message: error.toString()),
      loading: () => const AppPanel(
        child: AppLoadingView(label: 'Building restore preview'),
      ),
    );
  }

  Future<void> _confirmImport(
    BuildContext context,
    WidgetRef ref,
    RemoteBackupPreview preview,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Supported Data'),
        content: Text(
          'Forge will add supported data from installation `${preview.backup.installationId}` without deleting local data. Unsupported domains stay untouched. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Import'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }

    try {
      final message = await ref
          .read(restoreImportControllerProvider.notifier)
          .importBackup(preview.backup.installationId);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

class _BackupCard extends StatelessWidget {
  const _BackupCard({
    required this.backup,
    required this.isSelected,
    required this.onTap,
  });

  final RemoteBackupSummary backup;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      gradient: isSelected ? AppColors.orangePanelGradient : null,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  backup.isCurrentDevice ? 'This Device' : 'Another Device',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: backup.isCurrentDevice
                        ? AppColors.neonGreen
                        : AppColors.electricBlue,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.neonGreen,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            backup.installationId,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Updated ${_formatDateTime(backup.lastUpdatedAt)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Uploaded ${_formatDateTime(backup.lastUploadedAt)} • Payload v${backup.payloadVersion}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final domain in backup.availableDomains)
                _StatusBadge(
                  label: domain.label,
                  color: AppColors.electricBlue,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreviewDomainRow extends StatelessWidget {
  const _PreviewDomainRow({required this.domain});

  final RemoteBackupDomainPreview domain;

  @override
  Widget build(BuildContext context) {
    final color = switch (domain.supportLevel) {
      RestoreSupportLevel.supported => AppColors.neonGreen,
      RestoreSupportLevel.partial => AppColors.vividOrange,
      RestoreSupportLevel.deferred => AppColors.crimson,
    };
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  domain.domain.label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              _StatusBadge(label: domain.supportLevel.label, color: color),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(domain.summary, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Backup records: ${domain.availableRecordCount} • Importable now: ${domain.importableRecordCount}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
      ),
    );
  }
}

class _RestoreStatePanel extends StatelessWidget {
  const _RestoreStatePanel({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      gradient: AppColors.orangePanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
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
