import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_dto.dart';
import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_entity.dart';

class UserGoalsMapper {
  // Entity > Dto
  static UserGoalsDto toDto(UserGoalsEntity entity) {
    return UserGoalsDto(
      userId: entity.userId,
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
      goalTitle: dto.goalTitle,
      goalUnit: dto.goalUnit,
      goalValue: dto.goalValue.toDouble(),
      goalDate: DateTime.parse(dto.goalDate),
      isDone: dto.isDone,
      isMain: dto.isMain,
    );
  }
}
