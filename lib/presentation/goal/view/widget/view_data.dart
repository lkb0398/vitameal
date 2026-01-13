import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal/view_model/goal_datas_view_model.dart';
import 'package:vitameal/presentation/ui_provider/goals_provider.dart';
import 'package:vitameal/presentation/widget/dialog/delete_dialog.dart';

class ViewData extends HookConsumerWidget {
  const ViewData({super.key, required this.isDone, required this.selectedGoal});

  final GoalsEntity selectedGoal;
  final bool isDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 선택된 목표의 데이터 불러오기
    final datasAsync = ref.watch(getGoalDatasProvider(selectedGoal.goalId!));

    // 정렬 (false = 최신순, true = 오래된순)
    final isReversed = useState(false);

    // 삭제 선택값들
    final selectedDataIds = useState<Set<String>>({});
    final hasSelected = selectedDataIds.value.isNotEmpty;

    // 소수점 0 일 때 제거
    String formatNumber(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: fxc(context).textcolor200!),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 정렬 dropdown
              DropdownButton2<bool>(
                underline: SizedBox(),
                value: isReversed.value,
                items: [
                  DropdownMenuItem<bool>(
                    value: false,
                    child: Text('최신순', style: TextStyle(fontSize: 12)),
                  ),
                  DropdownMenuItem<bool>(
                    enabled: false,
                    child: Divider(
                      height: 1,
                      thickness: 0.5,
                      color: fxc(context).textcolor300,
                    ),
                  ),
                  DropdownMenuItem<bool>(
                    value: true,
                    child: Text('오래된순', style: TextStyle(fontSize: 12)),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  isReversed.value = value;
                },
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.only(right: 10),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: fxc(context).textcolor300,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  direction: DropdownDirection.textDirection,
                  decoration: BoxDecoration(
                    color: vrc(context).background,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [40, 8, 40],
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),

              /// 삭제 버튼
              TapDebouncer(
                onTap: hasSelected
                    ? () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteDialog(
                              onDelete: () async {
                                // 데이터 삭제
                                await ref
                                    .read(goalDatasViewModelProvider.notifier)
                                    .deleteDatas(
                                      selectedDataIds.value.toList(),
                                    );
                                // mounted 체크
                                if (!context.mounted) return;
                                Navigator.pop(context);
                                // 선택 초기화
                                selectedDataIds.value = {};
                                // UI 반영
                                ref.invalidate(getGoalDatasProvider);
                              },
                            );
                          },
                        );
                      }
                    : null,
                builder: (BuildContext context, TapDebouncerFunc? onTap) {
                  return TextButton(
                    onPressed: onTap,
                    child: Text(
                      "삭제",
                      style: TextStyle(
                        fontSize: 12,
                        color: hasSelected
                            ? fxc(context).secondary400
                            : fxc(context).textcolor300,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        datasAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('에러 발생: $e')),
          data: (datas) {
            // 데이터 없을 때 화면
            if (datas == null || datas.isEmpty) {
              return SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    "데이터를 추가해주세요.",
                    style: TextStyle(color: fxc(context).textcolor300),
                  ),
                ),
              );
            }
            final displayDatas = isReversed.value
                ? datas.reversed.toList()
                : datas;

            /// 데이터 리스트
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AbsorbPointer(
                absorbing: isDone ? true : false, // true 면 터치 차단
                child: Container(
                  decoration: BoxDecoration(
                    color: isDone ? fxc(context).textcolor100 : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: displayDatas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = displayDatas[index];
                        final isSelected = selectedDataIds.value.contains(
                          data.dataId,
                        );

                        return Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: fxc(context).textcolor300!,
                              ),
                            ),
                          ),
                          height: 58,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  '${data.dataDate.year}.${data.dataDate.month.toString().padLeft(2, '0')}.${data.dataDate.day.toString().padLeft(2, '0')}\n${data.dataDate.hour.toString().padLeft(2, '0')}:${data.dataDate.minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: fxc(context).textcolor400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${formatNumber(data.dataValue)} ${selectedGoal.goalUnit}",
                                  style: TextStyle(
                                    color: fxc(context).textcolor400,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isSelected
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: isSelected
                                      ? fxc(context).secondary400
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  final newSet = {...selectedDataIds.value};
                                  if (isSelected) {
                                    newSet.remove(data.dataId);
                                  } else {
                                    newSet.add(data.dataId!);
                                  }
                                  selectedDataIds.value = newSet;
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
