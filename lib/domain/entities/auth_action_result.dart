import 'package:forge/domain/entities/auth_session_state.dart';

class AuthActionResult {
  const AuthActionResult({
    required this.sessionState,
    required this.userMessage,
    this.requiresEmailConfirmation = false,
  });

  final AuthSessionState sessionState;
  final String userMessage;
  final bool requiresEmailConfirmation;
}
