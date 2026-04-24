import 'package:forge/application/services/cloud_auth_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CloudBackupBatchUpload {
  const CloudBackupBatchUpload({
    required this.accountId,
    required this.installationId,
    required this.batchKey,
    required this.domainKey,
    required this.operationKey,
    required this.payloadVersion,
    required this.snapshotPreparedAt,
    required this.uploadedAt,
    required this.payloadJson,
  });

  final String accountId;
  final String installationId;
  final String batchKey;
  final String domainKey;
  final String operationKey;
  final int payloadVersion;
  final DateTime snapshotPreparedAt;
  final DateTime uploadedAt;
  final Map<String, Object?> payloadJson;
}

class CloudBackupBatchRecord {
  const CloudBackupBatchRecord({
    required this.accountId,
    required this.installationId,
    required this.batchKey,
    required this.domainKey,
    required this.operationKey,
    required this.payloadVersion,
    required this.snapshotPreparedAt,
    required this.uploadedAt,
    required this.updatedAt,
    required this.payloadJson,
  });

  final String accountId;
  final String installationId;
  final String batchKey;
  final String domainKey;
  final String operationKey;
  final int payloadVersion;
  final DateTime snapshotPreparedAt;
  final DateTime uploadedAt;
  final DateTime updatedAt;
  final Map<String, Object?> payloadJson;
}

abstract class CloudBackupClient {
  bool get isConfigured;
  String? get currentAccountId;
  Future<void> uploadBatch(CloudBackupBatchUpload batch);
  Future<List<CloudBackupBatchRecord>> listBatches();
}

class SupabaseCloudBackupClient implements CloudBackupClient {
  const SupabaseCloudBackupClient(this._config);

  static const tableName = 'backup_snapshot_batches';

  final CloudAuthConfig _config;

  SupabaseClient get _client => Supabase.instance.client;

  @override
  bool get isConfigured => _config.isConfigured;

  @override
  String? get currentAccountId => _client.auth.currentUser?.id;

  @override
  Future<void> uploadBatch(CloudBackupBatchUpload batch) async {
    if (!isConfigured) {
      throw StateError('Cloud backup is not configured in this build yet.');
    }

    await _client.from(tableName).upsert({
      'account_id': batch.accountId,
      'installation_id': batch.installationId,
      'batch_key': batch.batchKey,
      'domain_key': batch.domainKey,
      'operation_key': batch.operationKey,
      'payload_version': batch.payloadVersion,
      'snapshot_prepared_at': batch.snapshotPreparedAt
          .toUtc()
          .toIso8601String(),
      'uploaded_at': batch.uploadedAt.toUtc().toIso8601String(),
      'updated_at': batch.uploadedAt.toUtc().toIso8601String(),
      'payload_json': batch.payloadJson,
    }, onConflict: 'account_id,installation_id,domain_key,operation_key');
  }

  @override
  Future<List<CloudBackupBatchRecord>> listBatches() async {
    if (!isConfigured) {
      throw StateError('Cloud backup is not configured in this build yet.');
    }
    final accountId = currentAccountId;
    if (accountId == null || accountId.isEmpty) {
      throw StateError('Sign in before browsing remote backups.');
    }

    final rows = await _client
        .from(tableName)
        .select()
        .eq('account_id', accountId)
        .order('updated_at', ascending: false);

    return rows
        .map((row) => _mapBackupRow(Map<String, dynamic>.from(row)))
        .toList(growable: false);
  }

  CloudBackupBatchRecord _mapBackupRow(Map<String, dynamic> row) {
    return CloudBackupBatchRecord(
      accountId: row['account_id'] as String,
      installationId: row['installation_id'] as String,
      batchKey: row['batch_key'] as String,
      domainKey: row['domain_key'] as String,
      operationKey: row['operation_key'] as String,
      payloadVersion: (row['payload_version'] as num?)?.toInt() ?? 1,
      snapshotPreparedAt: DateTime.parse(row['snapshot_prepared_at'] as String),
      uploadedAt: DateTime.parse(row['uploaded_at'] as String),
      updatedAt: DateTime.parse(
        (row['updated_at'] ?? row['uploaded_at']) as String,
      ),
      payloadJson: Map<String, Object?>.from(
        (row['payload_json'] as Map?)?.cast<String, Object?>() ??
            const <String, Object?>{},
      ),
    );
  }
}

class DisabledCloudBackupClient implements CloudBackupClient {
  const DisabledCloudBackupClient();

  @override
  bool get isConfigured => false;

  @override
  String? get currentAccountId => null;

  @override
  Future<void> uploadBatch(CloudBackupBatchUpload batch) async {
    throw StateError('Cloud backup is not configured in this build yet.');
  }

  @override
  Future<List<CloudBackupBatchRecord>> listBatches() async {
    throw StateError('Cloud backup is not configured in this build yet.');
  }
}
