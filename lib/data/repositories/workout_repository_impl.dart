import 'package:forge/data/local/db/daos/workout_dao.dart';
import 'package:forge/data/local/db/mappers/exercise_mapper.dart';
import 'package:forge/data/local/db/mappers/workout_mapper.dart';
import 'package:forge/domain/entities/exercise.dart';
import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_history_item.dart';
import 'package:forge/domain/entities/workout_exercise_entry.dart';
import 'package:forge/domain/entities/workout_logged_exercise.dart';
import 'package:forge/domain/entities/workout_session.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/domain/entities/workout_template.dart';
import 'package:forge/domain/entities/workout_template_detail.dart';
import 'package:forge/domain/entities/workout_template_item.dart';
import 'package:forge/domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  const WorkoutRepositoryImpl(this._dao);

  final WorkoutDao _dao;

  @override
  Future<List<WorkoutTemplate>> getTemplates() async {
    final rows = await _dao.getTemplates();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<List<WorkoutTemplateDetail>> getTemplateDetails() async {
    final rows = await _dao.getTemplateDetailRows();
    return _mapTemplateDetails(rows);
  }

  @override
  Future<WorkoutTemplate?> getTemplate(String templateId) async {
    final row = await _dao.getTemplateById(templateId);
    return row?.toDomain();
  }

  @override
  Future<List<WorkoutTemplateItem>> getTemplateItems(String templateId) async {
    final rows = await _dao.getTemplateItems(templateId);
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<WorkoutTemplateDetail?> getTemplateDetail(String templateId) async {
    final rows = await _dao.getTemplateDetailRows(templateId: templateId);
    if (rows.isEmpty) {
      return null;
    }

    return _mapTemplateDetails(rows).single;
  }

  @override
  Future<void> saveTemplate(WorkoutTemplate template) {
    return _dao.upsertTemplate(template.toCompanion());
  }

  @override
  Future<void> replaceTemplateItems(
    String templateId,
    List<WorkoutTemplateItem> items,
  ) {
    return _dao.replaceTemplateItems(
      templateId,
      items.map((item) => item.toCompanion()).toList(growable: false),
    );
  }

  @override
  Future<WorkoutSession> startSession({
    String? templateId,
    String? notes,
  }) async {
    final now = DateTime.now();
    final session = WorkoutSession(
      id: 'session-${now.microsecondsSinceEpoch}',
      templateId: templateId,
      startedAt: now,
      endedAt: null,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
    await _dao.upsertSession(session.toCompanion());
    return session;
  }

  @override
  Future<void> completeSession({
    required String sessionId,
    String? notes,
    DateTime? endedAt,
  }) async {
    final session = await _requireSession(sessionId);
    if (session.endedAt != null) {
      return;
    }

    final completedAt = endedAt ?? DateTime.now();
    return _dao.completeSession(
      sessionId: sessionId,
      notes: notes,
      endedAt: completedAt,
    );
  }

  @override
  Future<WorkoutSession?> getSession(String sessionId) async {
    final row = await _dao.getSessionById(sessionId);
    return row?.toDomain();
  }

  @override
  Future<void> saveExerciseEntry(WorkoutExerciseEntry entry) async {
    await _requireActiveSession(entry.sessionId);
    return _dao.upsertExerciseEntry(entry.toCompanion());
  }

  @override
  Future<List<WorkoutLoggedExercise>> getLoggedExercises(
    String sessionId,
  ) async {
    final rows = await _dao.getSessionExerciseRows(sessionId);
    return _mapLoggedExercises(rows);
  }

  @override
  Future<void> saveSet(SetEntry setEntry) async {
    final exerciseEntry = await _dao.getExerciseEntryById(
      setEntry.exerciseEntryId,
    );
    if (exerciseEntry == null) {
      throw StateError(
        'Workout exercise entry ${setEntry.exerciseEntryId} was not found.',
      );
    }

    await _requireActiveSession(exerciseEntry.sessionId);
    return _dao.upsertSetEntry(setEntry.toCompanion());
  }

  @override
  Future<void> deleteSet(String setId) {
    return _dao.deleteSetEntry(setId);
  }

  @override
  Future<SetEntry?> getLastSetForExercise(String exerciseId) async {
    final row = await _dao.getLastSetForExercise(exerciseId);
    return row?.toDomain();
  }

  @override
  Future<List<SetEntry>> getSetHistoryForExercise(String exerciseId) async {
    final rows = await _dao.getSetEntriesForExercise(exerciseId);
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<List<WorkoutSession>> getSessions() async {
    final rows = await _dao.getSessions();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<List<WorkoutHistoryItem>> getHistoryItems() async {
    final rows = await _dao.getHistoryRows();
    return rows
        .map(
          (row) => WorkoutHistoryItem(
            sessionId: row.sessionId,
            templateName: row.templateName,
            startedAt: row.startedAt,
            endedAt: row.endedAt,
            exerciseCount: row.exerciseCount,
            setCount: row.setCount,
            totalVolumeKilograms: row.totalVolumeKilograms,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<WorkoutSessionDetail?> getSessionDetail(String sessionId) async {
    final session = await getSession(sessionId);
    if (session == null) {
      return null;
    }
    final exercises = await getLoggedExercises(sessionId);
    final totalSets = exercises.fold<int>(
      0,
      (sum, exercise) => sum + exercise.sets.length,
    );
    final totalVolume = exercises.fold<double>(
      0,
      (sum, exercise) =>
          sum +
          exercise.sets.fold<double>(
            0,
            (exerciseSum, set) =>
                exerciseSum +
                ((set.weight?.canonicalKilograms ?? 0) * set.reps),
          ),
    );

    return WorkoutSessionDetail(
      session: session,
      exercises: exercises,
      totalSets: totalSets,
      totalVolumeKilograms: totalVolume,
    );
  }

  Future<WorkoutSession> _requireSession(String sessionId) async {
    final session = await getSession(sessionId);
    if (session == null) {
      throw StateError('Workout session $sessionId was not found.');
    }
    return session;
  }

  Future<void> _requireActiveSession(String sessionId) async {
    final session = await _requireSession(sessionId);
    if (session.endedAt != null) {
      throw StateError('Workout session $sessionId is already completed.');
    }
  }

  List<WorkoutTemplateDetail> _mapTemplateDetails(
    List<WorkoutTemplateDetailRow> rows,
  ) {
    final accumulators = <String, _TemplateDetailAccumulator>{};

    for (final row in rows) {
      final templateId = row.template.id;
      final accumulator = accumulators.putIfAbsent(
        templateId,
        () => _TemplateDetailAccumulator(template: row.template.toDomain()),
      );

      final item = row.item;
      final exercise = row.exercise;
      if (item != null && exercise != null) {
        accumulator.items.add(
          WorkoutTemplateExerciseItem(
            item: item.toDomain(),
            exercise: exercise.toDomain(),
          ),
        );
      }
    }

    return accumulators.values
        .map(
          (accumulator) => WorkoutTemplateDetail(
            template: accumulator.template,
            items: List.unmodifiable(accumulator.items),
          ),
        )
        .toList(growable: false);
  }

  List<WorkoutLoggedExercise> _mapLoggedExercises(
    List<WorkoutSessionExerciseRow> rows,
  ) {
    final accumulators = <String, _LoggedExerciseAccumulator>{};

    for (final row in rows) {
      final entryId = row.entry.id;
      final accumulator = accumulators.putIfAbsent(
        entryId,
        () => _LoggedExerciseAccumulator(
          entry: row.entry.toDomain(),
          exercise: row.exercise.toDomain(),
        ),
      );

      final setEntry = row.setEntry;
      if (setEntry != null) {
        accumulator.sets.add(setEntry.toDomain());
      }
    }

    return accumulators.values
        .map(
          (accumulator) => WorkoutLoggedExercise(
            entry: accumulator.entry,
            exercise: accumulator.exercise,
            sets: List.unmodifiable(accumulator.sets),
          ),
        )
        .toList(growable: false);
  }
}

class _TemplateDetailAccumulator {
  _TemplateDetailAccumulator({required this.template});

  final WorkoutTemplate template;
  final List<WorkoutTemplateExerciseItem> items =
      <WorkoutTemplateExerciseItem>[];
}

class _LoggedExerciseAccumulator {
  _LoggedExerciseAccumulator({required this.entry, required this.exercise});

  final WorkoutExerciseEntry entry;
  final Exercise exercise;
  final List<SetEntry> sets = <SetEntry>[];
}
