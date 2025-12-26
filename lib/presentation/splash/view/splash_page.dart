import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/presentation/ui_provider/onboarding_provider.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasNavigated = useRef(false);

    useEffect(() {
      Future.microtask(() async {
        if (hasNavigated.value) return;
        hasNavigated.value = true;

        // 로그인 X > 로그인 페이지 이동
        final session = Supabase.instance.client.auth.currentSession;
        if (!context.mounted) return;
        if (session == null) {
          context.go(AppRoutePath.login);
          return;
        }

        // 온보딩 X > 온보딩 페이지 이동
        final isOnboarded = await ref.read(onboardingCompletedProvider.future);
        if (!context.mounted) return;
        if (!isOnboarded) {
          context.go(AppRoutePath.onboardingProfile);
          return;
        }

        // 로그인 O, 온보딩 O > 홈 페이지 이동
        context.go(AppRoutePath.home);
      });

      return null;
    }, const []);

    return const Scaffold(body: Center(child: Text("스플래시 페이지")));
  }
}
