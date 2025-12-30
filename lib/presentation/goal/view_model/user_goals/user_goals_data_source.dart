import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_dto.dart';

abstract interface class UserGoalsDataSource {
  Future<void> saveGoal(UserGoalsDto goal);
}

class UserGoalsDataSourceImpl implements UserGoalsDataSource {
  UserGoalsDataSourceImpl(this.client);

  final SupabaseClient client;

  @override // C 목표 추가
  Future<void> saveGoal(UserGoalsDto goal) async {
    await client.from('user_goals').insert(goal);
  }
}
