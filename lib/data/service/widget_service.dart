import 'package:flutter/foundation.dart';
import 'package:vitameal/core/platform/widget_bridge.dart';
import 'package:vitameal/domain/entity/meal_day_entity.dart';
import 'package:vitameal/domain/repository/meal_repository.dart';

/// iOS 위젯에 데이터를 전달
class WidgetService {
  WidgetService({required MealRepository mealRepository, WidgetBridge? widgetBridge})
    : _mealRepository = mealRepository,
      _widgetBridge = widgetBridge ?? WidgetBridge.instance;

  final MealRepository _mealRepository;
  final WidgetBridge _widgetBridge;

  /// 이번 달의 성취도 데이터를 위젯에 업데이트
  Future<void> updateWidgetData(String userId) async {
    try {
      final now = DateTime.now();

      // 이번 달의 MealDay 데이터 조회
      final mealDays = await _mealRepository.getMealDaysByDateRange(
        userId: userId,
        startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(now.year, now.month + 1, 0),
      );

      // JSON 데이터 생성
      final widgetData = _buildWidgetData(mealDays, now.year, now.month);

      // WidgetBridge를 통해 Native로 전달
      await _widgetBridge.updateWidgetData(widgetData);

      debugPrint('📱 위젯 업데이트 완료 [${now.year}-${now.month}월]');
    } catch (e, stackTrace) {
      debugPrint('📱 위젯 업데이트 실패: $e');
      debugPrint(stackTrace.toString());
    }
  }

  /// MealDay 목록을 위젯용 JSON으로 변환
  Map<String, dynamic> _buildWidgetData(List<MealDayEntity> mealDays, int year, int month) {
    // 날짜별 성취도 맵 생성
    // {"1": "followed", "2": null, "3": "partial", ...} 형태
    final Map<String, String?> achievementMap = {};

    for (final mealDay in mealDays) {
      final day = mealDay.mealDate.day; // 1~31
      final adherenceValue = mealDay.adherence?.value; // not_followed, partial, followed, null
      achievementMap[day.toString()] = adherenceValue;
    }

    return {
      'year': year,
      'month': month,
      'achievements': achievementMap,
    };
  }

  /// 위젯 강제 새로고침 (Timeline Reload)
  Future<void> reloadWidget() async {
    await _widgetBridge.reloadWidget();
    debugPrint('📱 위젯 새로고침 완료');
  }
}
