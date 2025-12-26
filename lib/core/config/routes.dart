import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitameal/presentation/home/view/home_page.dart';
import 'package:vitameal/presentation/set/view/page/set_allergy_page.dart';
import 'package:vitameal/presentation/set/view/page/set_disease_page.dart';
import 'package:vitameal/presentation/set/view/page/set_done_page.dart';
import 'package:vitameal/presentation/set/view/page/set_physical_page.dart';
import 'package:vitameal/presentation/set/view/page/set_profile_page.dart';
import 'package:vitameal/presentation/ui_provider/set_provider.dart';
import '../../presentation/auth/view/login_page.dart';
import '../../presentation/auth/view_model/auth_view_model.dart';

class AppRoutePath {
  static const setting = '/setting';
  static const melon = '/melon';
  static const login = '/login';
  static const home = '/';
  // 사용자 정보 입력
  static const setProfile = '/set/profile';
  static const setPhysical = '/set/physical';
  static const setDisease = '/set/disease';
  static const setAllergy = '/set/allergy';
  static const setDone = '/set/done';
  // 사용자 정보 수정
  static const editProfile = '/edit/profile';
  static const editPhysical = '/edit/physical';
  static const editDisease = '/edit/disease';
  static const editAllergy = '/edit/allergy';
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

    redirect: (context, state) async {
      final isLoggedIn = authState != null;
      final isLoggingIn = state.matchedLocation == AppRoutePath.login;

      final location = state.matchedLocation;
      final isOnboarded = ref.read(onboardingStateProvider);

      // 1. 로그인 X > 로그인 페이지
      if (!isLoggedIn) {
        return isLoggingIn ? null : AppRoutePath.login;
      }

      // 2. 수정 플로우 > redirect X
      if (location == AppRoutePath.home || location.startsWith('/edit')) {
        return null;
      }

      // 3. 온보딩 플로우 > 온보딩+정보입력 페이지
      if (!isOnboarded) {
        // 온보딩 했는데 연동 안된 경우
        final isActuallyCompleted = await ref.read(
          onboardingCompletedProvider.future,
        );
        if (isActuallyCompleted) {
          ref.read(onboardingStateProvider.notifier).set(true);
          return AppRoutePath.home;
        }
        // 온보딩 안 한 경우
        if (location.startsWith('/set')) {
          return null;
        }
        return AppRoutePath.setProfile;
      }

      // 4. 온보딩 완료 > 홈 페이지
      if (location.startsWith('/set') || location == AppRoutePath.login) {
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
        path: AppRoutePath.setProfile,
        builder: (context, state) => const SetProfilePage(),
      ),
      GoRoute(
        path: AppRoutePath.setPhysical,
        builder: (context, state) => const SetPhysicalPage(),
      ),
      GoRoute(
        path: AppRoutePath.setDisease,
        builder: (context, state) => const SetDiseasePage(),
      ),
      GoRoute(
        path: AppRoutePath.setAllergy,
        builder: (context, state) => const SetAllergyPage(),
      ),
      GoRoute(
        path: AppRoutePath.setDone,
        builder: (context, state) => const SetDonePage(),
      ),
      GoRoute(
        path: AppRoutePath.editProfile,
        builder: (context, state) => const SetProfilePage(),
      ),
      GoRoute(
        path: AppRoutePath.editPhysical,
        builder: (context, state) => const SetPhysicalPage(),
      ),
      GoRoute(
        path: AppRoutePath.editDisease,
        builder: (context, state) => const SetDiseasePage(),
      ),
      GoRoute(
        path: AppRoutePath.editAllergy,
        builder: (context, state) => const SetAllergyPage(),
      ),
      GoRoute(
        path: AppRoutePath.home,
        builder: (context, state) => const HomePage(),
      ),
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
