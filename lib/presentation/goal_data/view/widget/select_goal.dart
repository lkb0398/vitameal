import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal/view_model/goals_view_model.dart';
import 'package:vitameal/presentation/goal_data/view_model/goal_data_page_view_model.dart';
import 'package:vitameal/presentation/ui_provider/formatted_date_provider.dart';
import 'package:vitameal/presentation/util/remove_decimals.dart';

class SelectGoal extends HookConsumerWidget {
  const SelectGoal({super.key, required this.goal});

  final GoalsEntity goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    // 목표 전체 목록
    final goalsAsync = ref.watch(goalsViewModelProvider);

    final state = ref.watch(goalDataPageViewModelProvider(selectedGoal: goal));
    final vm = ref.read(
      goalDataPageViewModelProvider(selectedGoal: goal).notifier,
    );

    // 목표 완료 여부
    final bool isDone = state.selectedGoal.isDone;

    return Column(
      spacing: 10,
      children: [
        DropdownButton2<GoalsEntity>(
          isDense: true,
          underline: const SizedBox(),
          isExpanded: true,
          value: state.selectedGoal,
          items: goalsAsync.when(
            loading: () => [],
            error: (_, __) => [],
            data: (goals) {
              if (goals == null || goals.isEmpty) return [];
              final items = <DropdownMenuItem<GoalsEntity>>[];
              for (int i = 0; i < goals.length; i++) {
                final goal = goals[i];
                // 메뉴 아이템
                items.add(
                  DropdownMenuItem<GoalsEntity>(
                    value: goal,
                    child: Text(
                      goal.goalTitle,
                      style: TextStyle(fontSize: 14, color: v.text),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
                // 마지막 아이템이 아니면 Divider 추가
                if (i != goals.length - 1) {
                  items.add(
                    DropdownMenuItem<GoalsEntity>(
                      enabled: false,
                      child: Divider(
                        height: 1,
                        thickness: 0.5,
                        color: f.textcolor300,
                      ),
                    ),
                  );
                }
              }
              return items;
            },
          ),
          onChanged: (value) {
            if (value == null) return;
            vm.updateGoal(value);
          },
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down, color: f.textcolor300),
          ),
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.only(right: 10),
            height: 48,
            decoration: BoxDecoration(
              color: v.greyBackground,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: v.dropdown,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            customHeights: [
              for (int i = 0; i < goalsAsync.value!.length; i++) ...[
                40, // 메뉴 아이템 높이
                if (i != goalsAsync.value!.length - 1) 8, // Divider 높이
              ],
            ],
          ),
        ),

        /// 목표 정보
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isDone ? f.textcolor200 : f.secondary50,
          ),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  state.selectedGoal.goalTitle,
                  style: TextStyle(fontSize: 12, color: f.textcolor700),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalDivider(color: isDone ? f.textcolor300 : f.secondary200),
              Expanded(
                child: Text(
                  '${removeDecimals(state.selectedGoal.goalValue)} ${state.selectedGoal.goalUnit}',
                  style: TextStyle(fontSize: 12, color: f.textcolor700),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalDivider(color: isDone ? f.textcolor300 : f.secondary200),
              Expanded(
                child: Text(
                  ref.watch(formattedDateProvider(state.selectedGoal.goalDate)),
                  style: TextStyle(fontSize: 12, color: f.textcolor700),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        /// 달성한 목표 표시
        if (isDone)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "🥳 ${l.goal_already_done}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: f.secondary400,
              ),
            ),
          ),
      ],
    );
  }
}
