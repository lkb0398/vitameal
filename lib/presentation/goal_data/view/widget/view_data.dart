import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal_data/view_model/goal_data_page_view_model.dart';
import 'package:vitameal/presentation/goal_data/view_model/goal_datas_view_model.dart';
import 'package:vitameal/presentation/ui_provider/formatted_date_provider.dart';
import 'package:vitameal/presentation/util/date_time_utils.dart';
import 'package:vitameal/presentation/util/remove_decimals.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';

class ViewData extends ConsumerWidget {
  const ViewData({super.key, required this.goal, required this.isDone});

  final GoalsEntity goal;
  final bool isDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    final state = ref.watch(goalDataPageViewModelProvider(selectedGoal: goal));
    final vm = ref.read(
      goalDataPageViewModelProvider(selectedGoal: goal).notifier,
    );

    // 선택된 목표의 데이터 전체 목록
    final datasAsync = ref.watch(
      goalDatasViewModelProvider(goalId: state.selectedGoal.goalId!),
    );
    final dataVM = ref.read(
      goalDatasViewModelProvider(goalId: state.selectedGoal.goalId!).notifier,
    );

    // 삭제 선택값이 있는지 여부
    final bool hasSelected = state.selectedDataIds.isNotEmpty;

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
                value: state.isReversed,
                items: [
                  DropdownMenuItem<bool>(
                    value: false,
                    child: Text(l.latest, style: TextStyle(fontSize: 12)),
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
                    child: Text(l.oldest, style: TextStyle(fontSize: 12)),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  vm.updateReversed(value);
                },
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.only(right: 10),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: f.textcolor300,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  direction: DropdownDirection.textDirection,
                  decoration: BoxDecoration(
                    color: v.background,
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
                            return CustomDialog(
                              title: l.confirm_delete,
                              confirmText: l.delete,
                              cancelText: l.cancel,
                              onConfirm: () async {
                                // [데이터 삭제]
                                await dataVM.deleteDatas(
                                  state.selectedDataIds.toList(),
                                );

                                if (!context.mounted) return;
                                Navigator.pop(context);

                                // 선택 초기화
                                vm.updateIds({});
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
                      l.delete,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: hasSelected ? f.secondary400 : f.textcolor300,
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
          error: (_, _) => const SizedBox.shrink(),
          data: (datas) {
            // 데이터 없을 때 화면
            if (datas == null || datas.isEmpty) {
              return SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    l.add_data_hint,
                    style: TextStyle(color: f.textcolor300),
                  ),
                ),
              );
            }
            final displayDatas = state.isReversed
                ? datas.reversed.toList()
                : datas;

            /// 데이터 리스트
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AbsorbPointer(
                absorbing: isDone ? true : false, // true 면 터치 차단
                child: Container(
                  decoration: BoxDecoration(
                    color: isDone ? f.textcolor100 : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: displayDatas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = displayDatas[index];
                        final isSelected = state.selectedDataIds.contains(
                          data.dataId,
                        );

                        /// 데이터 정보
                        return Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: f.textcolor200!),
                            ),
                          ),
                          height: 58,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  '${ref.watch(formattedDateProvider(data.dataDate))}\n${data.dataDate.timeLabel}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDone
                                        ? f.textcolor300
                                        : f.textcolor400,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${removeDecimals(data.dataValue)} ${goal.goalUnit}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isDone ? f.textcolor300 : v.text,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),

                              /// 삭제 선택 버튼
                              IconButton(
                                icon: Icon(
                                  isSelected
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: isSelected
                                      ? f.secondary400
                                      : isDone
                                      ? f.textcolor300
                                      : f.textcolor200,
                                ),
                                onPressed: () {
                                  final newSet = {...state.selectedDataIds};
                                  if (isSelected) {
                                    newSet.remove(data.dataId);
                                  } else {
                                    newSet.add(data.dataId!);
                                  }
                                  vm.updateIds(newSet);
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
