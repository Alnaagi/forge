import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class FoodDetailRow {
  const FoodDetailRow({required this.food, required this.portion});

  final FoodsTableData food;
  final FoodPortionsTableData? portion;
}

class MealEntryDetailRow {
  const MealEntryDetailRow({required this.entry, required this.food});

  final MealEntriesTableData entry;
  final FoodsTableData food;
}

class SavedMealDetailRow {
  const SavedMealDetailRow({
    required this.savedMeal,
    required this.item,
    required this.food,
  });

  final SavedMealsTableData savedMeal;
  final SavedMealItemsTableData? item;
  final FoodsTableData? food;
}

class NutritionDao {
  const NutritionDao(this.database);

  final AppDatabase database;

  Future<List<FoodDetailRow>> searchFoodDetails(String query) {
    final normalized = query.trim();
    final statement =
        database.select(database.foodsTable).join([
          leftOuterJoin(
            database.foodPortionsTable,
            database.foodPortionsTable.foodId.equalsExp(database.foodsTable.id),
          ),
        ])..orderBy([
          OrderingTerm.asc(database.foodsTable.name),
          OrderingTerm.asc(database.foodPortionsTable.sortOrder),
        ]);

    if (normalized.isNotEmpty) {
      statement.where(
        database.foodsTable.name.like('%$normalized%') |
            database.foodsTable.brandName.like('%$normalized%'),
      );
    }

    return statement
        .map(
          (row) => FoodDetailRow(
            food: row.readTable(database.foodsTable),
            portion: row.readTableOrNull(database.foodPortionsTable),
          ),
        )
        .get();
  }

  Future<List<FoodDetailRow>> getFoodDetailRows({
    String? foodId,
    List<String>? foodIds,
  }) {
    final statement =
        database.select(database.foodsTable).join([
          leftOuterJoin(
            database.foodPortionsTable,
            database.foodPortionsTable.foodId.equalsExp(database.foodsTable.id),
          ),
        ])..orderBy([
          OrderingTerm.asc(database.foodsTable.name),
          OrderingTerm.asc(database.foodPortionsTable.sortOrder),
        ]);

    if (foodId != null) {
      statement.where(database.foodsTable.id.equals(foodId));
    } else if (foodIds != null && foodIds.isNotEmpty) {
      statement.where(database.foodsTable.id.isIn(foodIds));
    }

    return statement
        .map(
          (row) => FoodDetailRow(
            food: row.readTable(database.foodsTable),
            portion: row.readTableOrNull(database.foodPortionsTable),
          ),
        )
        .get();
  }

  Future<FoodsTableData?> getFoodByBarcode(String barcode) {
    return (database.select(
      database.foodsTable,
    )..where((table) => table.barcode.equals(barcode))).getSingleOrNull();
  }

  Future<FoodsTableData?> getFoodByNameAndBrand(
    String name,
    String? brandName,
  ) {
    final query = database.select(database.foodsTable)
      ..where((table) => table.name.equals(name));

    if (brandName == null || brandName.trim().isEmpty) {
      query.where((table) => table.brandName.isNull());
    } else {
      query.where((table) => table.brandName.equals(brandName));
    }

    return query.getSingleOrNull();
  }

  Future<void> upsertFood(FoodsTableCompanion companion) {
    return database.into(database.foodsTable).insertOnConflictUpdate(companion);
  }

  Future<void> replaceFoodPortions(
    String foodId,
    List<FoodPortionsTableCompanion> companions,
  ) async {
    await database.transaction(() async {
      await (database.delete(
        database.foodPortionsTable,
      )..where((table) => table.foodId.equals(foodId))).go();

      if (companions.isNotEmpty) {
        await database.batch((batch) {
          batch.insertAll(database.foodPortionsTable, companions);
        });
      }
    });
  }

  Future<void> upsertMealEntry(MealEntriesTableCompanion companion) {
    return database
        .into(database.mealEntriesTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> deleteMealEntry(String mealEntryId) {
    return (database.delete(
      database.mealEntriesTable,
    )..where((table) => table.id.equals(mealEntryId))).go();
  }

  Future<List<MealEntryDetailRow>> getMealEntryDetailsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));

