import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class MigrationV2 {
  const MigrationV2._();

  static const version = 2;

  static const _indexStatements = <String>[
    'CREATE INDEX IF NOT EXISTS users_created_at_idx ON users_table (created_at)',
    'CREATE INDEX IF NOT EXISTS goals_is_active_started_at_idx ON goals_table (is_active, started_at DESC)',
    'CREATE INDEX IF NOT EXISTS workout_templates_created_at_idx ON workout_templates_table (created_at DESC)',
    'CREATE INDEX IF NOT EXISTS workout_template_items_template_order_idx ON workout_template_items_table (template_id, order_index)',
    'CREATE INDEX IF NOT EXISTS workout_sessions_started_at_idx ON workout_sessions_table (started_at DESC)',
    'CREATE INDEX IF NOT EXISTS workout_exercise_entries_session_order_idx ON workout_exercise_entries_table (session_id, order_index)',
    'CREATE INDEX IF NOT EXISTS set_entries_exercise_entry_order_idx ON set_entries_table (exercise_entry_id, order_index)',
    'CREATE INDEX IF NOT EXISTS body_logs_logged_at_idx ON body_logs_table (logged_at DESC)',
    'CREATE INDEX IF NOT EXISTS foods_name_idx ON foods_table (name)',
    'CREATE INDEX IF NOT EXISTS foods_barcode_idx ON foods_table (barcode)',
    'CREATE INDEX IF NOT EXISTS food_portions_food_unit_order_idx ON food_portions_table (food_id, unit, sort_order)',
    'CREATE INDEX IF NOT EXISTS meal_entries_food_logged_at_idx ON meal_entries_table (food_id, logged_at DESC)',
    'CREATE INDEX IF NOT EXISTS meal_entries_logged_at_idx ON meal_entries_table (logged_at DESC)',
    'CREATE INDEX IF NOT EXISTS hydration_logs_logged_at_idx ON hydration_logs_table (logged_at DESC)',
    'CREATE INDEX IF NOT EXISTS saved_meals_created_at_idx ON saved_meals_table (created_at DESC)',
    'CREATE INDEX IF NOT EXISTS saved_meal_items_saved_meal_order_idx ON saved_meal_items_table (saved_meal_id, order_index)',
    'CREATE INDEX IF NOT EXISTS reminders_enabled_type_idx ON reminders_table (is_enabled, type)',
    'CREATE INDEX IF NOT EXISTS health_sync_record_lookup_idx ON health_sync_records_table (source, record_type, external_id)',
    'CREATE INDEX IF NOT EXISTS insights_status_created_at_idx ON insights_table (status, created_at DESC)',
    'CREATE INDEX IF NOT EXISTS app_settings_updated_at_idx ON app_settings_table (updated_at DESC)',
  ];

  static Future<void> onUpgrade(
    AppDatabase database,
    Migrator migrator,
    int from,
    int to,
  ) async {
    if (from < 2) {
      await migrator.createTable(database.foodPortionsTable);
      await migrator.createTable(database.savedMealsTable);
      await migrator.createTable(database.savedMealItemsTable);
    }
    await createIndexes(database);
  }

  static Future<void> createIndexes(AppDatabase database) async {
    for (final statement in _indexStatements) {
      await database.customStatement(statement);
    }
  }
}
