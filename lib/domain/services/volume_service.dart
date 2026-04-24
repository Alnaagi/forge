class VolumeService {
  const VolumeService();

  double calculate({
    required double weightKilograms,
    required int reps,
    required int sets,
  }) {
    return weightKilograms * reps * sets;
  }
}
