import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/presentation/goal/view_model/goal_datas_view_model.dart';
import 'package:vitameal/presentation/ui_provider/goals_provider.dart';
import 'package:vitameal/presentation/widget/bordered_container.dart';

class ViewMyData extends HookConsumerWidget {
  const ViewMyData({super.key, required this.goalId});

  final String goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 목표+데이터 불러오기
    final goal = ref.watch(getGoalProvider(goalId));
    final datasAsync = ref.watch(getGoalDatasProvider(goalId));

    // 삭제 선택값들
    final selectedDataIds = useState<Set<String>>({});

    String formatNumber(double value) {
      if (value % 1 == 0) {
        return value.toInt().toString(); // 소수점 없음
      }
      return value.toString(); // 소수점 있음
    }

    return BorderedContainer(
      title: "나의 데이터",
      subtitle: goal == null ? "" : goal.goalTitle,

      /// 삭제 버튼
      action: datasAsync.when(
        loading: () => SizedBox.shrink(),
        error: (e, _) => SizedBox.shrink(),
        data: (datas) {
          if (datas == null || datas.isEmpty) {
            return null;
          }

          final hasSelected = selectedDataIds.value.isNotEmpty;

          return TapDebouncer(
            onTap: hasSelected
                ? () async {
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
                              child: Text('확인'),
                            ),
                          ],
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
                    color: hasSelected ? Colors.red : Colors.grey,
                  ),
                ),
              );
            },
          );
        },
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Divider(height: 0, thickness: 1),

          datasAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('에러 발생: $e')),
            data: (datas) {
              // 데이터 없을 때 화면
              if (datas == null || datas.isEmpty) {
                return SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(child: Text("데이터 없음")),
                );
              }
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: datas.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = datas[index];
                  final isSelected = selectedDataIds.value.contains(
                    data.dataId,
                  );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.dataDate.year}.${data.dataDate.month.toString().padLeft(2, '0')}.${data.dataDate.day.toString().padLeft(2, '0')}\n${data.dataDate.hour.toString().padLeft(2, '0')}:${data.dataDate.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Text(
                            "${formatNumber(data.dataValue)} ${goal!.goalUnit}",
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: isSelected ? Colors.red : Colors.grey,
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
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
