import 'package:vitameal/data/dto/goal_datas_dto.dart';
import 'package:vitameal/domain/entity/goal_datas_entity.dart';
import 'package:vitameal/data/dto/goal_datas_save_dto.dart';

class GoalDatasMapper {
  // Entity > Dto
  static GoalDatasDto toDto(GoalDatasEntity entity) {
    return GoalDatasDto(
      goalId: entity.goalId,
      dataId: entity.dataId,
      dataDate: entity.dataDate,
      dataValue: entity.dataValue,
    );
  }

  // Dto > Entity
  static GoalDatasEntity toEntity(GoalDatasDto dto) {
    return GoalDatasEntity(
      goalId: dto.goalId,
      dataId: dto.dataId,
      dataDate: dto.dataDate,
      dataValue: dto.dataValue,
    );
  }

  // insert 용
  static GoalDatasSaveDto toSaveDto(GoalDatasEntity entity) {
    return GoalDatasSaveDto(
      goalId: entity.goalId,
      dataDate: entity.dataDate,
      dataValue: entity.dataValue,
    );
  }
}
