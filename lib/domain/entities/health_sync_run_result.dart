class HealthSyncRunResult {
  const HealthSyncRunResult({
    required this.importedRecordCount,
    required this.importedBodyWeightCount,
    required this.syncedAt,
  });

  final int importedRecordCount;
  final int importedBodyWeightCount;
  final DateTime syncedAt;
}
