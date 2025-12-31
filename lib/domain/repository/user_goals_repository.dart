import 'package:vitameal/domain/entity/user_goals_entity.dart';

abstract class UserGoalsRepository {
  Future<void> saveGoal(UserGoalsEntity entity);
  Future<List<UserGoalsEntity>?> getAllGoals();
  Future<void> updateGoal(UserGoalsEntity entity);
  Future<void> updateMainGoal(String goalId);
  Future<void> deleteGoal(String goalId);
}
