import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/user_goals_dto.dart';
import 'package:vitameal/data/dto/user_goals_save_dto.dart';

abstract interface class UserGoalsDataSource {
  Future<List<UserGoalsDto>?> getAllGoals();
  Future<void> saveGoal(UserGoalsSaveDto dto);
  Future<void> updateGoal(UserGoalsDto dto);
  Future<void> updateMainGoal(String goalId);
  Future<void> deleteGoal(String goalId);
}

class UserGoalsDataSourceImpl implements UserGoalsDataSource {
  UserGoalsDataSourceImpl(this.client);

  final SupabaseClient client;

  @override // R (전체)
  Future<List<UserGoalsDto>?> getAllGoals() async {
    final response = await client
        .from('user_goals')
        .select()
        .order('is_done', ascending: true) // 1. 완료 여부에 따라 정렬
        .order('created_at', ascending: false); // 2. 최신순 정렬
    return (response as List).map((e) => UserGoalsDto.fromJson(e)).toList();
  }

  @override // C
  Future<void> saveGoal(UserGoalsSaveDto dto) async {
    await client.from('user_goals').insert(dto);
  }

  @override // U
  Future<void> updateGoal(UserGoalsDto dto) async {
    final map = {
      'goal_title': dto.goalTitle,
      'goal_unit': dto.goalUnit,
      'goal_value': dto.goalValue,
      'goal_date': dto.goalDate,
    };
    await client.from('user_goals').update(map).eq('goal_id', dto.goalId!);
  }

  @override // U (isMain 업데이트)
  Future<void> updateMainGoal(String goalId) async {
    await client
        .from('user_goals')
        .update({'is_main': true})
        .eq('goal_id', goalId);
  }

  @override // D
  Future<void> deleteGoal(String goalId) async {
    await client.from('user_goals').delete().eq('goal_id', goalId);
  }
}
