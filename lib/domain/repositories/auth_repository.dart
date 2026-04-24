import 'package:forge/domain/entities/auth_action_result.dart';
import 'package:forge/domain/entities/auth_session_state.dart';

abstract class AuthRepository {
  Stream<AuthSessionState> watchSessionState();
  Future<AuthSessionState> getSessionState();
  Future<AuthActionResult> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<AuthActionResult> signInWithEmail({
    required String email,
    required String password,
  });
  Future<void> updateLinkedMetadata({
    required String installationId,
    String? displayName,
  });
  Future<void> signOut();
}
