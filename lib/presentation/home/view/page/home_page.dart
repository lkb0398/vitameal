import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/home/view/widget/custom_bottom_nav.dart';
import 'package:vitameal/presentation/info/view/page/info_page.dart';
import 'package:vitameal/presentation/meal_calendar/view/meal_calendar_page.dart';
import 'package:vitameal/presentation/ui_provider/home_tab_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  static const _pages = [
    MealCalendarPage(),
    InfoPage(), // TODO : 레시피 페이지로 바꾸기
    InfoPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeTabProvider);

    return Scaffold(
      // 탭 전환시 기존탭이 dispose 되지않도록 IndexedStack 사용 (UI 상태 유지)
      body: IndexedStack(index: index, children: _pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: index,
        onTap: (i) {
          ref.read(homeTabProvider.notifier).change(i);
        },
      ),
    );
  }
}
