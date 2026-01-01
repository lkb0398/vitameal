// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarms_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AlarmsDto _$AlarmsDtoFromJson(Map<String, dynamic> json) => _AlarmsDto(
  userId: json['user_id'] as String?,
  alarmId: json['alarm_id'] as String?,
  label: json['label'] as String,
  time: json['time'] as String,
  isEnabled: json['is_enabled'] as bool,
);

Map<String, dynamic> _$AlarmsDtoToJson(_AlarmsDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'alarm_id': instance.alarmId,
      'label': instance.label,
      'time': instance.time,
      'is_enabled': instance.isEnabled,
    };
