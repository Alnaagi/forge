import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/services/volume_service.dart';

void main() {
  const service = VolumeService();

  test('calculates volume from kilograms reps and sets', () {
    final volume = service.calculate(weightKilograms: 100, reps: 5, sets: 3);

    expect(volume, 1500);
  });
}
