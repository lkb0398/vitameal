import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/presentation/goal/view/add_goal_page.dart';
import 'package:vitameal/presentation/goal/view/entity.dart';
import 'package:vitameal/presentation/goal/view/goal_page.dart';
import 'package:vitameal/presentation/home/view/page/home_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_allergy_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_disease_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_done_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_physical_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_profile_page.dart';
import 'package:vitameal/presentation/setting/view/setting_page.dart';
import 'package:vitameal/presentation/splash/view/splash_page.dart';
import 'package:vitameal/presentation/ui_provider/onboarding_provider.dart';
import '../../presentation/auth/view/login_page.dart';
import '../../presentation/auth/view_model/auth_view_model.dart';

class AppRoutePath {
  static const setting = '/setting';
  static const melon = '/melon';
  static const login = '/login';
  static const splash = '/splash';
  static const home = '/';
  // 사용자 정보 입력/수정
  static const onboardingProfile = '/onboarding/profile';
  static const onboardingPhysical = '/onboarding/physical';
  static const onboardingDisease = '/onboarding/disease';
  static const onboardingAllergy = '/onboarding/allergy';
  static const onboardingDone = '/onboarding/done';
  static const editProfile = '/edit/profile';
  static const editPhysical = '/edit/physical';
  static const editDisease = '/edit/disease';
  static const editAllergy = '/edit/allergy';
  // 목표 입력/수정
  static const goal = '/goal';
  static const addGoal = '/add/goal';
  static const editGoal = '/edit/goal';
}

final routerProvider = Provider<GoRouter>((ref) {
  // authViewModelProvider의 상태(Session?)를 실시간으로 감시
  //  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: AppRoutePath.splash,

    // 인증 상태가 변경될 때마다 redirect 다시 실행
    refreshListenable: _RouterRefreshStream(
      ref.read(authViewModelProvider.notifier).stream,
    ),

    redirect: (context, state) {
      // final isLoggedIn = authState != null;
      // final isLoggingIn = state.matchedLocation == AppRoutePath.login;
      //
      // if (!isLoggedIn) {
      //         return isLoggingIn ? null : AppRoutePath.login;
      //       }
      //       if (isLoggingIn) {
      //         return AppRoutePath.home;
      //       }
      //       return null;

      final session = Supabase.instance.client.auth.currentSession;
      final location = state.matchedLocation;

      // 비로그인 접근 차단
      if (session == null && location != AppRoutePath.login) {
        return AppRoutePath.login;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: AppRoutePath.splash,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: AppRoutePath.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutePath.onboardingProfile,
        builder: (context, state) => const OnboardingProfilePage(),
      ),
      GoRoute(
        path: AppRoutePath.onboardingPhysical,
        builder: (context, state) => const OnboardingPhysicalPage(),
      ),
      GoRoute(
        path: AppRoutePath.onboardingDisease,
        builder: (context, state) => const OnboardingDiseasePage(),
      ),
      GoRoute(
        path: AppRoutePath.onboardingAllergy,
        builder: (context, state) => const OnboardingAllergyPage(),
      ),
      GoRoute(
        path: AppRoutePath.onboardingDone,
        builder: (context, state) => const OnboardingDonePage(),
      ),
      GoRoute(
        path: AppRoutePath.editProfile,
        builder: (context, state) => const OnboardingProfilePage(),
      ),
      GoRoute(
        path: AppRoutePath.editPhysical,
        builder: (context, state) => const OnboardingPhysicalPage(),
      ),
      GoRoute(
        path: AppRoutePath.editDisease,
        builder: (context, state) => const OnboardingDiseasePage(),
      ),
      GoRoute(
        path: AppRoutePath.editAllergy,
        builder: (context, state) => const OnboardingAllergyPage(),
      ),
      GoRoute(
        path: AppRoutePath.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutePath.setting,
        builder: (context, state) => const SettingPage(),
      ),
      GoRoute(
        path: AppRoutePath.goal,
        builder: (context, state) => const GoalPage(),
      ),
      GoRoute(
        path: AppRoutePath.addGoal,
        builder: (context, state) => const AddGoalPage(),
      ),
      GoRoute(
        path: AppRoutePath.editGoal,
        builder: (context, state) {
          final goal = state.extra as GoalsEntity;
          return AddGoalPage(goal: goal);
        },
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
