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
import 'package:forge/data/local/db/migrations/migration_v5.dart';
import 'package:forge/data/local/db/seeds/built_in_exercises_seed.dart';
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
  int get schemaVersion => MigrationV5.version;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await MigrationV5.createIndexes(this);
    },
    onUpgrade: (m, from, to) async {
      await MigrationV5.onUpgrade(this, m, from, to);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await _seedBuiltInExercises();
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
}
