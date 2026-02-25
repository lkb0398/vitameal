import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tutorial_provider.g.dart';

/// 식단 기록 페이지 튜토리얼 완료 여부 provider
@riverpod
class MealTutorialShown extends _$MealTutorialShown {
  static const _prefKey = 'meal_calendar_tutorial_shown';

  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefKey) ?? false;
  }

  Future<void> markShown() async {
    state = const AsyncData(true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, true);
  }
}
