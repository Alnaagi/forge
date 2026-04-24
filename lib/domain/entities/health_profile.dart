class HealthProfile {
  const HealthProfile({
    required this.id,
    required this.healthConditions,
    required this.medications,
    required this.allergies,
    this.notes,
    required this.checkInCadenceHours,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final List<String> healthConditions;
  final List<String> medications;
  final List<String> allergies;
  final String? notes;
  final int checkInCadenceHours;
  final DateTime createdAt;
  final DateTime updatedAt;
}
