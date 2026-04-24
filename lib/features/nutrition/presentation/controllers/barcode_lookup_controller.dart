import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/constants/app_constants.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/food_detail.dart';

final barcodeLookupQueryProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final barcodeLookupControllerProvider = Provider<BarcodeLookupController>((
  ref,
) {
  return BarcodeLookupController(ref);
});

final barcodeLookupResultProvider = FutureProvider.autoDispose<FoodDetail?>((
  ref,
) async {
  final barcode = ref.watch(barcodeLookupQueryProvider).trim();
  if (barcode.isEmpty) {
    return null;
  }
  return ref.watch(nutritionRepositoryProvider).lookupFoodByBarcode(barcode);
});

class BarcodeLookupController {
  BarcodeLookupController(this._ref);

  final Ref _ref;

  String? normalize(String rawValue) {
    final digitsOnly = rawValue.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < AppConstants.barcodeMinLength ||
        digitsOnly.length > AppConstants.barcodeMaxLength) {
      return null;
    }
    return digitsOnly;
  }

  bool submit(String rawValue) {
    final normalized = normalize(rawValue);
    if (normalized == null) {
      return false;
    }
    _ref.read(barcodeLookupQueryProvider.notifier).state = normalized;
    return true;
  }
}
