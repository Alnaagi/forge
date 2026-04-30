import 'package:forge/domain/entities/food.dart';
import 'package:forge/shared/enums/sync_source.dart';

class CommonFoodsSeed {
  const CommonFoodsSeed();

  List<Food> all() {
    final now = DateTime(2026, 1, 1);
    return [
      _food('food-chicken-breast', 'Chicken Breast', 165, 31, 0, 3.6, now),
      _food('food-rice-cooked', 'Cooked White Rice', 130, 2.7, 28, 0.3, now),
      _food('food-eggs', 'Whole Eggs', 143, 13, 1.1, 9.5, now),
      _food('food-greek-yogurt', 'Greek Yogurt', 59, 10, 3.6, 0.4, now),
      _food('food-oats', 'Oats', 389, 17, 66, 7, now),
      _food('food-banana', 'Banana', 89, 1.1, 23, 0.3, now),
      _food('food-salmon', 'Salmon', 208, 20, 0, 13, now),
      _food('food-tuna', 'Tuna', 132, 28, 0, 1.3, now),
      _food('food-potato', 'Potato', 87, 1.9, 20, 0.1, now),
      _food('food-broccoli', 'Broccoli', 35, 2.4, 7.2, 0.4, now),
      _food('food-olive-oil', 'Olive Oil', 884, 0, 0, 100, now),
      _food('food-whey-protein', 'Whey Protein', 400, 80, 8, 6, now),
    ];
  }

  Food _food(
    String id,
    String name,
    int calories,
    double protein,
    double carbs,
    double fat,
    DateTime now,
  ) {
    return Food(
      id: id,
      name: name,
      caloriesPer100g: calories,
      proteinPer100g: protein,
      carbsPer100g: carbs,
      fatPer100g: fat,
      source: SyncSource.local,
      isUserEdited: false,
      createdAt: now,
      updatedAt: now,
    );
  }
}
