import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/onboarding_view_model.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';

class OnboardingDonePage extends HookConsumerWidget {
  const OnboardingDonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 프로필 불러오기 (닉네임 연동용)
    final profileAsync = ref.watch(myProfileProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scaleX: -1,
              child: Text("🎉", style: TextStyle(fontSize: 100)),
            ),

            Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: fxc(context).textcolor400,
                ),
                children: [
                  TextSpan(text: '환영합니다, '),
                  TextSpan(
                    text: profileAsync.when(
                      data: (profile) => "${profile?.nickname}",
                      loading: () => "회원",
                      error: (_, __) => "회원",
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '님!'),
                ],
              ),
            ),
            Text(
              '가입이 완료되었어요',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: vrc(context).text,
              ),
            ),
          ],
        ),
      ),

      /// 하단 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DoneButton(
          onTap: () async {
            // 프로필 업데이트
            await ref
                .read(onboardingViewModelProvider.notifier)
                .updateProfile(onboardingCompleted: true);
            // 로컬 라우팅 상태도 즉시 true로 반영
            ref.read(onboardingStateProvider.notifier).set(true);
            // mounted 체크
            if (!context.mounted) return;
            // 페이지 이동
            context.go('/');
          },
          backgroundColor: fxc(context).primary400!,
          text: "시작하기",
          textColor: Colors.white,
        ),
      ),
    );
  }
}
