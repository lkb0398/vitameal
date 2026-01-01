import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarms_dto.freezed.dart';
part 'alarms_dto.g.dart';

@freezed
abstract class AlarmsDto with _$AlarmsDto {
  const factory AlarmsDto({
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'alarm_id') String? alarmId,
    required String label,
    required String time,
    @JsonKey(name: 'is_enabled') required bool isEnabled,
  }) = _AlarmsDto;

  factory AlarmsDto.fromJson(Map<String, dynamic> json) =>
      _$AlarmsDtoFromJson(json);
}
