import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/presentation/intro/model/intro_content.dart';
import 'package:vitameal/presentation/intro/view/widgets/intro_controls.dart';
import 'package:vitameal/presentation/intro/view/widgets/intro_item.dart';

class IntroPage extends HookConsumerWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    final pageController = usePageController();
    final currentPage = useState(0);

    final introItems = [
      IntroContent(
        title: l.intro_1_title,
        highlight: l.intro_1_highlight,
        image: "assets/images/intro_1.png",
      ),
      IntroContent(
        title: l.intro_2_title,
        highlight: l.intro_2_highlight,
        image: "assets/images/intro_2.png",
      ),
      IntroContent(
        title: l.intro_3_title,
        highlight: l.intro_3_highlight,
        image: "assets/images/intro_3.png",
      ),
      IntroContent(
        title: l.intro_4_title,
        highlight: l.intro_4_highlight,
        image: "assets/images/intro_4.png",
      ),
    ];

    void navigateToOnboarding() => context.push(AppRoutePath.onboardingProfile);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 슬라이더 영역
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) => currentPage.value = value,
                itemCount: introItems.length,
                itemBuilder: (context, index) =>
                    IntroItem(item: introItems[index]),
              ),
            ),
            // 하단 컨트롤 영역
            IntroControls(
              itemsCount: introItems.length,
              currentIndex: currentPage.value,
              onNext: () {
                if (currentPage.value < introItems.length - 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  navigateToOnboarding();
                }
              },
              onSkip: navigateToOnboarding,
            ),
          ],
        ),
      ),
    );
  }
}
