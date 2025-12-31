import 'package:vitameal/data/dto/user_goals_dto.dart';
import 'package:vitameal/domain/entity/user_goals_entity.dart';
import 'package:vitameal/data/dto/user_goals_save_dto.dart';

class UserGoalsMapper {
  // Entity > Dto
  static UserGoalsDto toDto(UserGoalsEntity entity) {
    return UserGoalsDto(
      userId: entity.userId,
      goalId: entity.goalId,
      goalTitle: entity.goalTitle,
      goalUnit: entity.goalUnit,
      goalValue: entity.goalValue,
      goalDate: entity.goalDate.toIso8601String(),
      isDone: entity.isDone,
      isMain: entity.isMain,
    );
  }

  // Dto > Entity
  static UserGoalsEntity toEntity(UserGoalsDto dto) {
    return UserGoalsEntity(
      userId: dto.userId,
      goalId: dto.goalId,
      goalTitle: dto.goalTitle,
      goalUnit: dto.goalUnit,
      goalValue: dto.goalValue.toDouble(),
      goalDate: DateTime.parse(dto.goalDate),
      isDone: dto.isDone,
      isMain: dto.isMain,
    );
  }

  // insert 용
  static UserGoalsSaveDto toSaveDto(UserGoalsEntity entity) {
    return UserGoalsSaveDto(
      userId: entity.userId,
      goalTitle: entity.goalTitle,
      goalUnit: entity.goalUnit,
      goalValue: entity.goalValue,
      goalDate: entity.goalDate.toIso8601String(),
      isDone: entity.isDone,
      isMain: entity.isMain,
    );
  }
}
