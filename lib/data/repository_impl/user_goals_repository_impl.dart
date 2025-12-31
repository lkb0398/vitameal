import 'package:vitameal/data/data_source/user_goals_data_source.dart';
import 'package:vitameal/domain/entity/user_goals_entity.dart';
import 'package:vitameal/data/mapper/user_goals_mapper.dart';
import 'package:vitameal/domain/repository/user_goals_repository.dart';

class UserGoalsRepositoryImpl implements UserGoalsRepository {
  UserGoalsRepositoryImpl(this.dataSource);

  final UserGoalsDataSource dataSource;

  @override
  Future<List<UserGoalsEntity>?> getAllGoals() async {
    final dtos = await dataSource.getAllGoals();
    if (dtos == null) return [];
    return dtos.map(UserGoalsMapper.toEntity).toList();
  }

  @override
  Future<void> saveGoal(UserGoalsEntity entity) async {
    final dto = UserGoalsMapper.toSaveDto(entity);
    await dataSource.saveGoal(dto);
  }

  @override
  Future<void> updateGoal(UserGoalsEntity entity) async {
    final dto = UserGoalsMapper.toDto(entity);
    await dataSource.updateGoal(dto);
  }

  @override
  Future<void> updateMainGoal(String goalId) async {
    await dataSource.updateMainGoal(goalId);
  }

  @override
  Future<void> deleteGoal(String goalId) async {
    await dataSource.deleteGoal(goalId);
  }
}
