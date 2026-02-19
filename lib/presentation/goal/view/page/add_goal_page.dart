import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal/view_model/goals_view_model.dart';
import 'package:vitameal/presentation/ui_provider/goals_provider.dart';
import 'package:vitameal/presentation/goal/view/function/pick_date.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class AddGoalPage extends HookConsumerWidget {
  const AddGoalPage({super.key, this.goalId});

  final String? goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    final goal = goalId == null
        ? null // goal == null > 추가 화면
        : ref.watch(getGoalProvider(goalId!)); // goal != null > 수정 화면

    // 날짜 선택
    final selectedGoalDate = useState<DateTime?>(null);

    // 사용자 입력값 받기 + 입력값 검증 메시지
    final goalTitleController = useTextEditingController();
    final goalUnitController = useTextEditingController();
    final goalValueController = useTextEditingController();
    final goalDateController = useTextEditingController();
    String? validateDouble(String? value) {
      if (value == null || value.isEmpty) {
        return l.enter_value; // 입력값 없을 때
      }
      final height = double.tryParse(value);
      if (height == null) {
        return l.invalid_number; // 숫자가 아닐 때
      }
      return null; // 통과
    }

    // 수정 화면에서 기존값 불러오기
    final didInit = useRef(false);
    final savedGoalRef = useRef<GoalsEntity?>(null);
    useEffect(() {
      if (goal == null) return null;
      if (didInit.value) return null;
      didInit.value = true;
      goalTitleController.text = goal.goalTitle;
      goalUnitController.text = goal.goalUnit;
      goalValueController.text = goal.goalValue.toString();
      selectedGoalDate.value = goal.goalDate;
      goalDateController.text =
          '${goal.goalDate.year}.${goal.goalDate.month.toString().padLeft(2, '0')}.${goal.goalDate.day.toString().padLeft(2, '0')}';
      savedGoalRef.value = goal;
      return null;
    }, [goal]);

    // 기존값 변경 여부
    bool isChanged() {
      final saved = savedGoalRef.value;
      if (saved == null) return true;
      return goalTitleController.text.trim() != saved.goalTitle ||
          goalUnitController.text.trim() != saved.goalUnit ||
          double.tryParse(goalValueController.text) != saved.goalValue ||
          selectedGoalDate.value != saved.goalDate;
    }

    // 버튼 활성화 여부
    final isButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        final hasGoalTitle = goalTitleController.text.trim().isNotEmpty;
        final hasGoalUnit = goalUnitController.text.trim().isNotEmpty;
        final hasGoalValue = double.tryParse(goalValueController.text) != null;
        final hasGoalDate = selectedGoalDate.value != null;
        final baseValid =
            hasGoalTitle && hasGoalUnit && hasGoalValue && hasGoalDate;
        if (goal == null) {
          isButtonEnabled.value = baseValid;
        } else {
          isButtonEnabled.value = baseValid && isChanged();
        }
      }

      goalTitleController.addListener(listener);
      goalUnitController.addListener(listener);
      goalValueController.addListener(listener);
      return () {
        goalTitleController.removeListener(listener);
        goalUnitController.removeListener(listener);
        goalValueController.removeListener(listener);
      };
    }, [goal, selectedGoalDate.value]);

    return Scaffold(
      appBar: AppBar(
        title: Text(goal != null ? l.edit_goal : l.new_goal),
        actions: [
          /// 삭제 버튼
          goal != null
              ? TapDebouncer(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          onConfirm: () async {
                            // 목표 삭제
                            await ref
                                .read(goalsViewModelProvider.notifier)
                                .deleteGoal(goalId!);
                            // mounted 체크
                            if (!context.mounted) return;
                            Navigator.pop(context);
                            // 페이지 이동
                            context.pop();
                            // UI 반영
                            ref.invalidate(getAllGoalsProvider);
                            // 📝
                            AnalyticsService.event(
                              'goal_action',
                              p: {'action': 'delete'},
                            );
                          },
                          title: l.confirm_delete,
                          confirmText: l.delete,
                          cancelText: l.cancel,
                        );
                      },
                    );
                  },
                  builder: (BuildContext context, TapDebouncerFunc? onTap) {
                    return TextButton(
                      onPressed: onTap,
                      child: Text(
                        l.delete,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: fxc(context).secondary400,
                        ),
                      ),
                    );
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              ValidateTextformfield(
                label: l.goal_title,
                readOnly: false,
                hintText: "ex. ${l.uric_acid}",
                controller: goalTitleController,
              ),
              ValidateTextformfield(
                label: l.goal_period,
                readOnly: true,
                hintText: "ex. 2000.01.01",
                controller: goalDateController,
                onTap: () async {
                  final date = await pickDate(context);
                  if (date == null) return;
                  selectedGoalDate.value = DateTime(
                    date.year,
                    date.month,
                    date.day,
                  );
                  goalDateController.text =
                      '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
                },
              ),
              ValidateTextformfield(
                label: l.unit,
                readOnly: false,
                hintText: "ex. mg/dL",
                controller: goalUnitController,
              ),
              ValidateTextformfield(
                label: l.goal_amount,
                readOnly: false,
                hintText: "ex. 2.46",
                validator: validateDouble,
                controller: goalValueController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ],
          ),
        ),
      ),

      /// 수정/추가 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: isButtonEnabled.value
            ? () async {
                if (goal != null) {
                  // 1. 목표 수정
                  await ref
                      .read(goalsViewModelProvider.notifier)
                      .updateGoal(
                        goalId: goal.goalId!,
                        goalTitle: goalTitleController.text,
                        goalUnit: goalUnitController.text,
                        goalValue: double.tryParse(goalValueController.text)!,
                        goalDate: selectedGoalDate.value!,
                        isDone: goal.isDone,
                        isMain: goal.isMain,
                      );
                  // 기존값 업데이트
                  savedGoalRef.value = GoalsEntity(
                    goalId: goal.goalId,
                    goalTitle: goalTitleController.text.trim(),
                    goalUnit: goalUnitController.text.trim(),
                    goalValue: double.tryParse(goalValueController.text)!,
                    goalDate: selectedGoalDate.value!,
                    isDone: goal.isDone,
                    isMain: goal.isMain,
                  );
                  // 버튼 비활성화
                  isButtonEnabled.value = false;
                  // mounted 체크
                  if (!context.mounted) return;
                  // 페이지 이동
                  context.pop();
                  // UI 반영
                  ref.invalidate(getAllGoalsProvider);
                } else {
                  // 2. 목표 추가
                  await ref
                      .read(goalsViewModelProvider.notifier)
                      .saveGoal(
                        goalTitle: goalTitleController.text,
                        goalUnit: goalUnitController.text,
                        goalValue: double.tryParse(goalValueController.text)!,
                        goalDate: selectedGoalDate.value!,
                        isDone: false,
                        isMain: false,
                      );
                  // mounted 체크
                  if (!context.mounted) return;
                  // 페이지 이동
                  context.pop();
                  // UI 반영
                  ref.invalidate(getAllGoalsProvider);
                  // 📝
                  AnalyticsService.event(
                    'goal_action',
                    p: {'action': 'create'},
                  );
                }
              }
            : null,
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DoneButton(
              onTap: onTap,
              text: l.complete,
              backgroundColor: isButtonEnabled.value
                  ? fxc(context).secondary400!
                  : fxc(context).textcolor200!,
              textColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
