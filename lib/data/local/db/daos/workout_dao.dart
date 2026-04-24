import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';

class WorkoutHistoryRow {
  const WorkoutHistoryRow({
    required this.sessionId,
    required this.startedAt,
    required this.endedAt,
    required this.templateName,
    required this.exerciseCount,
    required this.setCount,
    required this.totalVolumeKilograms,
  });

  final String sessionId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String? templateName;
  final int exerciseCount;
  final int setCount;
  final double totalVolumeKilograms;
}

class WorkoutTemplateDetailRow {
  const WorkoutTemplateDetailRow({
    required this.template,
    required this.item,
    required this.exercise,
  });

  final WorkoutTemplatesTableData template;
  final WorkoutTemplateItemsTableData? item;
  final ExercisesTableData? exercise;
}

class WorkoutSessionExerciseRow {
  const WorkoutSessionExerciseRow({
    required this.entry,
    required this.exercise,
    required this.setEntry,
  });

  final WorkoutExerciseEntriesTableData entry;
  final ExercisesTableData exercise;
  final SetEntriesTableData? setEntry;
}

class WorkoutDao {
  const WorkoutDao(this.database);

  final AppDatabase database;

  Future<List<WorkoutTemplatesTableData>> getTemplates() {
    return (database.select(
      database.workoutTemplatesTable,
    )..orderBy([(table) => OrderingTerm.asc(table.name)])).get();
  }

  Future<WorkoutTemplatesTableData?> getTemplateById(String templateId) {
    return (database.select(
      database.workoutTemplatesTable,
    )..where((table) => table.id.equals(templateId))).getSingleOrNull();
  }

  Future<List<WorkoutTemplateItemsTableData>> getTemplateItems(
    String templateId,
  ) {
    return (database.select(database.workoutTemplateItemsTable)
          ..where((table) => table.templateId.equals(templateId))
          ..orderBy([(table) => OrderingTerm.asc(table.orderIndex)]))
        .get();
  }

  Future<List<WorkoutTemplateDetailRow>> getTemplateDetailRows({
    String? templateId,
  }) {
    final query =
        database.select(database.workoutTemplatesTable).join([
          leftOuterJoin(
            database.workoutTemplateItemsTable,
            database.workoutTemplateItemsTable.templateId.equalsExp(
              database.workoutTemplatesTable.id,
            ),
          ),
          leftOuterJoin(
            database.exercisesTable,
            database.exercisesTable.id.equalsExp(
              database.workoutTemplateItemsTable.exerciseId,
            ),
          ),
        ])..orderBy([
          OrderingTerm.asc(database.workoutTemplatesTable.name),
          OrderingTerm.asc(database.workoutTemplateItemsTable.orderIndex),
        ]);

    if (templateId != null) {
      query.where(database.workoutTemplatesTable.id.equals(templateId));
    }

    return query
        .map(
          (row) => WorkoutTemplateDetailRow(
            template: row.readTable(database.workoutTemplatesTable),
            item: row.readTableOrNull(database.workoutTemplateItemsTable),
            exercise: row.readTableOrNull(database.exercisesTable),
          ),
        )
        .get();
  }

