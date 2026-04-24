import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/auth_providers.dart';
import 'package:forge/application/providers/profile_providers.dart';
import 'package:forge/application/providers/sync_providers.dart';
import 'package:forge/domain/entities/auth_session_state.dart';
import 'package:forge/domain/entities/linked_account_state.dart';

final backupSyncControllerProvider =
    AsyncNotifierProvider.autoDispose<BackupSyncController, void>(
      BackupSyncController.new,
    );

class BackupSyncController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<String> createAccount({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .signUpWithEmail(email: email.trim(), password: password);
      if (result.sessionState.isSignedIn) {
        await _linkSession(result.sessionState);
      } else {
        ref.invalidate(syncOverviewProvider);
      }
      state = const AsyncData(null);
      return result.userMessage;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .signInWithEmail(email: email.trim(), password: password);
      if (result.sessionState.isSignedIn) {
        await _linkSession(result.sessionState);
      } else {
        ref.invalidate(syncOverviewProvider);
      }
      state = const AsyncData(null);
      return result.userMessage;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<String> linkCurrentSession() async {
    state = const AsyncLoading();
    try {
      final session = await ref.read(authRepositoryProvider).getSessionState();
      if (!session.isSignedIn || session.accountId == null) {
        state = const AsyncData(null);
        return 'Sign in first, then Forge can link this device safely.';
      }
      final linkedAccount = await _linkSession(session);
      state = const AsyncData(null);
      final email = linkedAccount.email ?? session.email ?? 'your account';
      return 'Forge linked this device to $email and queued local snapshot batches for future backup.';
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<String> refreshBackupQueue() async {
    state = const AsyncLoading();
    try {
      final queueCount = await ref.read(syncRepositoryProvider).enqueueLocalChanges();
      ref.invalidate(syncOverviewProvider);
      state = const AsyncData(null);
      return queueCount == 0
          ? 'No linked account yet. Sign in first to prepare backup work.'
          : 'Backup queue refreshed with $queueCount local snapshot batch${queueCount == 1 ? '' : 'es'}.';
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<String> uploadNow() async {
    state = const AsyncLoading();
    try {
      final result = await ref.read(syncRepositoryProvider).uploadPendingBatches();
      ref.invalidate(syncOverviewProvider);
      state = const AsyncData(null);
      if (result.attemptedCount == 0) {
        return 'No pending backup batches were waiting for upload.';
      }
      if (result.failedCount == 0) {
        return 'Backup upload finished with ${result.uploadedCount} uploaded batch${result.uploadedCount == 1 ? '' : 'es'}.';
      }
      return 'Backup upload finished with ${result.uploadedCount} uploaded and ${result.failedCount} failed batch${result.failedCount == 1 ? '' : 'es'}.';
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<String> signOut() async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).signOut();
      ref.invalidate(syncOverviewProvider);
      state = const AsyncData(null);
      return 'Signed out. Local data stays on this device.';
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<LinkedAccountState> _linkSession(AuthSessionState session) async {
    final syncRepository = ref.read(syncRepositoryProvider);
    final profile = await ref.read(currentUserProfileProvider.future);
    final linkedAccount = await syncRepository.linkLocalDataToAccount(
      accountId: session.accountId!,
      email: session.email,
    );
    await ref
        .read(authRepositoryProvider)
        .updateLinkedMetadata(
          installationId: linkedAccount.installationId,
          displayName: profile?.displayName,
        );
    ref.invalidate(syncOverviewProvider);
    return linkedAccount;
  }
}
