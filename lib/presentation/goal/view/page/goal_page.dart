import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/goal/view_model/user_goals_view_model.dart';
import 'package:vitameal/presentation/ui_provider/goal_provider.dart';

class GoalPage extends HookConsumerWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(getAllGoalsProvider);

    String formatNumber(double value) {
      if (value % 1 == 0) {
        return value.toInt().toString(); // 소수점 없음
      }
      return value.toString(); // 소수점 있음
    }

    return Scaffold(
      appBar: AppBar(title: Text("건강 목표")),
      body: goalsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러 발생: $e')),
        data: (goals) {
          // 목표 없을 때 화면
          if (goals == null || goals.isEmpty) {
            return const Center(child: Text('목표가 없습니다'));
          }
          return Column(
            children: [
              /// 제목 행
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                height: 40,
                child: Row(
                  children: [
                    SizedBox(width: 100, child: Center(child: Text("목표명"))),
                    Expanded(child: Center(child: Text("목표 수치값"))),
                    SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          "대표설정",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];

                    return InkWell(
                      // 길게 탭 > 대표설정 변경
                      onLongPress: () {
                        if (goal.isDone) return;

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('대표로 설정할까요?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('취소'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // 목표 업데이트
                                    await ref
                                        .read(
                                          userGoalsViewModelProvider.notifier,
                                        )
                                        .updateMainGoal(goal.goalId!);

                                    // mounted 체크
                                    if (!context.mounted) return;

                                    Navigator.pop(context);

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
                      // 탭 > 페이지 이동 + goalId 전달
                      onTap: () =>
                          context.push('/edit/goal', extra: goal.goalId),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                          color: goal.isDone ? Colors.grey : null,
                        ),
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Center(child: Text(goal.goalTitle)),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${formatNumber(goal.goalValue)} ${goal.goalUnit}',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: goal.isDone
                                  ? Icon(Icons.remove)
                                  : goal.isMain
                                  ? Icon(Icons.check, color: Colors.red)
                                  : SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      /// 목표 추가 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add/goal');
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
