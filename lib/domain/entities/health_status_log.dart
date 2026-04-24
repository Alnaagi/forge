import 'package:forge/shared/enums/health_entry_type.dart';

class HealthStatusLog {
  const HealthStatusLog({
    required this.id,
    required this.type,
    required this.title,
    required this.severity,
    required this.loggedAt,
    this.startedAt,
    this.resolvedAt,
    this.energyLevel,
    this.bodyArea,
    this.symptomTags = const [],
    this.possibleTrigger,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final HealthEntryType type;
  final String title;
  final int severity;
  final DateTime loggedAt;
  final DateTime? startedAt;
  final DateTime? resolvedAt;
  final int? energyLevel;
  final String? bodyArea;
  final List<String> symptomTags;
  final String? possibleTrigger;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isActive => resolvedAt == null;
}
