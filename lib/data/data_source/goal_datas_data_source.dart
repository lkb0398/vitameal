import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/goal_datas_dto.dart';
import 'package:vitameal/data/dto/goal_datas_save_dto.dart';

abstract interface class GoalDatasDataSource {
  Future<List<GoalDatasDto>?> getGoalDatas(String goalId);
  Future<void> saveData(GoalDatasSaveDto dto);
  Future<void> deleteDatas(List<String> dataIds);
}

class GoalDatasDataSourceImpl implements GoalDatasDataSource {
  GoalDatasDataSourceImpl(this.client);

  final SupabaseClient client;

  @override // R (전체)
  Future<List<GoalDatasDto>?> getGoalDatas(String goalId) async {
    final response = await client
        .from('goal_datas')
        .select()
        .eq('goal_id', goalId)
        .order('data_date', ascending: false); // 일자 최신순 정렬
    return (response as List).map((e) => GoalDatasDto.fromJson(e)).toList();
  }

  @override // C
  Future<void> saveData(GoalDatasSaveDto dto) async {
    await client.from('goal_datas').insert(dto);
  }

  @override // D (다중)
  Future<void> deleteDatas(List<String> dataIds) async {
    await client.from('goal_datas').delete().inFilter('data_id', dataIds);
  }
}
