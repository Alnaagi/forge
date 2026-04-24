import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/health_profile.dart';
import 'package:forge/domain/entities/health_status_log.dart';

extension HealthProfileDataMapper on HealthProfilesTableData {
  HealthProfile toDomain() {
    return HealthProfile(
      id: id,
      healthConditions: _splitList(healthConditions),
      medications: _splitList(medications),
      allergies: _splitList(allergies),
      notes: notes,
      checkInCadenceHours: checkInCadenceHours,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension HealthProfileCompanionMapper on HealthProfile {
  HealthProfilesTableCompanion toCompanion() {
    return HealthProfilesTableCompanion(
      id: Value(id),
      healthConditions: Value(_joinList(healthConditions)),
      medications: Value(_joinList(medications)),
      allergies: Value(_joinList(allergies)),
      notes: Value(notes),
      checkInCadenceHours: Value(checkInCadenceHours),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension HealthStatusLogDataMapper on HealthStatusLogsTableData {
  HealthStatusLog toDomain() {
    return HealthStatusLog(
      id: id,
      type: type,
      title: title,
      severity: severity,
      loggedAt: loggedAt,
      startedAt: startedAt,
      resolvedAt: resolvedAt,
      energyLevel: energyLevel,
      bodyArea: bodyArea,
      symptomTags: _splitList(symptomTags),
      possibleTrigger: possibleTrigger,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension HealthStatusLogCompanionMapper on HealthStatusLog {
  HealthStatusLogsTableCompanion toCompanion() {
    return HealthStatusLogsTableCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      severity: Value(severity),
      loggedAt: Value(loggedAt),
      startedAt: Value(startedAt),
      resolvedAt: Value(resolvedAt),
      energyLevel: Value(energyLevel),
      bodyArea: Value(bodyArea),
      symptomTags: Value(_joinList(symptomTags)),
      possibleTrigger: Value(possibleTrigger),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

List<String> _splitList(String rawValue) {
  return rawValue
      .split('\n')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList(growable: false);
}

String _joinList(List<String> values) {
  return values
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .join('\n');
}
