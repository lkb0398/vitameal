import 'package:vitameal/domain/entity/goal_datas_entity.dart';

abstract class GoalDatasRepository {
  Future<void> createData(GoalDatasEntity entity);
  Future<List<GoalDatasEntity>?> readDatas(String goalId);
  Future<void> deleteDatas(List<String> dataIds);
}
