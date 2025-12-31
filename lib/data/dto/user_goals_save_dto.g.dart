// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_goals_save_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserGoalsSaveDto _$UserGoalsSaveDtoFromJson(Map<String, dynamic> json) =>
    _UserGoalsSaveDto(
      userId: json['user_id'] as String?,
      goalTitle: json['goal_title'] as String,
      goalUnit: json['goal_unit'] as String,
      goalValue: json['goal_value'] as num,
      goalDate: json['goal_date'] as String,
      isDone: json['is_done'] as bool,
      isMain: json['is_main'] as bool,
    );

Map<String, dynamic> _$UserGoalsSaveDtoToJson(_UserGoalsSaveDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'goal_title': instance.goalTitle,
      'goal_unit': instance.goalUnit,
      'goal_value': instance.goalValue,
      'goal_date': instance.goalDate,
      'is_done': instance.isDone,
      'is_main': instance.isMain,
    };
