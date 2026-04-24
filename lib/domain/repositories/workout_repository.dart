import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_history_item.dart';
import 'package:forge/domain/entities/workout_exercise_entry.dart';
import 'package:forge/domain/entities/workout_logged_exercise.dart';
import 'package:forge/domain/entities/workout_session.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';
import 'package:forge/domain/entities/workout_template.dart';
import 'package:forge/domain/entities/workout_template_detail.dart';
import 'package:forge/domain/entities/workout_template_item.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutTemplate>> getTemplates();
  Future<List<WorkoutTemplateDetail>> getTemplateDetails();
  Future<WorkoutTemplate?> getTemplate(String templateId);
  Future<List<WorkoutTemplateItem>> getTemplateItems(String templateId);
  Future<WorkoutTemplateDetail?> getTemplateDetail(String templateId);
  Future<void> saveTemplate(WorkoutTemplate template);
  Future<void> replaceTemplateItems(
    String templateId,
    List<WorkoutTemplateItem> items,
  );
  Future<WorkoutSession> startSession({String? templateId, String? notes});
  Future<void> completeSession({
    required String sessionId,
    String? notes,
    DateTime? endedAt,
  });
  Future<WorkoutSession?> getSession(String sessionId);
  Future<WorkoutSessionDetail?> getSessionDetail(String sessionId);
  Future<void> saveExerciseEntry(WorkoutExerciseEntry entry);
  Future<List<WorkoutLoggedExercise>> getLoggedExercises(String sessionId);
  Future<void> saveSet(SetEntry setEntry);
  Future<void> deleteSet(String setId);
  Future<SetEntry?> getLastSetForExercise(String exerciseId);
  Future<List<SetEntry>> getSetHistoryForExercise(String exerciseId);
  Future<List<WorkoutHistoryItem>> getHistoryItems();
  Future<List<WorkoutSession>> getSessions();
}
