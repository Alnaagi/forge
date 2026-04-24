class SyncUploadRunResult {
  const SyncUploadRunResult({
    required this.attemptedCount,
    required this.uploadedCount,
    required this.failedCount,
    required this.skippedCount,
    this.lastError,
    required this.completedAt,
  });

  final int attemptedCount;
  final int uploadedCount;
  final int failedCount;
  final int skippedCount;
  final String? lastError;
  final DateTime completedAt;
}
