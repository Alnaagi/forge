import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/goal_dao.dart';
import 'package:forge/data/repositories/goal_repository_impl.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/domain/repositories/goal_repository.dart';

final goalDaoProvider = Provider<GoalDao>((ref) {
  return GoalDao(ref.watch(appDatabaseProvider));
});

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return GoalRepositoryImpl(ref.watch(goalDaoProvider));
});

final activeGoalProvider = FutureProvider<Goal?>((ref) async {
  return ref.watch(goalRepositoryProvider).getActiveGoal();
});
