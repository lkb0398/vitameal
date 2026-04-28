import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/profiles_view_model.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';

class OnboardingDonePage extends HookConsumerWidget {
  const OnboardingDonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    final profileAsync = ref.watch(profilesViewModelProvider);
    final profileVM = ref.read(profilesViewModelProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scaleX: -1,
              child: Text("🎉", style: TextStyle(fontSize: 100)),
            ),
            Text(
              profileAsync.when(
                loading: () => "${l.welcome}!",
                error: (_, __) => "${l.welcome}!",
                data: (profile) => "${l.welcome}, ${profile?.nickname}!",
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: f.textcolor400,
              ),
            ),
            Text(
              l.signup_complete,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: v.text,
              ),
            ),
          ],
        ),
      ),

      /// 완료 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DoneButton(
          onTap: () async {
            // [프로필 수정]
            await profileVM.updateProfile(onboardingCompleted: true);
            // 로컬 라우팅 상태도 즉시 true로 반영
            ref.read(onboardingStateProvider.notifier).set(true);

            if (!context.mounted) return;
            context.go(AppRoutePath.home);
            // 📝
            AnalyticsService.event('obd_completed');
          },
          backgroundColor: f.primary400!,
          text: l.start,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
