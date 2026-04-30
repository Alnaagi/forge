class BodyBaselineMetrics {
  const BodyBaselineMetrics({
    required this.bmi,
    required this.bmiLabel,
    required this.waistToHeightRatio,
    required this.waistToHeightLabel,
  });

  final double? bmi;
  final String? bmiLabel;
  final double? waistToHeightRatio;
  final String? waistToHeightLabel;
}

class BodyBaselineService {
  const BodyBaselineService();

  BodyBaselineMetrics calculate({
    double? weightKilograms,
    double? heightCentimeters,
    double? waistCentimeters,
  }) {
    final bmi = _bmi(weightKilograms, heightCentimeters);
    final waistRatio = _waistToHeightRatio(waistCentimeters, heightCentimeters);

    return BodyBaselineMetrics(
      bmi: bmi,
      bmiLabel: bmi == null ? null : _bmiLabel(bmi),
      waistToHeightRatio: waistRatio,
      waistToHeightLabel: waistRatio == null
          ? null
          : _waistRatioLabel(waistRatio),
    );
  }

  double? _bmi(double? weightKilograms, double? heightCentimeters) {
    if (weightKilograms == null ||
        heightCentimeters == null ||
        weightKilograms <= 0 ||
        heightCentimeters <= 0) {
      return null;
    }
    final heightMeters = heightCentimeters / 100;
    return weightKilograms / (heightMeters * heightMeters);
  }

  double? _waistToHeightRatio(
    double? waistCentimeters,
    double? heightCentimeters,
  ) {
    if (waistCentimeters == null ||
        heightCentimeters == null ||
        waistCentimeters <= 0 ||
        heightCentimeters <= 0) {
      return null;
    }
    return waistCentimeters / heightCentimeters;
  }

  String _bmiLabel(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight range';
    }
    if (bmi < 25) {
      return 'General healthy range';
    }
    if (bmi < 30) {
      return 'Overweight range';
    }
    return 'Obesity range';
  }

  String _waistRatioLabel(double ratio) {
    if (ratio < 0.43) {
      return 'Low waist-to-height ratio';
    }
    if (ratio < 0.50) {
      return 'Generally favorable ratio';
    }
    if (ratio < 0.60) {
      return 'Worth monitoring';
    }
    return 'High ratio, track carefully';
  }
}
