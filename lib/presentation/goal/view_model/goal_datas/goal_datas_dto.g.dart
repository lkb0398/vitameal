// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_datas_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalDatasDto _$GoalDatasDtoFromJson(Map<String, dynamic> json) =>
    _GoalDatasDto(
      dataDate: DateTime.parse(json['data_date'] as String),
      dataValue: (json['data_value'] as num).toDouble(),
    );

Map<String, dynamic> _$GoalDatasDtoToJson(_GoalDatasDto instance) =>
    <String, dynamic>{
      'data_date': instance.dataDate.toIso8601String(),
      'data_value': instance.dataValue,
    };
