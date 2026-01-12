import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final _analytics = FirebaseAnalytics.instance;

  static void appOpen() {
    _analytics.logAppOpen();
  }

  static void event(String name, {Map<String, Object>? p}) {
    _analytics.logEvent(name: name, parameters: p);
  }
}

  // 📝 사용 예시
  // AnalyticsService.event(
  //   'save_meal', // 이벤트명
  //   p: {'meal_type': 'breakfast'}, // 전달할 파라미터 (선택)
  // );