import 'package:drift/drift.dart';
import 'package:forge/data/local/db/tables/app_settings_table.dart';
import 'package:forge/data/local/db/tables/body_logs_table.dart';
import 'package:forge/data/local/db/tables/exercises_table.dart';
import 'package:forge/data/local/db/tables/food_portions_table.dart';
import 'package:forge/data/local/db/tables/foods_table.dart';
import 'package:forge/data/local/db/tables/goals_table.dart';
import 'package:forge/data/local/db/tables/health_profiles_table.dart';
import 'package:forge/data/local/db/tables/health_sync_records_table.dart';
import 'package:forge/data/local/db/tables/health_status_logs_table.dart';
import 'package:forge/data/local/db/tables/hydration_logs_table.dart';
import 'package:forge/data/local/db/tables/insights_table.dart';
import 'package:forge/data/local/db/tables/meal_entries_table.dart';
import 'package:forge/data/local/db/tables/reminders_table.dart';
import 'package:forge/data/local/db/tables/saved_meal_items_table.dart';
import 'package:forge/data/local/db/tables/saved_meals_table.dart';
import 'package:forge/data/local/db/tables/set_entries_table.dart';
import 'package:forge/data/local/db/tables/sync_queue_table.dart';
import 'package:forge/data/local/db/tables/users_table.dart';
import 'package:forge/data/local/db/tables/workout_exercise_entries_table.dart';
import 'package:forge/data/local/db/tables/workout_sessions_table.dart';
import 'package:forge/data/local/db/tables/workout_template_items_table.dart';
import 'package:forge/data/local/db/tables/workout_templates_table.dart';
import 'package:forge/data/local/db/db_connection.dart';
import 'package:forge/data/local/db/migrations/migration_v6.dart';
import 'package:forge/data/local/db/seeds/built_in_exercises_seed.dart';
import 'package:forge/data/local/db/seeds/common_foods_seed.dart';
import 'package:forge/shared/enums/activity_level.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/enums/health_entry_type.dart';
import 'package:forge/shared/enums/insight_category.dart';
import 'package:forge/shared/enums/insight_severity.dart';
import 'package:forge/shared/enums/insight_status.dart';
import 'package:forge/shared/enums/meal_type.dart';
import 'package:forge/shared/enums/reminder_type.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/enums/sync_source.dart';
import 'package:forge/shared/enums/sync_domain.dart';
import 'package:forge/shared/enums/sync_queue_operation.dart';
import 'package:forge/shared/enums/sync_queue_status.dart';
import 'package:forge/shared/enums/volume_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UsersTable,
    GoalsTable,
    ExercisesTable,
    WorkoutTemplatesTable,
    WorkoutTemplateItemsTable,
    WorkoutSessionsTable,
    WorkoutExerciseEntriesTable,
    SetEntriesTable,
    BodyLogsTable,
    FoodPortionsTable,
    FoodsTable,
    MealEntriesTable,
    HydrationLogsTable,
    SavedMealsTable,
    SavedMealItemsTable,
    RemindersTable,
    HealthProfilesTable,
    HealthSyncRecordsTable,
    HealthStatusLogsTable,
    InsightsTable,
    AppSettingsTable,
    SyncQueueTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());
  AppDatabase.test(super.executor);

  @override
  int get schemaVersion => MigrationV6.version;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await MigrationV6.createIndexes(this);
    },
    onUpgrade: (m, from, to) async {
      await MigrationV6.onUpgrade(this, m, from, to);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await _seedBuiltInExercises();
      await _seedCommonFoods();
    },
  );

  Future<void> _seedBuiltInExercises() async {
    final seed = const BuiltInExercisesSeed().all();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        exercisesTable,
        seed
            .map(
              (exercise) => ExercisesTableCompanion.insert(
                id: exercise.id,
                name: exercise.name,
                primaryMuscleGroup: exercise.primaryMuscleGroup,
                isBuiltIn: Value(exercise.isBuiltIn),
                notes: Value(exercise.notes),
                createdAt: exercise.createdAt,
                updatedAt: exercise.updatedAt,
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> _seedCommonFoods() async {
    final seed = const CommonFoodsSeed().all();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        foodsTable,
        seed
            .map(
              (food) => FoodsTableCompanion.insert(
                id: food.id,
                name: food.name,
                caloriesPer100g: food.caloriesPer100g,
                proteinPer100g: food.proteinPer100g,
                carbsPer100g: food.carbsPer100g,
                fatPer100g: food.fatPer100g,
                source: food.source,
                isUserEdited: Value(food.isUserEdited),
                createdAt: food.createdAt,
                updatedAt: food.updatedAt,
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> resetLocalData() async {
    await transaction(() async {
      await delete(setEntriesTable).go();
      await delete(workoutExerciseEntriesTable).go();
      await delete(workoutSessionsTable).go();
      await delete(workoutTemplateItemsTable).go();
      await delete(workoutTemplatesTable).go();
      await delete(mealEntriesTable).go();
      await delete(savedMealItemsTable).go();
      await delete(savedMealsTable).go();
      await delete(foodPortionsTable).go();
      await delete(foodsTable).go();
      await delete(hydrationLogsTable).go();
      await delete(bodyLogsTable).go();
      await delete(remindersTable).go();
      await delete(healthSyncRecordsTable).go();
      await delete(healthStatusLogsTable).go();
      await delete(healthProfilesTable).go();
      await delete(insightsTable).go();
      await delete(syncQueueTable).go();
      await delete(goalsTable).go();
      await delete(appSettingsTable).go();
      await delete(usersTable).go();
      await delete(exercisesTable).go();
    });

    await _seedBuiltInExercises();
    await _seedCommonFoods();
  }
}
