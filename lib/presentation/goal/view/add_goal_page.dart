import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/goal/view_model/goal_view_model.dart';
import 'package:vitameal/presentation/goal/view/entity.dart';
import 'package:vitameal/presentation/widget/bordered_container.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class AddGoalPage extends HookConsumerWidget {
  const AddGoalPage({super.key, this.goal});

  final GoalsEntity? goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 사용자 입력값 받기
    final goalTitleController = useTextEditingController();
    final goalUnitController = useTextEditingController();
    final goalValueController = useTextEditingController();
    final goalDateController = useTextEditingController();
    final dataDateController = useTextEditingController();
    final dataFigureController = useTextEditingController();

    String? validateExample(String? value) {
      if (value == null || value.trim().isEmpty) {
        return '값을 입력해주세요.'; // 입력값 없을 때
      }
      return null; // 통과
    }

    // 날짜 선택
    Future<DateTime?> pickDate(BuildContext context) async {
      final goalDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (goalDate == null) return null;
      return DateTime(goalDate.year, goalDate.month, goalDate.day);
    }

    DateTime? selectedGoalDate;

    // 날짜+시간 선택
    Future<DateTime?> pickDateTime(BuildContext context) async {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (date == null) return null;
      if (!context.mounted) return null;
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time == null) return null;
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }

    return Scaffold(
      appBar: AppBar(title: Text("건강 목표")),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            /// 달성 완료 표시
            goal == null || goal!.isDone == false
                ? SizedBox.shrink()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text("🎉 이미 목표를 달성했어요!")),
                  ),

            /// 나의 건강 목표
            BorderedContainer(
              title: "나의 건강 목표",
              action: TextButton(
                onPressed: () {
                  // 목표 추가
                  ref
                      .read(goalViewModelProvider.notifier)
                      .saveGoal(
                        goalTitle: goalTitleController.text,
                        goalUnit: goalUnitController.text,
                        goalValue: double.tryParse(goalValueController.text)!,
                        goalDate: selectedGoalDate!,
                        isDone: false,
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('저장이 완료되었습니다'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Text("저장"),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  ValidateTextformfield(
                    readOnly: false,
                    title: "목표명",
                    hintText: "ex. 요산",
                    validator: validateExample,
                    controller: goalTitleController,
                  ),
                  ValidateTextformfield(
                    readOnly: false,
                    title: "단위",
                    hintText: "ex. mg/dL",
                    validator: validateExample,
                    controller: goalUnitController,
                  ),
                  ValidateTextformfield(
                    readOnly: false,
                    title: "목표 수치",
                    hintText: "ex. 2.46",
                    validator: validateExample,
                    controller: goalValueController,
                  ),
                  ValidateTextformfield(
                    readOnly: true,
                    title: "목표 기간",
                    hintText: "ex. 2025.01.23",
                    validator: validateExample,
                    controller: goalDateController,
                    onTap: () async {
                      final date = await pickDate(context);
                      if (date == null) return;

                      selectedGoalDate = DateTime(
                        date.year,
                        date.month,
                        date.day,
                      );

                      goalDateController.text =
                          '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
                    },
                  ),
                ],
              ),
            ),

            /// 데이터 추가
            BorderedContainer(
              title: "데이터 추가",
              action: Text("추가", style: TextStyle(color: Colors.grey)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  ValidateTextformfield(
                    readOnly: true,
                    title: "일자",
                    hintText: "ex. 2025-12-22 14:20",
                    validator: validateExample,
                    controller: dataDateController,
                    onTap: () async {
                      final selectedDateTime = await pickDateTime(context);
                      if (selectedDateTime != null) {
                        dataDateController.text =
                            '${selectedDateTime.year}.${selectedDateTime.month.toString().padLeft(2, '0')}.${selectedDateTime.day.toString().padLeft(2, '0')} ${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}';
                      }
                    },
                  ),
                  ValidateTextformfield(
                    readOnly: false,
                    title: "수치",
                    hintText: "ex. 5.0",
                    validator: validateExample,
                    controller: dataFigureController,
                  ),
                ],
              ),
            ),

            /// 나의 데이터
            BorderedContainer(
              title: "나의 데이터",
              subtitle: goal == null ? "" : goal!.goalTitle,
              action: Text("삭제", style: TextStyle(color: Colors.red)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Divider(height: 0, thickness: 1),
                  goal == null || goal!.datas == null
                      ? SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Center(child: Text("데이터 없음")),
                        )
                      : ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: goal!.datas!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = goal!.datas![index];

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${DateTime.now().day}\n${DateTime.now().hour}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${data.dataValue} ${goal!.goalUnit}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.circle_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
