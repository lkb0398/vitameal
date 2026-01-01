import 'package:vitameal/presentation/alarm/view_model/alarms_entity.dart';

abstract interface class AlarmsRepository {
  Future<List<AlarmsEntity>?> getAllAlarms();
  Future<void> saveAlarm(AlarmsEntity entity);
  Future<void> updateAlarm(AlarmsEntity entity);
  Future<void> updateEnableAlarm(AlarmsEntity entity);
  Future<void> deleteAlarm(String alarmId);
}
