class E1rmService {
  const E1rmService();

  double estimate({required double weightKilograms, required int reps}) {
    if (reps <= 1) {
      return weightKilograms;
    }

    return weightKilograms * (1 + reps / 30);
  }
}
