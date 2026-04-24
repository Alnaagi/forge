import 'package:flutter_test/flutter_test.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';

void main() {
  const converter = UnitConverter();

  test('converts pounds to kilograms', () {
    final result = converter.toKilograms(225, WeightUnit.pounds);

    expect(result, closeTo(102.058, 0.001));
  });

  test('converts inches to centimeters', () {
    final result = converter.toCentimeters(10, BodyMetricUnit.inches);

    expect(result, closeTo(25.4, 0.001));
  });
}
