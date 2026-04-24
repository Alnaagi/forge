class LinkedAccountState {
  const LinkedAccountState({
    required this.installationId,
    required this.accountId,
    this.email,
    required this.linkedAt,
  });

  final String installationId;
  final String accountId;
  final String? email;
  final DateTime linkedAt;
}
