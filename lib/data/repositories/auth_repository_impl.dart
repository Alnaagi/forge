import 'package:forge/application/services/cloud_auth_client.dart';
import 'package:forge/domain/entities/auth_action_result.dart';
import 'package:forge/domain/entities/auth_session_state.dart';
import 'package:forge/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._client);

  final CloudAuthClient _client;

  @override
  Future<AuthSessionState> getSessionState() async {
    return _mapAccount(_client.currentAccount);
  }

  @override
  Future<AuthActionResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (!_client.isConfigured) {
      return const AuthActionResult(
        sessionState: AuthSessionState.unconfigured(),
        userMessage:
            'Cloud backup is not configured in this build yet. Add Supabase credentials to enable optional sign-in.',
      );
    }

    final result = await _client.signInWithEmail(
      email: email,
      password: password,
    );
    final sessionState = _mapAccount(result.account);
    return AuthActionResult(
      sessionState: sessionState,
      userMessage: sessionState.isSignedIn
          ? 'Signed in. Forge can now link this device\'s local data to your account.'
          : 'Sign-in did not create an active session.',
    );
  }

  @override
  Future<AuthActionResult> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    if (!_client.isConfigured) {
      return const AuthActionResult(
        sessionState: AuthSessionState.unconfigured(),
        userMessage:
            'Cloud backup is not configured in this build yet. Add Supabase credentials to enable optional sign-in.',
      );
    }

    final result = await _client.signUpWithEmail(
      email: email,
      password: password,
    );
    final sessionState = _mapAccount(result.account);
    return AuthActionResult(
      sessionState: sessionState,
      requiresEmailConfirmation: result.requiresEmailConfirmation,
      userMessage: result.requiresEmailConfirmation
          ? 'Account created. Confirm the email, then sign in to link this device.'
          : sessionState.isSignedIn
          ? 'Account created and signed in. Forge can now link this device\'s local data to your account.'
          : 'Account created, but there is no active session yet.',
    );
  }

  @override
  Future<void> signOut() {
    return _client.signOut();
  }

  @override
  Future<void> updateLinkedMetadata({
    required String installationId,
    String? displayName,
  }) {
    return _client.updateUserMetadata({
      'forge_installation_id': installationId,
      if ((displayName ?? '').trim().isNotEmpty)
        'forge_local_display_name': displayName!.trim(),
      'forge_linked_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  @override
  Stream<AuthSessionState> watchSessionState() {
    if (!_client.isConfigured) {
      return Stream<AuthSessionState>.value(const AuthSessionState.unconfigured());
    }
    return Stream<AuthSessionState>.multi((controller) {
      controller.add(_mapAccount(_client.currentAccount));
      final subscription = _client.authStateChanges().listen(
        (account) {
          controller.add(_mapAccount(account));
        },
        onError: controller.addError,
      );
      controller.onCancel = subscription.cancel;
    });
  }

  AuthSessionState _mapAccount(CloudAuthAccount? account) {
    if (!_client.isConfigured) {
      return const AuthSessionState.unconfigured();
    }
    if (account == null) {
      return const AuthSessionState.signedOut();
    }
    return AuthSessionState.signedIn(
      accountId: account.id,
      email: account.email,
    );
  }
}
