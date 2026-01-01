import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarms_entity.freezed.dart';

@freezed
abstract class AlarmsEntity with _$AlarmsEntity {
  const factory AlarmsEntity({
    String? userId,
    String? alarmId,
    required String label,
    required TimeOfDay time,
    required bool isEnabled,
  }) = _AlarmsEntity;
}
