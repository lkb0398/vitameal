import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/presentation/goal/view/widget/view_add_data.dart';
import 'package:vitameal/presentation/goal/view/widget/view_my_data.dart';
import 'package:vitameal/presentation/goal/view/widget/view_my_goal.dart';
import 'package:vitameal/presentation/goal/view_model/user_goals_view_model.dart';
import 'package:vitameal/presentation/ui_provider/goal_provider.dart';

class AddGoalPage extends HookConsumerWidget {
  const AddGoalPage({super.key, this.goalId});

  final String? goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goal = goalId == null
        ? null // goal == null > 추가 화면
        : ref.watch(getGoalProvider(goalId!)); // goal != null > 수정 화면

    // 달성된 목표 여부
    final isDone = goal?.isDone == true;

    return Scaffold(
      appBar: AppBar(
        title: Text("건강 목표"),

        /// 삭제 버튼
        actions: [
          goal != null
              ? TapDebouncer(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('정말 삭제할까요?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('취소'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // 목표 삭제
                                await ref
                                    .read(userGoalsViewModelProvider.notifier)
                                    .deleteGoal(goalId!);

                                // mounted 체크
                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('삭제되었습니다'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );

                                Navigator.pop(context);
                                context.pop();

                                // UI 반영
                                ref.invalidate(getAllGoalsProvider);
                              },
                              child: Text('확인'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  builder: (BuildContext context, TapDebouncerFunc? onTap) {
                    return TextButton(
                      onPressed: onTap,
                      child: Text("삭제", style: TextStyle(color: Colors.red)),
                    );
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            /// 달성 완료 표시
            goal != null && isDone == true
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.redAccent, width: 2),
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.redAccent),
                        Text(
                          " 이미 달성한 목표입니다!",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            _readonlyWrapper(
              isReadonly: isDone,
              child: ViewMyGoal(goalId: goalId), // 내 건강 목표
            ),
            goal != null
                ? Column(
                    spacing: 20,
                    children: [
                      _readonlyWrapper(
                        isReadonly: isDone,
                        child: ViewAddData(goalId: goalId!), // 데이터 추가
                      ),
                      _readonlyWrapper(
                        isReadonly: isDone,
                        child: ViewMyData(goalId: goalId!), // 나의 데이터
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

Widget _readonlyWrapper({required bool isReadonly, required Widget child}) {
  return AbsorbPointer(
    absorbing: isReadonly, // true 면 터치 차단
    child: Container(
      decoration: BoxDecoration(
        color: isReadonly ? Colors.grey[200] : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    ),
  );
}
