import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal/view_model/goals_view_model.dart';
import 'package:vitameal/presentation/util/remove_decimals.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';

class GoalItem extends ConsumerWidget {
  const GoalItem({super.key, required this.goal});

  final GoalsEntity goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    final goalVM = ref.read(goalsViewModelProvider.notifier);

    return Slidable(
      key: ValueKey(goal.goalId),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.16,
        children: [
          goal.isDone
              // 1. 달성된 목표 > 삭제 슬라이드
              ? CustomSlidableAction(
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          title: l.confirm_delete,
                          confirmText: l.delete,
                          cancelText: l.cancel,
                          onConfirm: () async {
                            // [목표 삭제]
                            await goalVM.deleteGoal(id: goal.goalId!);

                            if (!context.mounted) return;
                            Navigator.pop(context);
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
                  backgroundColor: f.secondary400!,
                  child: Icon(PhosphorIcons.x(), size: 30, color: Colors.white),
                )
              // 2. 달성 안된 목표 > 수정 슬라이드
              : CustomSlidableAction(
                  onPressed: (context) {
                    // 수정 페이지 이동 + goal 전달
                    context.push(AppRoutePath.editGoal, extra: goal);
                  },
                  backgroundColor: f.yellowSlider!,
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
                  // [대표설정 여부 변경]
                  await goalVM.switchMain(id: goal.goalId, v: !goal.isMain);

                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                title: l.set_as_representative,
                confirmText: l.confirm,
                cancelText: l.cancel,
              );
            },
          );
        },
        // 탭 > 데이터 페이지 이동 + goal 전달
        onTap: () => context.push(AppRoutePath.data, extra: goal),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: f.textcolor300!)),
            color: goal.isDone ? f.textcolor200! : null,
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
                      fontSize: 12,
                      color: goal.isDone ? f.textcolor400! : v.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '${removeDecimals(goal.goalValue)} ${goal.goalUnit}',
                    style: TextStyle(
                      fontSize: 12,
                      color: goal.isDone ? f.textcolor400! : v.text,
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
                            color: goal.isDone ? f.textcolor400! : v.text,
                          ),
                        ),
                      )
                    : goal.isMain
                    ? Icon(Icons.check, color: f.secondary400)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
