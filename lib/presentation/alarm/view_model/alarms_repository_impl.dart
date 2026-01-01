import 'package:vitameal/presentation/alarm/view_model/alarms_data_source.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_entity.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_mapper.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_repository.dart';

class AlarmsRepositoryImpl implements AlarmsRepository {
  AlarmsRepositoryImpl(this.dataSource);

  final AlarmsDataSource dataSource;

  @override
  Future<List<AlarmsEntity>?> getAllAlarms() async {
    final dtos = await dataSource.getAllAlarms();
    if (dtos == null) return [];
    return dtos.map(AlarmsMapper.toEntity).toList();
  }

  @override
  Future<void> saveAlarm(AlarmsEntity entity) async {
    final dto = AlarmsMapper.toDto(entity);
    await dataSource.saveAlarm(dto);
  }

  @override
  Future<void> updateAlarm(AlarmsEntity entity) async {
    final dto = AlarmsMapper.toDto(entity);
    await dataSource.updateAlarm(dto);
  }

  @override
  Future<void> updateEnableAlarm(AlarmsEntity entity) async {
    final dto = AlarmsMapper.toDto(entity);
    await dataSource.updateEnableAlarm(dto);
  }

  @override
  Future<void> deleteAlarm(String alarmId) async {
    await dataSource.deleteAlarm(alarmId);
  }
}
