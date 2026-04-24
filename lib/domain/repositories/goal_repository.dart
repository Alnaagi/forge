import 'package:forge/domain/entities/goal.dart';

abstract class GoalRepository {
  Future<List<Goal>> getGoals();
  Future<Goal?> getActiveGoal();
  Future<void> saveGoal(Goal goal);
}
