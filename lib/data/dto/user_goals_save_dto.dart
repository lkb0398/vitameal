import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_goals_save_dto.freezed.dart';
part 'user_goals_save_dto.g.dart';

@freezed
abstract class UserGoalsSaveDto with _$UserGoalsSaveDto {
  const factory UserGoalsSaveDto({
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'goal_title') required String goalTitle,
    @JsonKey(name: 'goal_unit') required String goalUnit,
    @JsonKey(name: 'goal_value') required num goalValue,
    @JsonKey(name: 'goal_date') required String goalDate,
    @JsonKey(name: 'is_done') required bool isDone,
    @JsonKey(name: 'is_main') required bool isMain,
  }) = _UserGoalsSaveDto;

  factory UserGoalsSaveDto.fromJson(Map<String, dynamic> json) =>
      _$UserGoalsSaveDtoFromJson(json);
}
