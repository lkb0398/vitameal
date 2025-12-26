import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/home/view/page/info_page.dart';
import 'package:vitameal/presentation/ui_provider/home_tab_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeTabProvider);

    final pages = [
      const InfoPage(), // TODO : 식단 페이지로 바꾸기
      const InfoPage(), // TODO : 레시피 페이지로 바꾸기
      const InfoPage(), // 내정보
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => ref.read(homeTabProvider.notifier).change(i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.square), label: '식단'),
          BottomNavigationBarItem(icon: Icon(Icons.square), label: '레시피 피드'),
          BottomNavigationBarItem(icon: Icon(Icons.square), label: '내정보'),
        ],
      ),
    );
  }
}
