import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
<<<<<<< HEAD
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import '../view_model/auth_view_model.dart';
import 'widgets/social_login_button.dart';
=======
import 'package:vitameal/presentation/auth/view_model/auth_view_model.dart';
import 'package:vitameal/presentation/auth/view/widgets/social_login_button.dart';
>>>>>>> 3f1cbb3 (feat: UI를 제외한 기능구현 및 리팩토링 완료)

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 세션 상태 감시 (로그인 여부)
    final session = ref.watch(authViewModelProvider);

    // 로그인 성공 이후 라우팅 처리
    useEffect(() {
      if (session == null) return null;
      Future.microtask(() async {
        if (!context.mounted) return;
        final isOnboarded = await ref.read(onboardingCompletedProvider.future);
        if (!context.mounted) return;
        if (isOnboarded) {
          context.go(AppRoutePath.home); // 온보딩 O > 홈 페이지
        } else {
          context.go(AppRoutePath.onboardingProfile); // 온보딩 X > 온보딩 페이지
        }
      });
      return null;
    }, [session]);

    final vm = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: session != null
                  ? const Center(child: CircularProgressIndicator())
                  : _buildLoginState(ref), // ref를 전달하여 내부에서 vm 접근
            ),
          ),

          // 로딩 오버레이 레이어 (로그인 진행 중일 때만 표시)
          if (vm.isLoading)
            Container(
              color: Colors.black.withOpacity(0.3), // 배경을 어둡게 해서 터치 차단
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 로그인 전 상태의 UI
  Widget _buildLoginState(WidgetRef ref) {
    final vm = ref.read(authViewModelProvider.notifier);

    return Column(
      children: [
        const Spacer(flex: 2),

        Image.asset('assets/images/logo.png', height: 180, fit: BoxFit.contain),

        const Spacer(flex: 1),

        SocialLoginButton(
          label: 'Apple로 시작하기(미구현)',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          // 로딩 중이면 버튼 클릭 무시
          onPressed: vm.isLoading ? () {} : () => vm.login(OAuthProvider.apple),
        ),
        const SizedBox(height: 16),

        SocialLoginButton(
          label: 'Google로 시작하기',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          onPressed: vm.isLoading
              ? () {}
              : () => vm.login(OAuthProvider.google),
        ),
        const SizedBox(height: 16),

        SocialLoginButton(
          label: '카카오로 시작하기',
          backgroundColor: const Color(0xfffee500),
          textColor: Colors.black,
          onPressed: vm.isLoading ? () {} : () => vm.login(OAuthProvider.kakao),
        ),

        const Spacer(flex: 1),
      ],
    );
  }
}
