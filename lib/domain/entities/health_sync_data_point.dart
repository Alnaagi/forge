enum HealthSyncDataType { steps, heartRate, sleep, bodyWeight }

extension HealthSyncDataTypeStorage on HealthSyncDataType {
  String get storageKey => switch (this) {
    HealthSyncDataType.steps => 'steps',
    HealthSyncDataType.heartRate => 'heart_rate',
    HealthSyncDataType.sleep => 'sleep',
    HealthSyncDataType.bodyWeight => 'body_weight',
  };

  String get label => switch (this) {
    HealthSyncDataType.steps => 'Steps',
    HealthSyncDataType.heartRate => 'Heart Rate',
    HealthSyncDataType.sleep => 'Sleep',
    HealthSyncDataType.bodyWeight => 'Body Weight',
  };

  static HealthSyncDataType fromStorageKey(String rawValue) {
    for (final type in HealthSyncDataType.values) {
      if (type.storageKey == rawValue) {
        return type;
      }
    }
    throw ArgumentError.value(rawValue, 'rawValue', 'Unknown sync data type');
  }
}

class HealthSyncDataPoint {
  const HealthSyncDataPoint({
    required this.type,
    required this.externalId,
    required this.numericValue,
    required this.unit,
    required this.startAt,
    required this.endAt,
    required this.recordedAt,
    required this.sourceId,
    required this.sourceName,
    required this.sourceDeviceId,
    required this.recordingMethod,
    required this.rawPayload,
  });

  final HealthSyncDataType type;
  final String externalId;
  final double numericValue;
  final String unit;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime recordedAt;
  final String sourceId;
  final String sourceName;
  final String sourceDeviceId;
  final String recordingMethod;
  final Map<String, dynamic> rawPayload;

  Map<String, dynamic> toJson() {
    return {
      'type': type.storageKey,
      'externalId': externalId,
      'numericValue': numericValue,
      'unit': unit,
      'startAt': startAt.toIso8601String(),
      'endAt': endAt.toIso8601String(),
      'recordedAt': recordedAt.toIso8601String(),
      'sourceId': sourceId,
      'sourceName': sourceName,
      'sourceDeviceId': sourceDeviceId,
      'recordingMethod': recordingMethod,
      'rawPayload': rawPayload,
    };
  }

  factory HealthSyncDataPoint.fromJson(Map<String, dynamic> json) {
    return HealthSyncDataPoint(
      type: HealthSyncDataTypeStorage.fromStorageKey(json['type'] as String),
      externalId: json['externalId'] as String,
      numericValue: (json['numericValue'] as num).toDouble(),
      unit: json['unit'] as String,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      sourceId: json['sourceId'] as String? ?? '',
      sourceName: json['sourceName'] as String? ?? '',
      sourceDeviceId: json['sourceDeviceId'] as String? ?? '',
      recordingMethod: json['recordingMethod'] as String? ?? 'unknown',
      rawPayload:
          (json['rawPayload'] as Map?)?.cast<String, dynamic>() ?? const {},
    );
  }
}