    final statement =
        database.select(database.mealEntriesTable).join([
            innerJoin(
              database.foodsTable,
              database.foodsTable.id.equalsExp(
                database.mealEntriesTable.foodId,
              ),
            ),
          ])
          ..where(
            database.mealEntriesTable.loggedAt.isBiggerOrEqualValue(start) &
                database.mealEntriesTable.loggedAt.isSmallerThanValue(end),
          )
          ..orderBy([OrderingTerm.asc(database.mealEntriesTable.loggedAt)]);

    return statement
        .map(
          (row) => MealEntryDetailRow(
            entry: row.readTable(database.mealEntriesTable),
            food: row.readTable(database.foodsTable),
          ),
        )
        .get();
  }

  Future<MealEntryDetailRow?> getMealEntryDetailById(String mealEntryId) {
    final statement = database.select(database.mealEntriesTable).join([
      innerJoin(
        database.foodsTable,
        database.foodsTable.id.equalsExp(database.mealEntriesTable.foodId),
      ),
    ])..where(database.mealEntriesTable.id.equals(mealEntryId));

    return statement
        .map(
          (row) => MealEntryDetailRow(
            entry: row.readTable(database.mealEntriesTable),
            food: row.readTable(database.foodsTable),
          ),
        )
        .getSingleOrNull();
  }

  Future<void> upsertHydrationLog(HydrationLogsTableCompanion companion) {
    return database
        .into(database.hydrationLogsTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> deleteHydrationLog(String hydrationLogId) {
    return (database.delete(
      database.hydrationLogsTable,
    )..where((table) => table.id.equals(hydrationLogId))).go();
  }

  Future<List<HydrationLogsTableData>> getHydrationLogsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (database.select(database.hydrationLogsTable)
          ..where(
            (table) =>
                table.loggedAt.isBiggerOrEqualValue(start) &
                table.loggedAt.isSmallerThanValue(end),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.loggedAt)]))
        .get();
  }

  Future<List<SavedMealDetailRow>> getSavedMealDetailRows({
    String? savedMealId,
  }) {
    final statement =
        database.select(database.savedMealsTable).join([
          leftOuterJoin(
            database.savedMealItemsTable,
            database.savedMealItemsTable.savedMealId.equalsExp(
              database.savedMealsTable.id,
            ),
          ),
          leftOuterJoin(
            database.foodsTable,
            database.foodsTable.id.equalsExp(
              database.savedMealItemsTable.foodId,
            ),
          ),
        ])..orderBy([
          OrderingTerm.desc(database.savedMealsTable.updatedAt),
          OrderingTerm.asc(database.savedMealItemsTable.orderIndex),
        ]);

    if (savedMealId != null) {
      statement.where(database.savedMealsTable.id.equals(savedMealId));
    }

    return statement
        .map(
          (row) => SavedMealDetailRow(
            savedMeal: row.readTable(database.savedMealsTable),
            item: row.readTableOrNull(database.savedMealItemsTable),
            food: row.readTableOrNull(database.foodsTable),
          ),
        )
        .get();
  }

  Future<void> upsertSavedMeal(SavedMealsTableCompanion companion) {
    return database
        .into(database.savedMealsTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> deleteSavedMeal(String savedMealId) {
    return (database.delete(
      database.savedMealsTable,
    )..where((table) => table.id.equals(savedMealId))).go();
  }

  Future<void> replaceSavedMealItems(
    String savedMealId,
    List<SavedMealItemsTableCompanion> companions,
  ) async {
    await database.transaction(() async {
      await (database.delete(
        database.savedMealItemsTable,
      )..where((table) => table.savedMealId.equals(savedMealId))).go();

      if (companions.isNotEmpty) {
        await database.batch((batch) {
          batch.insertAll(database.savedMealItemsTable, companions);
        });
      }
    });
  }
}
