// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_datas_save_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalDatasSaveDto _$GoalDatasSaveDtoFromJson(Map<String, dynamic> json) =>
    _GoalDatasSaveDto(
      goalId: json['goal_id'] as String?,
      dataDate: DateTime.parse(json['data_date'] as String),
      dataValue: (json['data_value'] as num).toDouble(),
    );

Map<String, dynamic> _$GoalDatasSaveDtoToJson(_GoalDatasSaveDto instance) =>
    <String, dynamic>{
      'goal_id': instance.goalId,
      'data_date': instance.dataDate.toIso8601String(),
      'data_value': instance.dataValue,
    };
