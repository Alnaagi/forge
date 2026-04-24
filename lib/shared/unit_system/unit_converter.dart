import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/volume_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';

class UnitConverter {
  const UnitConverter();

  static const _poundsPerKilogram = 2.2046226218;
  static const _centimetersPerInch = 2.54;

  double toKilograms(double value, WeightUnit unit) {
    return switch (unit) {
      WeightUnit.kilograms => value,
      WeightUnit.pounds => value / _poundsPerKilogram,
    };
  }

  double fromKilograms(double kilograms, WeightUnit unit) {
    return switch (unit) {
      WeightUnit.kilograms => kilograms,
      WeightUnit.pounds => kilograms * _poundsPerKilogram,
    };
  }

  double toCentimeters(double value, BodyMetricUnit unit) {
    return switch (unit) {
      BodyMetricUnit.centimeters => value,
      BodyMetricUnit.inches => value * _centimetersPerInch,
    };
  }

  double fromCentimeters(double centimeters, BodyMetricUnit unit) {
    return switch (unit) {
      BodyMetricUnit.centimeters => centimeters,
      BodyMetricUnit.inches => centimeters / _centimetersPerInch,
    };
  }

  double toMilliliters(double value, VolumeUnit unit) {
    return switch (unit) {
      VolumeUnit.milliliters => value,
      VolumeUnit.fluidOunces => value * 29.5735295625,
    };
  }

  double fromMilliliters(double milliliters, VolumeUnit unit) {
    return switch (unit) {
      VolumeUnit.milliliters => milliliters,
      VolumeUnit.fluidOunces => milliliters / 29.5735295625,
    };
  }
}
