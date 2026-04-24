import 'package:drift/drift.dart';
import 'package:forge/data/local/db/tables/foods_table.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/enums/meal_type.dart';

class MealEntriesTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get foodId =>
      text().references(FoodsTable, #id, onDelete: KeyAction.restrict)();
  TextColumn get mealType => textEnum<MealType>()();
  RealColumn get originalQuantityValue => real()();
  TextColumn get originalQuantityUnit => textEnum<FoodQuantityUnit>()();
  RealColumn get canonicalQuantityGrams => real().nullable()();
  RealColumn get canonicalQuantityMilliliters => real().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
