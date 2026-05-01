import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/goal/view/widget/goal_item.dart';
import 'package:vitameal/presentation/goal/view_model/goals_view_model.dart';
import 'package:vitameal/presentation/widget/button/add_button.dart';

class ViewGoal extends ConsumerWidget {
  const ViewGoal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    // 목표 전체 목록
    final goalsAsync = ref.watch(goalsViewModelProvider);

    return goalsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => const SizedBox.shrink(),
      data: (goals) {
        final list = goals ?? [];
        return ListView.builder(
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            if (index == list.length) {
              return Column(
                children: [
                  // 목표 없을 때
                  if (list.isEmpty)
                    SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          Icon(
                            PhosphorIcons.firstAidKit(),
                            size: 120,
                            color: v.emptyText,
                          ),
                          Text(
                            "${l.no_goals} :(",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: v.emptyText,
                            ),
                          ),
                        ],
                      ),
                    ),

                  /// 목표 추가 버튼
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: AddButton(
                      onTap: () => context.push(AppRoutePath.addGoal),
                      borderColor: f.secondary400!,
                      text: l.add_goal,
                      textColor: f.secondary400!,
                    ),
                  ),
                ],
              );
            }
            final goal = list[index];
            return GoalItem(goal: goal);
          },
        );
      },
    );
  }
}
