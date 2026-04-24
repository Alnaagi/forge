class RelativeStrengthService {
  const RelativeStrengthService();

  double calculate({
    required double estimatedOneRepMaxKilograms,
    required double bodyWeightKilograms,
  }) {
    if (bodyWeightKilograms == 0) {
      return 0;
    }

    return estimatedOneRepMaxKilograms / bodyWeightKilograms;
  }
}
