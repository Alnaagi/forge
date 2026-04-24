import 'package:forge/domain/entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getAll({String? query});
  Future<Exercise?> getById(String exerciseId);
  Future<void> upsert(Exercise exercise);
}
