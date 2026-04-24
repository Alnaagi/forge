import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/data/local/db/daos/goal_dao.dart';
import 'package:forge/data/repositories/goal_repository_impl.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/value_objects/macro_target.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

void main() {
  late AppDatabase database;
  late GoalRepositoryImpl repository;

  setUp(() {
    database = AppDatabase.test(NativeDatabase.memory());
    repository = GoalRepositoryImpl(GoalDao(database));
  });

  tearDown(() async {
    await database.close();
  });

  test('persists and returns the active goal', () async {
    final now = DateTime(2026, 4, 22, 9);
    final goal = Goal(
      id: 'goal-cut',
      type: GoalType.cut,
      title: 'Spring Cut',
      targetWeight: const WeightValue(
        originalValue: 82,
        originalUnit: WeightUnit.kilograms,
        canonicalKilograms: 82,
      ),
      macroTarget: const MacroTarget(
        calories: 2200,
        proteinGrams: 180,
        carbsGrams: 210,
        fatGrams: 65,
      ),
      isActive: true,
      startedAt: now,
      endedAt: now.add(const Duration(days: 90)),
      createdAt: now,
      updatedAt: now,
    );

    await repository.saveGoal(goal);

    final activeGoal = await repository.getActiveGoal();
    final allGoals = await repository.getGoals();

    expect(activeGoal, isNotNull);
    expect(activeGoal!.id, 'goal-cut');
    expect(activeGoal.type, GoalType.cut);
    expect(activeGoal.macroTarget.calories, 2200);
    expect(activeGoal.targetWeight?.originalUnit, WeightUnit.kilograms);
    expect(allGoals, hasLength(1));
  });

  test('saving a new active goal deactivates the previous one', () async {
    final now = DateTime(2026, 4, 22, 9);
    final firstGoal = Goal(
      id: 'goal-maintain',
      type: GoalType.maintain,
      title: 'Maintain',
      targetWeight: null,
      macroTarget: const MacroTarget(
        calories: 2400,
        proteinGrams: 170,
        carbsGrams: 250,
        fatGrams: 70,
      ),
      isActive: true,
      startedAt: now,
      endedAt: null,
      createdAt: now,
      updatedAt: now,
    );
    final secondGoal = Goal(
      id: 'goal-strength',
      type: GoalType.strength,
      title: 'Strength Block',
      targetWeight: null,
      macroTarget: const MacroTarget(
        calories: 2800,
        proteinGrams: 190,
        carbsGrams: 320,
        fatGrams: 80,
      ),
      isActive: true,
      startedAt: now.add(const Duration(days: 10)),
      endedAt: null,
      createdAt: now.add(const Duration(days: 10)),
      updatedAt: now.add(const Duration(days: 10)),
    );

    await repository.saveGoal(firstGoal);
    await repository.saveGoal(secondGoal);

    final activeGoal = await repository.getActiveGoal();
    final allGoals = await repository.getGoals();
    final previousGoal = allGoals.firstWhere(
      (goal) => goal.id == 'goal-maintain',
    );

    expect(activeGoal, isNotNull);
    expect(activeGoal!.id, 'goal-strength');
    expect(previousGoal.isActive, isFalse);
  });
}
