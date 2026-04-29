import 'package:vitameal/domain/entity/goals_entity.dart';

abstract class GoalsRepository {
  Future<void> createGoal(GoalsEntity entity);
  Future<List<GoalsEntity>?> readGoals(String userId);
  Future<void> updateGoal(GoalsEntity entity);
  Future<void> deleteGoal(String goalId);
}
