import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/set/viewmodel/set_view_model.dart';
import 'package:vitameal/presentation/ui_provider/set_provider.dart';

class SetDonePage extends HookConsumerWidget {
  const SetDonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 프로필 불러오기 (닉네임 연동용)
    final profileAsync = ref.watch(myProfileProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            // TODO :  애니메이션 적용
            Text("🎉", style: TextStyle(fontSize: 150)),
            profileAsync.when(
              data: (profile) => Text("환영합니다 ${profile?.nickname ?? '회원'}님!"),
              loading: () => const Text("환영합니다!"),
              error: (_, __) => const Text("환영합니다!"),
            ),
            Text("가입이 완료되었어요"),
          ],
        ),
      ),

      /// 하단 버튼
      bottomNavigationBar: InkWell(
        onTap: () async {
          // 프로필 업데이트
          await ref
              .read(setViewModelProvider.notifier)
              .updateProfile(onboardingCompleted: true);

          // 로컬 라우팅 상태도 즉시 true로 반영
          ref.read(onboardingStateProvider.notifier).set(true);

          // mounted 체크
          if (!context.mounted) return;

          // 페이지 이동
          context.go('/');
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          child: Text("둘러보기"),
        ),
      ),
    );
  }
}
