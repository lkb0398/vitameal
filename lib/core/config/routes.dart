import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/config/app_router_observer.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/presentation/auth/view/login_page.dart';
import 'package:vitameal/presentation/auth/view_model/auth_view_model.dart';
import 'package:vitameal/presentation/date_notation/view/date_notation_page.dart';
import 'package:vitameal/presentation/eats/view/page/eats_page.dart';
import 'package:vitameal/presentation/goal/view/page/add_goal_page.dart';
import 'package:vitameal/presentation/goal/view/page/goal_page.dart';
import 'package:vitameal/presentation/goal_data/view/page/goal_data_page.dart';
import 'package:vitameal/presentation/home/view/page/home_page.dart';
import 'package:vitameal/presentation/intro/view/intro_page.dart';
import 'package:vitameal/presentation/language/view/language_page.dart';
import 'package:vitameal/presentation/meal_editor/view/meal_editor_page.dart';
import 'package:vitameal/presentation/notification/view/page/notification_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_allergy_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_disease_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_done_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_physical_page.dart';
import 'package:vitameal/presentation/onboarding/view/page/onboarding_profile_page.dart';
import 'package:vitameal/presentation/post/view/bookmark_page.dart';
import 'package:vitameal/presentation/post/view/edit_post.dart';
import 'package:vitameal/presentation/post/view/post_detail_page.dart';
import 'package:vitameal/presentation/post/view/post_page.dart';
import 'package:vitameal/presentation/setting/view/setting_page.dart';
import 'package:vitameal/presentation/splash/view/splash_page.dart';

class AppRoutePath {
  static const home = '/';
  static const melon = '/melon';
  static const login = '/login';
  static const splash = '/splash';
  static const intro = '/intro';
  // 설정
  static const setting = '/setting';
  static const noti = '/noti';
  static const language = '/language';
  static const date = '/date';
  // 사용자 정보 입력/수정
  static const profile = '/profile';
  static const physical = '/physical';
  static const disease = '/disease';
  static const allergy = '/allergy';
  static const done = '/done';
  // 목표 및 데이터 입력/수정
  static const goal = '/goal';
  static const addGoal = '/add/goal';
  static const editGoal = '/edit/goal';
  static const data = '/data';
  // 건강 지도
  static const eats = '/eats';
  // 식단 작성 및 편집 페이지
  static const mealEditor = '/meal-editor';
  // 레시피
  static const post = '/post';
  static const editPost = '/edit/post';
  static const bookmark = '/bookmark';
}

final routerProvider = Provider<GoRouter>((ref) {
  // authViewModelProvider의 상태(Session?)를 실시간으로 감시
  //  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: AppRoutePath.splash,

    refreshListenable: _RouterRefreshListenable(ref),

    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final location = state.matchedLocation;

      print('현재 위치: $location | 세션 존재 여부: ${session != null}');

      // 비로그인 접근 차단
      if (session == null && location != AppRoutePath.login) {
        return AppRoutePath.login;
      }
      return null;
    },

    // 📝 Crashlytics, Analytics observer 연결
    observers: [AppRouteObserver()],

    // Crashlytics 페이지 기록 위해 name 속성 추가
    routes: [
      GoRoute(
        path: AppRoutePath.splash,
        name: AppRoutePath.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutePath.login,
        name: AppRoutePath.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutePath.intro,
        name: AppRoutePath.intro,
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        path: AppRoutePath.home,
        name: AppRoutePath.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutePath.setting,
        name: AppRoutePath.setting,
        builder: (context, state) => const SettingPage(),
      ),
      GoRoute(
        path: AppRoutePath.noti,
        name: AppRoutePath.noti,
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: AppRoutePath.language,
        name: AppRoutePath.language,
        builder: (context, state) => const LanguagePage(),
      ),

      /// 사용자 정보 입력/수정
      GoRoute(
        path: AppRoutePath.date,
        name: AppRoutePath.date,
        builder: (context, state) => const DateNotationPage(),
      ),
      GoRoute(
        path: AppRoutePath.profile,
        name: AppRoutePath.profile,
        builder: (context, state) {
          final isEditMode = state.extra as bool;
          return OnboardingProfilePage(isEditMode: isEditMode);
        },
      ),
      GoRoute(
        path: AppRoutePath.physical,
        name: AppRoutePath.physical,
        builder: (context, state) {
          final isEditMode = state.extra as bool;
          return OnboardingPhysicalPage(isEditMode: isEditMode);
        },
      ),
      GoRoute(
        path: AppRoutePath.disease,
        name: AppRoutePath.disease,
        builder: (context, state) {
          final isEditMode = state.extra as bool;
          return OnboardingDiseasePage(isEditMode: isEditMode);
        },
      ),
      GoRoute(
        path: AppRoutePath.allergy,
        name: AppRoutePath.allergy,
        builder: (context, state) {
          final isEditMode = state.extra as bool;
          return OnboardingAllergyPage(isEditMode: isEditMode);
        },
      ),
      GoRoute(
        path: AppRoutePath.done,
        name: AppRoutePath.done,
        builder: (context, state) => const OnboardingDonePage(),
      ),

      /// 건강 지도
      GoRoute(
        path: AppRoutePath.eats,
        name: AppRoutePath.eats,
        builder: (context, state) => const EatsPage(),
      ),

      /// 목표 및 데이터 입력/수정
      GoRoute(
        path: AppRoutePath.goal,
        name: AppRoutePath.goal,
        builder: (context, state) => const GoalPage(),
      ),
      GoRoute(
        path: AppRoutePath.addGoal,
        name: AppRoutePath.addGoal,
        builder: (context, state) => const AddGoalPage(),
      ),
      GoRoute(
        path: AppRoutePath.editGoal,
        name: AppRoutePath.editGoal,
        builder: (context, state) {
          final goal = state.extra as GoalsEntity;
          return AddGoalPage(goal: goal);
        },
      ),
      GoRoute(
        path: AppRoutePath.data,
        name: AppRoutePath.data,
        builder: (context, state) {
          final goal = state.extra as GoalsEntity;
          return GoalDataPage(goal: goal);
        },
      ),

      /// 식단 작성 및 편집 페이지
      GoRoute(
        path: AppRoutePath.mealEditor,
        name: AppRoutePath.mealEditor,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return MealEditorPage(
            mealEntryId: extra?['mealEntryId'] as String?,
            mealDayId: extra?['mealDayId'] as String?,
            date: extra?['date'] as DateTime? ?? DateTime.now(),
          );
        },
      ),

      /// 레시피
      GoRoute(
        path: AppRoutePath.editPost,
        name: AppRoutePath.editPost,
        builder: (context, state) {
          final post = state.extra as PostEntity?;
          return EditPost(initialPost: post);
        },
      ),
      GoRoute(
        path: AppRoutePath.bookmark,
        name: AppRoutePath.bookmark,
        builder: (context, state) => const BookmarkPage(),
      ),
      GoRoute(
        path: AppRoutePath.post,
        name: AppRoutePath.post,
        builder: (context, state) => PostPage(),
        routes: [
          GoRoute(
            path: ":id",
            builder: (context, state) {
              final String? pId = state.pathParameters['id'];
              if (pId == null) {
                return PostPage();
              }
              return PostDetailPage(pId: pId);
            },
          ),
        ],
      ),
    ],
  );
});

class _RouterRefreshListenable extends ChangeNotifier {
  _RouterRefreshListenable(Ref ref) {
    // authViewModelProvider의 상태가 변할 때마다 notifyListeners() 호출
    ref.listen(authViewModelProvider, (_, __) => notifyListeners());
  }
}
