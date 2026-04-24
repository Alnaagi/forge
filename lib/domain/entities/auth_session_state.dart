class AuthSessionState {
  const AuthSessionState({
    required this.isBackendConfigured,
    required this.isSignedIn,
    this.accountId,
    this.email,
  });

  const AuthSessionState.unconfigured()
    : isBackendConfigured = false,
      isSignedIn = false,
      accountId = null,
      email = null;

  const AuthSessionState.signedOut()
    : isBackendConfigured = true,
      isSignedIn = false,
      accountId = null,
      email = null;

  const AuthSessionState.signedIn({
    required this.accountId,
    required this.email,
  }) : isBackendConfigured = true,
       isSignedIn = true;

  final bool isBackendConfigured;
  final bool isSignedIn;
  final String? accountId;
  final String? email;

  bool get canAttemptSignIn => isBackendConfigured && !isSignedIn;
}
