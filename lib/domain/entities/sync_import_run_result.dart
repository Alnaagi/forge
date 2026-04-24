import 'package:forge/shared/enums/sync_domain.dart';

class SyncDomainImportResult {
  const SyncDomainImportResult({
    required this.domain,
    required this.importedCount,
    required this.skippedCount,
    required this.summary,
  });

  final SyncDomain domain;
  final int importedCount;
  final int skippedCount;
  final String summary;
}

class SyncImportRunResult {
  const SyncImportRunResult({
    required this.domainResults,
    required this.completedAt,
  });

  final List<SyncDomainImportResult> domainResults;
  final DateTime completedAt;

  int get importedCount =>
      domainResults.fold(0, (sum, result) => sum + result.importedCount);

  int get skippedCount =>
      domainResults.fold(0, (sum, result) => sum + result.skippedCount);
}
