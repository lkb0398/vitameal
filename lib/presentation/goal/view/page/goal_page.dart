import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/goal/view_model/goals_view_model.dart';
import 'package:vitameal/presentation/ui_provider/goals_provider.dart';
import 'package:vitameal/presentation/widget/button/add_button.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';

class GoalPage extends HookConsumerWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    final goalsAsync = ref.watch(getAllGoalsProvider);

    // 소수점 0 일 때 제거
    String formatNumber(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.health_goals)),
      body: Column(
        children: [
          /// 제목 행
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: fxc(context).textcolor200!),
              ),
            ),
            height: 40,
            child: Row(
              children: [
                SizedBox(width: 100, child: Center(child: Text(l.goal_title))),
                Expanded(child: Center(child: Text(l.goal_value))),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      l.set_representative,
                      style: TextStyle(color: fxc(context).secondary400),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 목표 리스트
          Expanded(
            child: goalsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('error: $e')),
              data: (goals) {
                final list = goals ?? [];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: ListView.builder(
                    itemCount: list.length + 1,
                    itemBuilder: (context, index) {
                      if (index == list.length) {
                        return Column(
                          spacing: 30,
                          children: [
                            // 목표 없을 때 화면
                            list.isEmpty
                                ? Column(
                                    spacing: 20,
                                    children: [
                                      SizedBox(height: 60),
                                      Icon(
                                        PhosphorIcons.firstAidKit(),
                                        size: 120,
                                        color: vrc(context).emptyText,
                                      ),
                                      Text(
                                        "${l.no_goals} :(",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: vrc(context).emptyText,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            /// 목표 추가 버튼
                            AddButton(
                              onTap: () => context.push('/add/goal'),
                              borderColor: fxc(context).secondary400!,
                              text: l.add_goal,
                              textColor: fxc(context).secondary400!,
                            ),
                          ],
                        );
                      }
                      final goal = list[index];

                      /// 스와이프
                      return Slidable(
                        key: ValueKey(goal.goalId),
                        endActionPane: ActionPane(
                          motion: DrawerMotion(),
                          extentRatio: 0.16,
                          children: [
                            goal.isDone
                                ?
                                  // 달성된 목표 > 삭제
                                  CustomSlidableAction(
                                    onPressed: (context) async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomDialog(
                                            title: l.confirm_delete,
                                            confirmText: l.delete,
                                            cancelText: l.cancel,
                                            onConfirm: () async {
                                              // 목표 삭제
                                              await ref
                                                  .read(
                                                    goalsViewModelProvider
                                                        .notifier,
                                                  )
                                                  .deleteGoal(goal.goalId!);
                                              // mounted 체크
                                              if (!context.mounted) return;
                                              Navigator.pop(context);
                                              // UI 반영
                                              ref.invalidate(
                                                getAllGoalsProvider,
                                              );
                                              // 📝
                                              AnalyticsService.event(
                                                'goal_action',
                                                p: {'action': 'delete'},
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    backgroundColor: fxc(context).secondary400!,
                                    child: Icon(
                                      PhosphorIcons.x(),
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                // 달성 안된 목표 > 수정 페이지 이동 + goalId 전달
                                : CustomSlidableAction(
                                    onPressed: (context) => context.push(
                                      '/edit/goal',
                                      extra: goal.goalId,
                                    ),
                                    backgroundColor: fxc(context).yellowSlider!,
                                    child: Icon(
                                      PhosphorIcons.pencilSimple(),
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        ),
                        child: InkWell(
                          // 길게 탭 > 대표설정 변경
                          onLongPress: () {
                            if (goal.isDone) return;
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  onConfirm: () async {
                                    // 목표 업데이트
                                    await ref
                                        .read(goalsViewModelProvider.notifier)
                                        .updateGoal(
                                          goalId: goal.goalId!,
                                          goalTitle: goal.goalTitle,
                                          goalUnit: goal.goalUnit,
                                          goalValue: goal.goalValue,
                                          goalDate: goal.goalDate,
                                          isDone: goal.isDone,
                                          isMain: !goal.isMain,
                                        );
                                    // mounted 체크
                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                    // UI 반영
                                    ref.invalidate(getAllGoalsProvider);
                                  },
                                  title: l.set_as_representative,
                                  confirmText: l.confirm,
                                  cancelText: l.cancel,
                                );
                              },
                            );
                          },
                          // 탭 > 데이터 페이지 이동 + goalId 전달
                          onTap: () =>
                              context.push('/data', extra: goal.goalId),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: fxc(context).textcolor300!,
                                ),
                              ),
                              color: goal.isDone
                                  ? fxc(context).textcolor200!
                                  : null,
                            ),
                            height: 50,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      goal.goalTitle,
                                      style: TextStyle(
                                        color: goal.isDone
                                            ? fxc(context).textcolor400!
                                            : vrc(context).text,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '${formatNumber(goal.goalValue)} ${goal.goalUnit}',
                                      style: TextStyle(
                                        color: goal.isDone
                                            ? fxc(context).textcolor400!
                                            : vrc(context).text,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: goal.isDone
                                      ? Center(
                                          child: Text(
                                            '-',
                                            style: TextStyle(
                                              color: goal.isDone
                                                  ? fxc(context).textcolor400!
                                                  : vrc(context).text,
                                            ),
                                          ),
                                        )
                                      : goal.isMain
                                      ? Icon(
                                          Icons.check,
                                          color: fxc(context).secondary400,
                                        )
                                      : SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
