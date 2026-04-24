import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/features/nutrition/presentation/controllers/barcode_lookup_controller.dart';

void main() {
  test('normalizes barcode input to digits only', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(barcodeLookupControllerProvider);

    expect(controller.normalize(' 0123-4567-89012 '), '0123456789012');
  });

  test('rejects barcodes outside the supported food barcode length', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(barcodeLookupControllerProvider);

    expect(controller.normalize('12345'), isNull);
    expect(controller.normalize('1234567890123456'), isNull);
  });
}
