import 'package:drift/drift.dart';
import 'package:forge/data/local/db/tables/foods_table.dart';
import 'package:forge/data/local/db/tables/saved_meals_table.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';

class SavedMealItemsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get savedMealId =>
      text().references(SavedMealsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get foodId =>
      text().references(FoodsTable, #id, onDelete: KeyAction.restrict)();
  RealColumn get originalQuantityValue => real()();
  TextColumn get originalQuantityUnit => textEnum<FoodQuantityUnit>()();
  RealColumn get canonicalQuantityGrams => real().nullable()();
  RealColumn get canonicalQuantityMilliliters => real().nullable()();
  IntColumn get orderIndex => integer()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(saved_meal_id, order_index)'];
}
