import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_entity.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'alarms_view_model.g.dart';

@riverpod
class AlarmsViewModel extends _$AlarmsViewModel {
  @override
  void build() {}

  Future<void> saveAlarm({
    required String label,
    required TimeOfDay time,
    required bool isEnabled,
  }) async {
    final userId = ref.read(userIdProvider);
    await ref
        .read(alarmsRepositoryProvider)
        .saveAlarm(
          AlarmsEntity(
            userId: userId,
            label: label,
            time: time,
            isEnabled: isEnabled,
          ),
        );
  }

  Future<void> updateAlarm({
    required String alarmId,
    required String label,
    required TimeOfDay time,
    required bool isEnabled,
  }) async {
    await ref
        .read(alarmsRepositoryProvider)
        .updateAlarm(
          AlarmsEntity(
            alarmId: alarmId,
            label: label,
            time: time,
            isEnabled: isEnabled,
          ),
        );
  }

  Future<void> updateEnableAlarm(AlarmsEntity alarm) async {
    await ref.read(alarmsRepositoryProvider).updateEnableAlarm(alarm);
  }

  Future<void> deleteAlarm(String alarmId) async {
    await ref.read(alarmsRepositoryProvider).deleteAlarm(alarmId);
  }
}
