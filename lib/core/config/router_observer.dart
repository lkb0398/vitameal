import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';

// 📝 GoRouter 에 연결
class RouteObserver extends NavigatorObserver {
  void _setCurrentPage(Route<dynamic>? route) {
    final routeName =
        route?.settings.name ?? route?.settings.arguments?.toString();

    if (routeName != null) {
      // Crashlytics 리포트에 페이지 명시
      FirebaseCrashlytics.instance.setCustomKey('current_page', routeName);
      // 각 페이지 진입 count > Analytics 에서 screem_view 이벤트로 보임
      FirebaseAnalytics.instance.logScreenView(screenName: routeName);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _setCurrentPage(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _setCurrentPage(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _setCurrentPage(previousRoute);
    super.didPop(route, previousRoute);
  }
}
