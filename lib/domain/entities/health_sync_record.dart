import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/sync_source.dart';

part 'health_sync_record.freezed.dart';

@freezed
class HealthSyncRecord with _$HealthSyncRecord {
  const factory HealthSyncRecord({
    required String id,
    required SyncSource source,
    required String recordType,
    String? externalId,
    required String payloadJson,
    required DateTime recordedAt,
    required DateTime createdAt,
  }) = _HealthSyncRecord;
}
