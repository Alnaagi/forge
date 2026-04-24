import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/exercise.dart';

extension ExerciseDataMapper on ExercisesTableData {
  Exercise toDomain() {
    return Exercise(
      id: id,
      name: name,
      primaryMuscleGroup: primaryMuscleGroup,
      isBuiltIn: isBuiltIn,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ExerciseCompanionMapper on Exercise {
  ExercisesTableCompanion toCompanion() {
    return ExercisesTableCompanion(
      id: Value(id),
      name: Value(name),
      primaryMuscleGroup: Value(primaryMuscleGroup),
      isBuiltIn: Value(isBuiltIn),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