  Future<void> upsertTemplate(WorkoutTemplatesTableCompanion companion) {
    return database
        .into(database.workoutTemplatesTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> replaceTemplateItems(
    String templateId,
    List<WorkoutTemplateItemsTableCompanion> companions,
  ) async {
    await database.transaction(() async {
      await (database.delete(
        database.workoutTemplateItemsTable,
      )..where((table) => table.templateId.equals(templateId))).go();

      if (companions.isNotEmpty) {
        await database.batch((batch) {
          batch.insertAll(database.workoutTemplateItemsTable, companions);
        });
      }
    });
  }

  Future<void> upsertSession(WorkoutSessionsTableCompanion companion) {
    return database
        .into(database.workoutSessionsTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> completeSession({
    required String sessionId,
    String? notes,
    required DateTime endedAt,
  }) {
    return (database.update(
      database.workoutSessionsTable,
    )..where((table) => table.id.equals(sessionId))).write(
      WorkoutSessionsTableCompanion(
        endedAt: Value(endedAt),
        notes: notes == null ? const Value.absent() : Value(notes),
        updatedAt: Value(endedAt),
      ),
    );
  }

  Future<WorkoutSessionsTableData?> getSessionById(String sessionId) {
    return (database.select(
      database.workoutSessionsTable,
    )..where((table) => table.id.equals(sessionId))).getSingleOrNull();
  }

  Future<List<WorkoutSessionsTableData>> getSessions() {
    return (database.select(
      database.workoutSessionsTable,
    )..orderBy([(table) => OrderingTerm.desc(table.startedAt)])).get();
  }

  Future<void> upsertExerciseEntry(
    WorkoutExerciseEntriesTableCompanion companion,
  ) {
    return database
        .into(database.workoutExerciseEntriesTable)
        .insertOnConflictUpdate(companion);
  }

  Future<List<WorkoutExerciseEntriesTableData>> getExerciseEntriesForSession(
    String sessionId,
  ) {
    return (database.select(database.workoutExerciseEntriesTable)
          ..where((table) => table.sessionId.equals(sessionId))
          ..orderBy([(table) => OrderingTerm.asc(table.orderIndex)]))
        .get();
  }

  Future<List<WorkoutSessionExerciseRow>> getSessionExerciseRows(
    String sessionId,
  ) {
    final query =
        database.select(database.workoutExerciseEntriesTable).join([
            innerJoin(
              database.exercisesTable,
              database.exercisesTable.id.equalsExp(
                database.workoutExerciseEntriesTable.exerciseId,
              ),
            ),
            leftOuterJoin(
              database.setEntriesTable,
              database.setEntriesTable.exerciseEntryId.equalsExp(
                database.workoutExerciseEntriesTable.id,
              ),
            ),
          ])
          ..where(
            database.workoutExerciseEntriesTable.sessionId.equals(sessionId),
          )
          ..orderBy([
            OrderingTerm.asc(database.workoutExerciseEntriesTable.orderIndex),
            OrderingTerm.asc(database.setEntriesTable.orderIndex),
          ]);

    return query
        .map(
          (row) => WorkoutSessionExerciseRow(
            entry: row.readTable(database.workoutExerciseEntriesTable),
            exercise: row.readTable(database.exercisesTable),
            setEntry: row.readTableOrNull(database.setEntriesTable),
          ),
        )
        .get();
  }

  Future<WorkoutExerciseEntriesTableData?> getExerciseEntryById(
    String entryId,
  ) {
    return (database.select(
      database.workoutExerciseEntriesTable,
    )..where((table) => table.id.equals(entryId))).getSingleOrNull();
  }

  Future<void> upsertSetEntry(SetEntriesTableCompanion companion) {
    return database
        .into(database.setEntriesTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> deleteSetEntry(String setEntryId) {
    return (database.delete(
      database.setEntriesTable,
    )..where((table) => table.id.equals(setEntryId))).go();
  }

  Future<List<SetEntriesTableData>> getSetEntriesForExerciseEntry(
    String exerciseEntryId,
  ) {
    return (database.select(database.setEntriesTable)
          ..where((table) => table.exerciseEntryId.equals(exerciseEntryId))
          ..orderBy([(table) => OrderingTerm.asc(table.orderIndex)]))
        .get();
  }

  Future<List<SetEntriesTableData>> getSetEntriesForExercise(
    String exerciseId,
  ) {
    final query =
        database.select(database.setEntriesTable).join([
            innerJoin(
              database.workoutExerciseEntriesTable,
              database.workoutExerciseEntriesTable.id.equalsExp(
                database.setEntriesTable.exerciseEntryId,
              ),
            ),
          ])
          ..where(
            database.workoutExerciseEntriesTable.exerciseId.equals(exerciseId),
          )
          ..orderBy([OrderingTerm.desc(database.setEntriesTable.createdAt)]);

    return query.map((row) => row.readTable(database.setEntriesTable)).get();
  }

  Future<SetEntriesTableData?> getLastSetForExercise(String exerciseId) async {
    final rows = await getSetEntriesForExercise(exerciseId);
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<WorkoutHistoryRow>> getHistoryRows() async {
    final rows = await database
        .customSelect(
          '''
      SELECT
        ws.id AS session_id,
        ws.started_at,
        ws.ended_at,
        wt.name AS template_name,
        COUNT(DISTINCT wee.id) AS exercise_count,
        COUNT(se.id) AS set_count,
        COALESCE(SUM(COALESCE(se.canonical_weight_kilograms, 0) * se.reps), 0) AS total_volume
      FROM workout_sessions_table ws
      LEFT JOIN workout_templates_table wt ON wt.id = ws.template_id
      LEFT JOIN workout_exercise_entries_table wee ON wee.session_id = ws.id
      LEFT JOIN set_entries_table se ON se.exercise_entry_id = wee.id
      GROUP BY ws.id, ws.started_at, ws.ended_at, wt.name
      ORDER BY ws.started_at DESC
      ''',
          readsFrom: {
            database.workoutSessionsTable,
            database.workoutTemplatesTable,
            database.workoutExerciseEntriesTable,
            database.setEntriesTable,
          },
        )
        .get();

    return rows
        .map(
          (row) => WorkoutHistoryRow(
            sessionId: row.read<String>('session_id'),
            startedAt: row.read<DateTime>('started_at'),
            endedAt: row.readNullable<DateTime>('ended_at'),
            templateName: row.readNullable<String>('template_name'),
            exerciseCount: row.read<int>('exercise_count'),
            setCount: row.read<int>('set_count'),
            totalVolumeKilograms: row.read<double>('total_volume'),
          ),
        )
        .toList(growable: false);
  }
}
