import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_entity.dart';

part 'alarms_provider.g.dart';

/// 전체 알람 가져오기 Provider
@riverpod
Future<List<AlarmsEntity>?> getAllAlarms(Ref ref) async {
  return await ref.read(alarmsRepositoryProvider).getAllAlarms();
}
