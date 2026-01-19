import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasNavigated = useRef(false);

    useEffect(() {
      Future.microtask(() async {
        // 이미 네비게이션 수행되었으면 중복 실행 방지
        if (hasNavigated.value) return;
        try {
          // 최소 1초간 스플래시 유지
          await Future.delayed(const Duration(seconds: 1));

          // 로그인 여부 확인
          final session = Supabase.instance.client.auth.currentSession;
          if (!context.mounted) return;

          // 미로그인은 무조건 로그인 페이지 이동 (오프라인이어도)
          if (session == null) {
            hasNavigated.value = true;
            context.go(AppRoutePath.login);
            return;
          }

          // 여기부터는 이미 로그인된 사용자
          final connectivity = await Connectivity().checkConnectivity();
          final isOffline = connectivity.contains(ConnectivityResult.none);

          // 로그인 세션이 있는 사용자만 오프라인 홈 허용
          if (!context.mounted) return;
          if (isOffline) {
            hasNavigated.value = true;
            context.go(AppRoutePath.home);
            return;
          }

          // 온보딩 X > 온보딩 페이지 이동
          final isOnboarded = await ref.read(
            onboardingCompletedProvider.future,
          );
          if (!context.mounted) return;

          hasNavigated.value = true;
          if (!isOnboarded) {
            // 로그인 O & 온보딩 X > 온보딩 페이지 이동
            context.go(AppRoutePath.intro);
          } else {
            // 로그인 O & 온보딩 O > 홈페이지 이동
            context.go(AppRoutePath.home);
          }
        } catch (e) {
          debugPrint("SplashPage 초기화 중 에러: $e");
          final session = Supabase.instance.client.auth.currentSession;
          if (context.mounted) {
            hasNavigated.value = true;
            // 미로그인: 로그인 페이지
            // 로그인: 홈(오프라인 모드)
            context.go(
              session == null ? AppRoutePath.login : AppRoutePath.home,
            );
          }
        }
      });

      return null;
    }, const []);

    // 로고
    return Scaffold(
      backgroundColor: vrc(context).background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 44),
            SvgPicture.asset('assets/images/splash_app_name.svg', width: 200),
          ],
        ),
      ),
    );
  }
}
