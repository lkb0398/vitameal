import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_datas_save_dto.freezed.dart';
part 'goal_datas_save_dto.g.dart';

@freezed
abstract class GoalDatasSaveDto with _$GoalDatasSaveDto {
  const factory GoalDatasSaveDto({
    @JsonKey(name: 'goal_id') String? goalId,
    @JsonKey(name: 'data_date') required DateTime dataDate,
    @JsonKey(name: 'data_value') required double dataValue,
  }) = _GoalDatasSaveDto;

  factory GoalDatasSaveDto.fromJson(Map<String, dynamic> json) =>
      _$GoalDatasSaveDtoFromJson(json);
}
