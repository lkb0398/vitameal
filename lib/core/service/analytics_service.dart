import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final _analytics = FirebaseAnalytics.instance;

  static Future<void> log(String name, {Map<String, Object>? params}) {
    return _analytics.logEvent(name: name, parameters: params);
  }
}

// 📝 사용 예시
// AnalyticsService.log(
//   'save_meal', // 이벤트명
//   params: {'meal_type': 'breakfast'}, // 전달할 파라미터 (선택)
// );
