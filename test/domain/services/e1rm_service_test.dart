import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/services/e1rm_service.dart';

void main() {
  const service = E1rmService();

  test('returns e1rm estimate using the epley formula', () {
    final estimate = service.estimate(weightKilograms: 100, reps: 5);

    expect(estimate, closeTo(116.666, 0.001));
  });
}
