import 'package:drift/drift.dart';
import 'package:forge/data/local/db/tables/foods_table.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';

class FoodPortionsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get foodId =>
      text().references(FoodsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get unit => textEnum<FoodQuantityUnit>()();
  TextColumn get label => text().withLength(min: 1, max: 120)();
  RealColumn get referenceAmount => real()();
  RealColumn get canonicalGrams => real().nullable()();
  RealColumn get canonicalMilliliters => real().nullable()();
  IntColumn get sortOrder => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(food_id, unit, sort_order)'];
}
