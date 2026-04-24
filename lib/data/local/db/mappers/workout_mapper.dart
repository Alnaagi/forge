import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/entities/workout_exercise_entry.dart';
import 'package:forge/domain/entities/workout_session.dart';
import 'package:forge/domain/entities/workout_template.dart';
import 'package:forge/domain/entities/workout_template_item.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

extension WorkoutTemplateDataMapper on WorkoutTemplatesTableData {
  WorkoutTemplate toDomain() {
    return WorkoutTemplate(
      id: id,
      name: name,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension WorkoutTemplateCompanionMapper on WorkoutTemplate {
  WorkoutTemplatesTableCompanion toCompanion() {
    return WorkoutTemplatesTableCompanion(
      id: Value(id),
      name: Value(name),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension WorkoutTemplateItemDataMapper on WorkoutTemplateItemsTableData {
  WorkoutTemplateItem toDomain() {
    return WorkoutTemplateItem(
      id: id,
      templateId: templateId,
      exerciseId: exerciseId,
      orderIndex: orderIndex,
      targetSets: targetSets,
      targetReps: targetReps,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension WorkoutTemplateItemCompanionMapper on WorkoutTemplateItem {
  WorkoutTemplateItemsTableCompanion toCompanion() {
    return WorkoutTemplateItemsTableCompanion(
      id: Value(id),
      templateId: Value(templateId),
      exerciseId: Value(exerciseId),
      orderIndex: Value(orderIndex),
      targetSets: Value(targetSets),
      targetReps: Value(targetReps),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension WorkoutSessionDataMapper on WorkoutSessionsTableData {
  WorkoutSession toDomain() {
    return WorkoutSession(
      id: id,
      templateId: templateId,
      startedAt: startedAt,
      endedAt: endedAt,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension WorkoutSessionCompanionMapper on WorkoutSession {
  WorkoutSessionsTableCompanion toCompanion() {
    return WorkoutSessionsTableCompanion(
      id: Value(id),
      templateId: Value(templateId),
      notes: Value(notes),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension WorkoutExerciseEntryDataMapper on WorkoutExerciseEntriesTableData {
  WorkoutExerciseEntry toDomain() {
    return WorkoutExerciseEntry(
      id: id,
      sessionId: sessionId,
      exerciseId: exerciseId,
      orderIndex: orderIndex,
      notes: notes,
      supersetGroupId: supersetGroupId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension WorkoutExerciseEntryCompanionMapper on WorkoutExerciseEntry {
  WorkoutExerciseEntriesTableCompanion toCompanion() {
    return WorkoutExerciseEntriesTableCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      orderIndex: Value(orderIndex),
      notes: Value(notes),
      supersetGroupId: Value(supersetGroupId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension SetEntryDataMapper on SetEntriesTableData {
  SetEntry toDomain() {
    return SetEntry(
      id: id,
      exerciseEntryId: exerciseEntryId,
      setType: setType,
      orderIndex: orderIndex,
      reps: reps,
      weight:
          originalWeightValue != null &&
              originalWeightUnit != null &&
              canonicalWeightKilograms != null
          ? WeightValue(
              originalValue: originalWeightValue!,
              originalUnit: originalWeightUnit!,
              canonicalKilograms: canonicalWeightKilograms!,
            )
          : null,
      rpe: rpe,
      tempo: tempo,
      restSeconds: restSeconds,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension SetEntryCompanionMapper on SetEntry {
  SetEntriesTableCompanion toCompanion() {
    return SetEntriesTableCompanion(
      id: Value(id),
      exerciseEntryId: Value(exerciseEntryId),
      setType: Value(setType),
      orderIndex: Value(orderIndex),
      reps: Value(reps),
      originalWeightValue: Value(weight?.originalValue),
      originalWeightUnit: Value(weight?.originalUnit),
      canonicalWeightKilograms: Value(weight?.canonicalKilograms),
      rpe: Value(rpe),
      tempo: Value(tempo),
      restSeconds: Value(restSeconds),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
