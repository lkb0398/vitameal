import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/notifications_entity.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'notifications_view_model.g.dart';

@Riverpod(keepAlive: true)
class NotificationsViewModel extends _$NotificationsViewModel {
  // State : 알림 전체 목록 (Async)
  @override
  Future<List<NotificationsEntity>?> build() async {
    return ref.read(notificationsRepositoryProvider).readNotis();
  }

  // [알림 추가]
  Future<void> addNoti({required String label, required TimeOfDay time}) async {
    final userId = ref.read(userIdProvider);
    final timezone = await _getTimezone();
    final newNoti = NotificationsEntity(
      userId: userId,
      label: label,
      time: time,
      isEnabled: true,
      timezone: timezone,
    );

    // 낙관적 업데이트
    final current = state.value ?? [];
    state = AsyncData([...current, newNoti]);

    // 서버 반영
    try {
      await ref.read(notificationsRepositoryProvider).createNoti(newNoti);
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }

  // [알림 수정]
  Future<void> updateNoti({
    required NotificationsEntity prev,
    required String label,
    required TimeOfDay time,
  }) async {
    final timezone = await _getTimezone();
    final updatedNoti = prev.copyWith(
      label: label,
      time: time,
      timezone: timezone,
    );

    // 낙관적 업데이트
    final current = state.value ?? [];
    final newList = [
      for (final n in current) n.notiId == updatedNoti.notiId ? updatedNoti : n,
    ];
    state = AsyncData(newList);

    // 서버 반영
    try {
      await ref.read(notificationsRepositoryProvider).updateNoti(updatedNoti);
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }

  // [알림 삭제]
  Future<void> deleteNoti({required String id}) async {
    // 낙관적 업데이트
    final current = state.value ?? [];
    state = AsyncData(current.where((n) => n.notiId != id).toList());

    // 서버 반영
    try {
      await ref.read(notificationsRepositoryProvider).deleteNoti(id);
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }

  // [알림 활성화 여부 변경]
  Future<void> switchEnabled({required String? id, required bool v}) async {
    if (id == null) return;

    // 낙관적 업데이트
    final current = state.value ?? [];
    final newList = [
      for (final n in current) n.notiId == id ? n.copyWith(isEnabled: v) : n,
    ];
    state = AsyncData(newList);

    // 서버 반영
    try {
      await ref
          .read(notificationsRepositoryProvider)
          .updateNoti(
            current.firstWhere((n) => n.notiId == id).copyWith(isEnabled: v),
          );
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }

  // [timezone 가져오기]
  Future<String> _getTimezone() async {
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      final timezone = info.identifier;

      return timezone;
    } catch (_) {
      return "Asia/Tokyo"; // 디버깅용
    }
  }
}
