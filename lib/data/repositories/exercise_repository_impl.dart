import 'package:forge/data/local/db/daos/exercise_dao.dart';
import 'package:forge/data/local/db/mappers/exercise_mapper.dart';
import 'package:forge/domain/entities/exercise.dart';
import 'package:forge/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  const ExerciseRepositoryImpl(this._dao);

  final ExerciseDao _dao;

  @override
  Future<List<Exercise>> getAll({String? query}) async {
    final rows = await _dao.getAll(query: query);
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<Exercise?> getById(String exerciseId) async {
    final row = await _dao.getById(exerciseId);
    return row?.toDomain();
  }

  @override
  Future<void> upsert(Exercise exercise) {
    return _dao.upsert(exercise.toCompanion());
  }
}
