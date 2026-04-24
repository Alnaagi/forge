import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/sync_providers.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/domain/entities/auth_session_state.dart';
import 'package:forge/domain/entities/linked_account_state.dart';
import 'package:forge/domain/entities/sync_overview.dart';
import 'package:forge/domain/entities/sync_queue_item.dart';
import 'package:forge/features/settings/presentation/controllers/backup_sync_controller.dart';
import 'package:forge/shared/enums/sync_domain.dart';
import 'package:go_router/go_router.dart';

class BackupSyncScreen extends ConsumerStatefulWidget {
  const BackupSyncScreen({super.key});

  @override
  ConsumerState<BackupSyncScreen> createState() => _BackupSyncScreenState();
}

class _BackupSyncScreenState extends ConsumerState<BackupSyncScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overviewAsync = ref.watch(syncOverviewProvider);
    final actionState = ref.watch(backupSyncControllerProvider);

    return AppScaffold(
      title: 'Backup & Sync',
      eyebrow: 'Account Link',
      subtitle:
          'Forge stays fully local without sign-in. When linked, Forge can upload read-only domain snapshot backups to the cloud without changing local ownership.',
      child: overviewAsync.when(
        data: (overview) => ListView(
          children: [
            _AccountStatusPanel(
              overview: overview,
              actionState: actionState,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const SizedBox(height: AppSpacing.md),
            _QueuePanel(overview: overview),
            const SizedBox(height: AppSpacing.md),
            AppPanel(
              gradient: AppColors.orangePanelGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What This Milestone Does',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Forge now uploads domain snapshot backups and offers a controlled restore/import preview. Full restore coverage, merge logic, and bidirectional sync are still intentionally deferred.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  OutlinedButton.icon(
                    onPressed: () =>
                        context.pushNamed(RouteNames.restoreImport),
                    icon: const Icon(Icons.restore_page_outlined),
                    label: const Text('Browse Restore Imports'),
                  ),
                ],
              ),
            ),
          ],
        ),
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading backup state'),
      ),
    );
  }
}

class _AccountStatusPanel extends ConsumerWidget {
  const _AccountStatusPanel({
    required this.overview,
    required this.actionState,
    required this.emailController,
    required this.passwordController,
  });

  final SyncOverview overview;
  final AsyncValue<void> actionState;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final AuthSessionState session = overview.sessionState;
    final LinkedAccountState? linkedAccount = overview.linkedAccount;
    final isLinkedToCurrentSession =
        session.isSignedIn &&
        linkedAccount != null &&
        linkedAccount.accountId == session.accountId;

