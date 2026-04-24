import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/shared/value_objects/date_range.dart';

class AnalyticsDao {
  const AnalyticsDao(this.database);

  final AppDatabase database;

  Future<double> getTotalVolume(DateRange range) async {
    final row = await database
        .customSelect(
          '''
      SELECT COALESCE(SUM(se.canonical_weight_kilograms * se.reps), 0) AS total_volume
      FROM set_entries_table se
      INNER JOIN workout_exercise_entries_table wee ON wee.id = se.exercise_entry_id
      INNER JOIN workout_sessions_table ws ON ws.id = wee.session_id
      WHERE ws.started_at >= ? AND ws.started_at < ?
      ''',
          variables: [
            Variable<DateTime>(range.start),
            Variable<DateTime>(range.end),
          ],
          readsFrom: {
            database.setEntriesTable,
            database.workoutExerciseEntriesTable,
            database.workoutSessionsTable,
          },
        )
        .getSingle();

    return row.read<double>('total_volume');
  }

  Future<double?> getLatestBodyWeightKilograms() async {
    final row = await database
        .customSelect(
          '''
      SELECT canonical_weight_kilograms
      FROM body_logs_table
      WHERE canonical_weight_kilograms IS NOT NULL
      ORDER BY logged_at DESC
      LIMIT 1
      ''',
          readsFrom: {database.bodyLogsTable},
        )
        .getSingleOrNull();

    return row?.read<double>('canonical_weight_kilograms');
  }
}
