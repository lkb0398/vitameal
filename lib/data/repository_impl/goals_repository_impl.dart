import 'package:vitameal/data/data_source/goals_data_source.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/data/mapper/goals_mapper.dart';
import 'package:vitameal/domain/repository/goals_repository.dart';

class GoalsRepositoryImpl implements GoalsRepository {
  GoalsRepositoryImpl(this.dataSource);

  final GoalsDataSource dataSource;

  @override
  Future<List<GoalsEntity>?> readGoals() async {
    final dtos = await dataSource.readGoals();
    if (dtos == null) return [];
    return dtos.map(GoalsMapper.toEntity).toList();
  }

  @override
  Future<void> createGoal(GoalsEntity entity) async {
    final dto = GoalsMapper.toDto(entity);
    await dataSource.createGoal(dto);
  }

  @override
  Future<void> updateGoal(GoalsEntity entity) async {
    final dto = GoalsMapper.toDto(entity);
    await dataSource.updateGoal(dto);
  }

  @override
  Future<void> deleteGoal(String goalId) async {
    await dataSource.deleteGoal(goalId);
  }
}
