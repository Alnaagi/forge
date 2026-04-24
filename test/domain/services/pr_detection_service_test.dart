import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/services/pr_detection_service.dart';

void main() {
  const service = PrDetectionService();

  test('detects new rep max when estimate exceeds previous best', () {
    final result = service.isNewRepMax(
      currentEstimate: 120,
      previousBestEstimate: 118,
    );

    expect(result, isTrue);
  });

  test('does not flag PR when estimate is equal to previous best', () {
    final result = service.isNewRepMax(
      currentEstimate: 118,
      previousBestEstimate: 118,
    );

    expect(result, isFalse);
  });
}
