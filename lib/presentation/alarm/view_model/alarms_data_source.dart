import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_dto.dart';

abstract interface class AlarmsDataSource {
  Future<List<AlarmsDto>?> getAllAlarms();
  Future<void> saveAlarm(AlarmsDto dto);
  Future<void> updateAlarm(AlarmsDto dto);
  Future<void> updateEnableAlarm(AlarmsDto dto);
  Future<void> deleteAlarm(String alarmId);
}

class AlarmsDataSourceImpl implements AlarmsDataSource {
  AlarmsDataSourceImpl(this.client);

  final SupabaseClient client;

  @override // R (전체)
  Future<List<AlarmsDto>?> getAllAlarms() async {
    try {
      final response = await client
          .from('alarms')
          .select()
          .order('time', ascending: true) // 알람 시간순 정렬
          .order('created_at', ascending: true);
      return (response as List).map((e) => AlarmsDto.fromJson(e)).toList();
    } on PostgrestException catch (e, s) {
      log('DB 오류로 인한 getAllAlarms 실패 : ${e.message}', error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 getAllAlarms 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override // C
  Future<void> saveAlarm(AlarmsDto dto) async {
    try {
      final map = {
        'user_id': dto.userId,
        'label': dto.label,
        'time': dto.time,
        'is_enabled': dto.isEnabled,
      };
      await client.from('alarms').insert(map);
    } on PostgrestException catch (e, s) {
      log('DB 오류로 인한 saveAlarm 실패 : ${e.message}', error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 saveAlarm 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override // U
  Future<void> updateAlarm(AlarmsDto dto) async {
    try {
      final map = {
        'label': dto.label,
        'time': dto.time,
        'is_enabled': dto.isEnabled,
      };
      await client.from('alarms').update(map).eq('alarm_id', dto.alarmId!);
    } on PostgrestException catch (e, s) {
      log('DB 오류로 인한 updateAlarm 실패 : ${e.message}', error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 updateAlarm 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override // U (isEnabled 업데이트)
  Future<void> updateEnableAlarm(AlarmsDto dto) async {
    try {
      await client
          .from('alarms')
          .update({'is_enabled': !dto.isEnabled})
          .eq('alarm_id', dto.alarmId!);
    } on PostgrestException catch (e, s) {
      log(
        'DB 오류로 인한 updateEnableAlarm 실패 : ${e.message}',
        error: e,
        stackTrace: s,
      );
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 updateEnableAlarm 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override // D
  Future<void> deleteAlarm(String alarmId) async {
    try {
      await client.from('alarms').delete().eq('alarm_id', alarmId);
    } on PostgrestException catch (e, s) {
      log('DB 오류로 인한 deleteAlarm 실패 : ${e.message}', error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 deleteAlarm 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }
}