    return AppPanel(
      gradient: AppColors.bluePanelGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Account Status', style: theme.textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _headline(session, isLinkedToCurrentSession),
            style: theme.textTheme.titleLarge?.copyWith(
              color: _headlineColor(session, isLinkedToCurrentSession),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _description(session, linkedAccount, isLinkedToCurrentSession),
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Badge(
                label: session.isBackendConfigured
                    ? 'Supabase configured'
                    : 'Cloud backend not configured',
                color: session.isBackendConfigured
                    ? AppColors.neonGreen
                    : AppColors.vividOrange,
              ),
              _Badge(
                label: session.isSignedIn ? 'Signed in' : 'Guest mode',
                color: session.isSignedIn
                    ? AppColors.electricBlue
                    : AppColors.electricBlue,
              ),
              if (linkedAccount != null)
                _Badge(
                  label: session.isSignedIn
                      ? 'Linked ${_formatDate(linkedAccount.linkedAt)}'
                      : 'Previously linked ${_formatDate(linkedAccount.linkedAt)}',
                  color: AppColors.neonGreen,
                ),
            ],
          ),
          if (!session.isBackendConfigured) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              'To enable account linking in this build, run Forge with `--dart-define=FORGE_SUPABASE_URL=...` and `--dart-define=FORGE_SUPABASE_PUBLISHABLE_KEY=...`.',
              style: theme.textTheme.bodySmall,
            ),
          ] else if (!session.isSignedIn) ...[
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                FilledButton(
                  onPressed: actionState.isLoading
                      ? null
                      : () => _runAction(
                          context,
                          ref,
                          () => ref
                              .read(backupSyncControllerProvider.notifier)
                              .createAccount(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                        ),
                  child: Text(
                    actionState.isLoading ? 'Working...' : 'Create Account',
                  ),
                ),
                OutlinedButton(
                  onPressed: actionState.isLoading
                      ? null
                      : () => _runAction(
                          context,
                          ref,
                          () => ref
                              .read(backupSyncControllerProvider.notifier)
                              .signIn(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                        ),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: AppSpacing.md),
            if (session.email != null)
              Text(
                'Signed in as ${session.email}',
                style: theme.textTheme.bodySmall,
              ),
            if (linkedAccount != null && linkedAccount.email != null)
              Text(
                'Local device linked to ${linkedAccount.email}',
                style: theme.textTheme.bodySmall,
              ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                if (!isLinkedToCurrentSession)
                  FilledButton(
                    onPressed: actionState.isLoading
                        ? null
                        : () => _runAction(
                            context,
                            ref,
                            () => ref
                                .read(backupSyncControllerProvider.notifier)
                                .linkCurrentSession(),
                          ),
                    child: Text(
                      actionState.isLoading ? 'Linking...' : 'Link Local Data',
                    ),
                  ),
                if (isLinkedToCurrentSession)
                  FilledButton.tonal(
                    onPressed: actionState.isLoading
                        ? null
                        : () => _runAction(
                            context,
                            ref,
                            () => ref
                                .read(backupSyncControllerProvider.notifier)
                                .uploadNow(),
                          ),
                    child: Text(
                      actionState.isLoading ? 'Uploading...' : 'Upload Now',
                    ),
                  ),
                if (session.isSignedIn)
                  OutlinedButton(
                    onPressed: actionState.isLoading
                        ? null
                        : () => context.pushNamed(RouteNames.restoreImport),
                    child: const Text('Browse Backups'),
                  ),
                OutlinedButton(
                  onPressed: actionState.isLoading
                      ? null
                      : () => _runAction(
                          context,
                          ref,
                          () => ref
                              .read(backupSyncControllerProvider.notifier)
                              .refreshBackupQueue(),
                        ),
                  child: const Text('Refresh Backup Queue'),
                ),
                TextButton(
                  onPressed: actionState.isLoading
                      ? null
                      : () => _runAction(
                          context,
                          ref,
                          () => ref
                              .read(backupSyncControllerProvider.notifier)
                              .signOut(),
                        ),
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _runAction(
    BuildContext context,
    WidgetRef ref,
    Future<String> Function() action,
  ) async {
    try {
      final message = await action();
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

class _QueuePanel extends StatelessWidget {
  const _QueuePanel({required this.overview});

  final SyncOverview overview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<SyncQueueItem> uploadableItems = overview.uploadableItems;

    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Local Sync Queue', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            uploadableItems.isEmpty
                ? 'No retryable backup batches are waiting right now.'
                : '${overview.uploadableItemCount} backup batch${overview.uploadableItemCount == 1 ? '' : 'es'} are waiting to upload or retry.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Badge(
                label: '${overview.uploadableItemCount} queued',
                color: overview.uploadableItemCount == 0
                    ? AppColors.electricBlue
                    : AppColors.vividOrange,
              ),
              if (overview.failedItemCount > 0)
                _Badge(
                  label: '${overview.failedItemCount} failed retryable',
                  color: AppColors.crimson,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _QueueMetaRow(
            label: 'Last queue refresh',
            value: overview.lastPreparedAt == null
                ? 'Not run yet'
                : _formatDateTime(overview.lastPreparedAt as DateTime),
          ),
          _QueueMetaRow(
            label: 'Last upload attempt',
            value: overview.lastSyncAttemptAt == null
                ? 'No cloud upload run yet'
                : _formatDateTime(overview.lastSyncAttemptAt as DateTime),
          ),
          _QueueMetaRow(
            label: 'Last successful cloud backup',
            value: overview.lastSyncSuccessAt == null
                ? 'No successful upload yet'
                : _formatDateTime(overview.lastSyncSuccessAt as DateTime),
          ),
          if ((overview.lastSyncError ?? '').toString().trim().isNotEmpty)
            _QueueMetaRow(
              label: 'Most recent failed backup',
              value:
                  '${overview.lastSyncAttemptAt == null ? 'Latest attempt time unavailable' : _formatDateTime(overview.lastSyncAttemptAt as DateTime)} | ${(overview.lastSyncError ?? '').toString()}',
            ),
          if (uploadableItems.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final item in uploadableItems)
                  _Badge(
                    label: item.domain.label,
                    color: AppColors.electricBlue,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _QueueMetaRow extends StatelessWidget {
  const _QueueMetaRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
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

String _headline(AuthSessionState session, bool isLinkedToCurrentSession) {
  if (!session.isBackendConfigured) {
    return 'Cloud backup is optional and not configured in this build';
  }
  if (!session.isSignedIn) {
    return 'Forge is running fully local in guest mode';
  }
  if (!isLinkedToCurrentSession) {
    return 'Signed in, but this device still needs to link local data';
  }
  return 'Signed in and ready for cloud backup uploads';
}

Color _headlineColor(AuthSessionState session, bool isLinkedToCurrentSession) {
  if (!session.isBackendConfigured) {
    return AppColors.vividOrange;
  }
  if (!session.isSignedIn) {
    return AppColors.electricBlue;
  }
  if (!isLinkedToCurrentSession) {
    return AppColors.vividOrange;
  }
  return AppColors.neonGreen;
}

String _description(
  AuthSessionState session,
  LinkedAccountState? linkedAccount,
  bool isLinked,
) {
  if (!session.isBackendConfigured) {
    return 'Forge still works completely offline and locally. Add Supabase credentials only when you want optional account linking and future backup support in this build.';
  }
  if (!session.isSignedIn) {
    return 'Your local data already lives safely in Drift on this device. Signing in later does not replace it. Forge only links the existing local device state to an account for backup groundwork.';
  }
  if (!isLinked) {
    return 'The session is active, but Forge has not attached this device\'s local dataset to the signed-in account yet. Use the link action once and your existing local data stays intact.';
  }
  return 'Forge has linked this device to ${linkedAccount?.email ?? session.email ?? 'your account'} and prepared a local sync queue. Snapshot uploads are live now, while restore, merge, and bidirectional sync stay intentionally deferred.';
}

String _formatDate(DateTime value) {
  final local = value.toLocal();
  return '${local.month}/${local.day}/${local.year}';
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
