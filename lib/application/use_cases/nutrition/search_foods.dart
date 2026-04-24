import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/repositories/nutrition_repository.dart';

class SearchFoods {
  const SearchFoods(this._repository);

  final NutritionRepository _repository;

  Future<List<FoodDetail>> call(String query) {
    return _repository.searchFoods(query);
  }
}
