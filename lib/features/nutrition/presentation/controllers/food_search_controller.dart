import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/food_detail.dart';

final foodSearchQueryProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final foodSearchResultsProvider = FutureProvider.autoDispose<List<FoodDetail>>((
  ref,
) async {
  final query = ref.watch(foodSearchQueryProvider);
  if (query.trim().isNotEmpty) {
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }
  return ref.watch(nutritionRepositoryProvider).searchFoods(query);
});
