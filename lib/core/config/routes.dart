import 'package:go_router/go_router.dart';
import 'package:vitameal/presentation/info/view/goal_page.dart';
import 'package:vitameal/presentation/info/view/info_page.dart';
import 'package:vitameal/presentation/set/view/set_allergy_page.dart';
import 'package:vitameal/presentation/set/view/set_disease_page.dart';
import 'package:vitameal/presentation/set/view/set_done_page.dart';
import 'package:vitameal/presentation/set/view/set_physical_page.dart';
import 'package:vitameal/presentation/set/view/set_profile_page.dart';

class AppRoutePath {
  static const setting = '/setting';
  static const melon = '/melon';
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

final GoRouter router = GoRouter(
  initialLocation: AppRoutePath.setProfile,

  routes: [
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
      path: AppRoutePath.info,
      builder: (context, state) => const InfoPage(),
    ),
    GoRoute(
      path: AppRoutePath.goal,
      builder: (context, state) => const GoalPage(),
    ),
  ],
);
