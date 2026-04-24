import 'package:forge/shared/enums/sync_domain.dart';

class RemoteBackupSummary {
  const RemoteBackupSummary({
    required this.installationId,
    required this.isCurrentDevice,
    required this.lastUploadedAt,
    required this.lastUpdatedAt,
    required this.availableDomains,
    required this.payloadVersion,
  });

  final String installationId;
  final bool isCurrentDevice;
  final DateTime lastUploadedAt;
  final DateTime lastUpdatedAt;
  final List<SyncDomain> availableDomains;
  final int payloadVersion;
}
