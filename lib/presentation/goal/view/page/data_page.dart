import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/util/show_gray_snackbar.dart';
import 'package:vitameal/presentation/goal/view/widget/add_data_bottom_sheet.dart';
import 'package:vitameal/presentation/goal/view/widget/view_data.dart';
import 'package:vitameal/presentation/ui_provider/goals_provider.dart';

class DataPage extends HookConsumerWidget {
  const DataPage({super.key, required this.goalId});

  final String goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    // 전체 목표 불러오기
    final goalsAsync = ref.watch(getAllGoalsProvider);

    // 선택된 목표 불러오기
    final selectedGoalId = useState<String>(goalId);
    final selectedGoal = ref.watch(getGoalProvider(selectedGoalId.value));

    // 달성된 목표 여부
    final isDone = selectedGoal!.isDone == true;

    // 소수점 0 일 때 제거
    String formatNumber(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.recent_data)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                spacing: 10,
                children: [
                  /// 목표 항목 선택 dropdown
                  DropdownButton2<String>(
                    isDense: true,
                    underline: SizedBox(),
                    isExpanded: true,
                    value: selectedGoal.goalId,
                    items: goalsAsync.when(
                      loading: () => [],
                      error: (_, __) => [],
                      data: (goals) {
                        if (goals == null || goals.isEmpty) return [];
                        final items = <DropdownMenuItem<String>>[];
                        for (int i = 0; i < goals.length; i++) {
                          final goal = goals[i];
                          // 실제 메뉴 아이템
                          items.add(
                            DropdownMenuItem<String>(
                              value: goal.goalId,
                              child: Text(
                                goal.goalTitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: vrc(context).text,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                          // 마지막 아이템이 아니면 Divider 추가
                          if (i != goals.length - 1) {
                            items.add(
                              DropdownMenuItem<String>(
                                enabled: false,
                                child: Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: fxc(context).textcolor300,
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
                      selectedGoalId.value = value;
                    },
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: fxc(context).textcolor300,
                      ),
                    ),
                    buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.only(right: 10),
                      height: 48,
                      decoration: BoxDecoration(
                        color: vrc(context).greyBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: vrc(context).dropdown,
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
                          if (i != goalsAsync.value!.length - 1)
                            8, // Divider 높이
                        ],
                      ],
                    ),
                  ),

                  /// 목표 정보
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isDone
                          ? fxc(context).textcolor200
                          : fxc(context).secondary50,
                    ),
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            selectedGoal.goalTitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: fxc(context).textcolor700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        VerticalDivider(
                          color: isDone
                              ? fxc(context).textcolor300
                              : fxc(context).secondary200,
                        ),
                        Expanded(
                          child: Text(
                            '${formatNumber(selectedGoal.goalValue)} ${selectedGoal.goalUnit}',
                            style: TextStyle(
                              fontSize: 12,
                              color: fxc(context).textcolor700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        VerticalDivider(
                          color: isDone
                              ? fxc(context).textcolor300
                              : fxc(context).secondary200,
                        ),
                        Expanded(
                          child: Text(
                            '${selectedGoal.goalDate.year}.${selectedGoal.goalDate.month.toString().padLeft(2, '0')}.${selectedGoal.goalDate.day.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: fxc(context).textcolor700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 달성한 목표 표시
                  isDone
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "🥳 ${l.goal_already_done}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: fxc(context).secondary400,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            ViewData(selectedGoal: selectedGoal, isDone: isDone), // 데이터 리스트 영역
          ],
        ),
      ),

      /// 데이터 추가 버튼
      floatingActionButton: RawMaterialButton(
        onPressed: () async {
          // 1. 완료된 목표 > 스낵바 + 버튼 비활성화
          if (isDone) {
            showGraySnackBar(context, l.goal_already_achieved);
            return;
            // 2. 데이터 추가 bottomsheet
          } else {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return AddDataBottomSheet(goalId: selectedGoal.goalId!);
              },
            );
          }
        },

        fillColor: fxc(context).secondary400,
        shape: const CircleBorder(),
        constraints: const BoxConstraints(minWidth: 60, minHeight: 60),
        elevation: 0,
        child: Icon(PhosphorIcons.plus(), size: 32, color: Colors.white),
      ),
    );
  }
}
