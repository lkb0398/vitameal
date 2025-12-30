import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_entity.dart';

abstract class UserGoalsRepository {
  Future<void> saveGoal(UserGoalsEntity entity);
}
