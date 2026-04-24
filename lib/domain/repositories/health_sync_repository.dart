import 'package:forge/domain/entities/health_sync_connection_status.dart';
import 'package:forge/domain/entities/health_sync_record.dart';
import 'package:forge/domain/entities/health_sync_run_result.dart';

abstract class HealthSyncRepository {
  Future<List<HealthSyncRecord>> getAll();
  Future<void> upsertRecords(List<HealthSyncRecord> records);
  Future<HealthSyncConnectionStatus> getConnectionStatus();
  Future<HealthSyncConnectionStatus> requestPermissions();
  Future<void> openInstallScreen();
  Future<DateTime?> getLastSyncAt();
  Future<String?> getLastSyncError();
  Future<HealthSyncRunResult> syncNow();
}
