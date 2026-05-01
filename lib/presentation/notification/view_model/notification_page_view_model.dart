import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/domain/entity/notifications_entity.dart';

part 'notification_page_view_model.freezed.dart';
part 'notification_page_view_model.g.dart';

// ==================== State ====================

@freezed
abstract class NotificationPageState with _$NotificationPageState {
  // State
  const factory NotificationPageState({
    String? label, // 알림명
    TimeOfDay? selectedTime, // 시간
  }) = _NotificationPageState;

  // 수정모드 초기값
  factory NotificationPageState.edit(NotificationsEntity noti) {
    return NotificationPageState(label: noti.label, selectedTime: noti.time);
  }
}

// ==================== ViewModel ====================

@riverpod
class NotificationPageViewModel extends _$NotificationPageViewModel {
  @override
  NotificationPageState build({required NotificationsEntity? noti}) {
    return _initState(noti);
  }

  // [상태 초기값 세팅]
  static NotificationPageState _initState(NotificationsEntity? noti) {
    if (noti == null) {
      // 기본
      final state = NotificationPageState(
        label: '',
        selectedTime: TimeOfDay.now(),
      );
      return state;
    } else {
      // 수정모드
      final state = NotificationPageState.edit(noti);
      return state;
    }
  }

  // [알림명 변경]
  void updateLabel(String v) => state = state.copyWith(label: v);

  // [알림 시간 변경]
  void updateSelectedTime(TimeOfDay v) =>
      state = state.copyWith(selectedTime: v);
}
