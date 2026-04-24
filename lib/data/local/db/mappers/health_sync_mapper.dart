import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/health_sync_record.dart';

extension HealthSyncRecordDataMapper on HealthSyncRecordsTableData {
  HealthSyncRecord toDomain() {
    return HealthSyncRecord(
      id: id,
      source: source,
      recordType: recordType,
      externalId: externalId,
      payloadJson: payloadJson,
      recordedAt: recordedAt,
      createdAt: createdAt,
    );
  }
}

extension HealthSyncRecordCompanionMapper on HealthSyncRecord {
  HealthSyncRecordsTableCompanion toCompanion() {
    return HealthSyncRecordsTableCompanion(
      id: Value(id),
      source: Value(source),
      recordType: Value(recordType),
      externalId: Value(externalId),
      payloadJson: Value(payloadJson),
      recordedAt: Value(recordedAt),
      createdAt: Value(createdAt),
    );
  }
}
