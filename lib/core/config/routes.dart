import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/auth/view/login_page.dart';
import '../../presentation/auth/view_model/auth_view_model.dart';
// import 'package:vitameal/presentation/info/view/goal_page.dart';
// import 'package:vitameal/presentation/info/view/info_page.dart';
// import 'package:vitameal/presentation/set/view/set_allergy_page.dart';
// import 'package:vitameal/presentation/set/view/set_disease_page.dart';
// import 'package:vitameal/presentation/set/view/set_done_page.dart';
// import 'package:vitameal/presentation/set/view/set_physical_page.dart';
// import 'package:vitameal/presentation/set/view/set_profile_page.dart';

class AppRoutePath {
  static const setting = '/setting';
  static const melon = '/melon';
  static const login = '/login';
  static const home = '/home'; // 임시 홈
  // 사용자 정보 설정
  static const setProfile = '/set-profile';
  static const setPhysical = '/set-physical';
  static const setDisease = '/set-disease';
  static const setAllergy = '/set-allergy';
  static const setDone = '/set-done';
  // 내 정보
  static const info = '/info';
  static const goal = '/goal';
}

final routerProvider = Provider<GoRouter>((ref) {
  // authViewModelProvider의 상태(Session?)를 실시간으로 감시

  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: AppRoutePath.login,

    // 인증 상태가 변경될 때마다 redirect 다시 실행
    refreshListenable: _RouterRefreshStream(
      ref.read(authViewModelProvider.notifier).stream,
    ),

    redirect: (context, state) {
      final isLoggedIn = authState != null;
      final isLoggingIn = state.matchedLocation == AppRoutePath.login;

      if (!isLoggedIn) {
        return isLoggingIn ? null : AppRoutePath.login;
      }
      if (isLoggingIn) {
        return AppRoutePath.home;
      }
      return null;
    },

    routes: [
      GoRoute(
        path: AppRoutePath.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutePath.home,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('메롱 메롱 메롱 메롱 메롱 메롱 '))),
      ),
      // GoRoute(
      //   path: AppRoutePath.setProfile,
      //   builder: (context, state) => const SetProfilePage(),
      // ),
      // GoRoute(
      //   path: AppRoutePath.setPhysical,
      //   builder: (context, state) => const SetPhysicalPage(),
      // ),
      // GoRoute(
      //   path: AppRoutePath.setDisease,
      //   builder: (context, state) => const SetDiseasePage(),
      // ),
      // GoRoute(
      //   path: AppRoutePath.setAllergy,
      //   builder: (context, state) => const SetAllergyPage(),
      // ),
      // GoRoute(
      //   path: AppRoutePath.setDone,
      //   builder: (context, state) => const SetDonePage(),
      // ),
      // GoRoute(
      //   path: AppRoutePath.info,
      //   builder: (context, state) => const InfoPage(),
      // ),
      // GoRoute(
      //   path: AppRoutePath.goal,
      //   builder: (context, state) => const GoalPage(),
      // ),
    ],
  );
});

// Stream을 GoRouter가 이해할 수 있는 Listenable로 변환
class _RouterRefreshStream extends ChangeNotifier {
  _RouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }
}
