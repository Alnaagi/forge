import 'package:forge/domain/entities/remote_backup_summary.dart';
import 'package:forge/domain/entities/restore_support_level.dart';
import 'package:forge/shared/enums/sync_domain.dart';

class RemoteBackupDomainPreview {
  const RemoteBackupDomainPreview({
    required this.domain,
    required this.supportLevel,
    required this.availableRecordCount,
    required this.importableRecordCount,
    required this.summary,
  });

  final SyncDomain domain;
  final RestoreSupportLevel supportLevel;
  final int availableRecordCount;
  final int importableRecordCount;
  final String summary;

  bool get canImport =>
      supportLevel != RestoreSupportLevel.deferred && importableRecordCount > 0;
}

class RemoteBackupPreview {
  const RemoteBackupPreview({
    required this.backup,
    required this.domains,
    required this.notice,
  });

  final RemoteBackupSummary backup;
  final List<RemoteBackupDomainPreview> domains;
  final String notice;

  bool get hasImportableDomains => domains.any((domain) => domain.canImport);

  List<RemoteBackupDomainPreview> get importableDomains =>
      domains.where((domain) => domain.canImport).toList(growable: false);
}
