import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/info/view/widget/graph.dart';
import 'package:vitameal/presentation/info/view/widget/guage.dart';
import 'package:vitameal/presentation/widget/bordered_container.dart';

class ViewGoal extends HookConsumerWidget {
  const ViewGoal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 20,
      children: [
        /// 건강 목표
        BorderedContainer(
          title: "건강 목표",
          subtitle: "요산 2025.01.23",
          action: IconButton(
            onPressed: () => context.push('/goal'),
            icon: Icon(Icons.arrow_forward_ios),
          ),
          child: Guage(startValue: 8.00, currentValue: 3.0, targetValue: 2.46),
        ),

        /// 최근 그래프
        BorderedContainer(
          title: "최근 그래프",
          subtitle: "요산 mg/dL",
          action: IconButton(
            onPressed: () => context.push('/goal'),
            icon: Icon(Icons.arrow_forward_ios),
          ),
          child: SizedBox(
            height: 220,
            child: Graph(recentDatas: [5, 30, 12, 60, 100]),
          ),
        ),
      ],
    );
  }
}
