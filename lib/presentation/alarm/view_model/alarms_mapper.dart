import 'package:flutter/material.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_dto.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_entity.dart';

class AlarmsMapper {
  // Entity > Dto
  static AlarmsDto toDto(AlarmsEntity entity) {
    return AlarmsDto(
      userId: entity.userId,
      alarmId: entity.alarmId,
      label: entity.label,
      time: timeOfDayToString(entity.time),
      isEnabled: entity.isEnabled,
    );
  }

  // Dto > Entity
  static AlarmsEntity toEntity(AlarmsDto dto) {
    return AlarmsEntity(
      userId: dto.userId,
      alarmId: dto.alarmId,
      label: dto.label,
      time: stringToTimeOfDay(dto.time),
      isEnabled: dto.isEnabled,
    );
  }

  // TimeOfDay > "HH:mm"
  static String timeOfDayToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // "HH:mm" > TimeOfDay
  static TimeOfDay stringToTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
