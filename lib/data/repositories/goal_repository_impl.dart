import 'package:forge/data/local/db/daos/goal_dao.dart';
import 'package:forge/data/local/db/mappers/goal_mapper.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/domain/repositories/goal_repository.dart';

class GoalRepositoryImpl implements GoalRepository {
  const GoalRepositoryImpl(this._dao);

  final GoalDao _dao;

  @override
  Future<Goal?> getActiveGoal() async {
    final row = await _dao.getActiveGoal();
    return row?.toDomain();
  }

  @override
  Future<List<Goal>> getGoals() async {
    final rows = await _dao.getGoals();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<void> saveGoal(Goal goal) {
    return _dao.upsertGoal(goal.toCompanion());
  }
}
