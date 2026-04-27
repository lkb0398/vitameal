import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal/view_model/goal_page_view_model.dart';
import 'package:vitameal/presentation/goal/view_model/goals_view_model.dart';
import 'package:vitameal/presentation/ui_provider/formatted_date_provider.dart';
import 'package:vitameal/presentation/goal/view/util/pick_date.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class AddGoalPage extends HookConsumerWidget {
  const AddGoalPage({super.key, this.goal});

  final GoalsEntity? goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎

    final goalVM = ref.read(goalsViewModelProvider.notifier);

    final state = ref.watch(goalPageViewModelProvider(goal: goal));
    final vm = ref.read(goalPageViewModelProvider(goal: goal).notifier);

    // 수정모드 분기
    final bool isEditMode = goal != null;

    // (목표 기간) 날짜 입력 받기 위한 controller 및 state 동기화
    final dateController = useTextEditingController();
    useEffect(() {
      dateController.text = state.selectedDate != null
          ? ref.watch(formattedDateProvider(state.selectedDate!))
          : '';
      return null;
    }, [state.selectedDate]);

    // (목표 수치) 입력값 검증 메시지
    String? validateDouble(String? value) {
      if (value == null || value.isEmpty) {
        return l.enter_value; // 입력값 없을 때
      }
      final goalValue = double.tryParse(value);
      if (goalValue == null) {
        return l.invalid_number; // 숫자가 아닐 때
      }
      return null; // 통과
    }

    // 버튼 활성화 여부
    final bool enabled =
        state.title.isNotEmpty &&
        state.selectedDate != null &&
        state.unit.isNotEmpty &&
        validateDouble(state.value) == null;

    return Scaffold(
      /// 앱바
      appBar: AppBar(
        title: Text(isEditMode ? l.edit_goal : l.new_goal),
        actions: [
          /// 삭제 버튼
          if (isEditMode)
            TapDebouncer(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                      title: l.confirm_delete,
                      confirmText: l.delete,
                      cancelText: l.cancel,
                      onConfirm: () async {
                        // [목표 삭제]
                        await goalVM.deleteGoal(id: goal!.goalId!);

                        if (!context.mounted) return;
                        Navigator.pop(context);
                        context.pop();
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
              builder: (BuildContext context, TapDebouncerFunc? onTap) {
                return TextButton(
                  onPressed: onTap,
                  child: Text(
                    l.delete,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: f.secondary400,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              /// 목표명
              ValidateTextformfield(
                label: l.goal_title,
                readOnly: false,
                hintText: "ex. ${l.uric_acid}",
                initialValue: state.title,
                onChanged: (v) => vm.updateTitle(v),
              ),

              /// 목표 기간
              ValidateTextformfield(
                label: l.goal_period,
                readOnly: true,
                hintText:
                    "ex. ${ref.watch(formattedDateProvider(DateTime(2000, 01, 31)))}",
                controller: dateController,
                onTap: () async {
                  final selectedDate = await pickDate(
                    context: context,
                    initialDate: state.selectedDate ?? DateTime.now(),
                  );
                  if (selectedDate == null) return;
                  vm.updateSelectedDate(selectedDate);
                },
              ),

              /// 단위
              ValidateTextformfield(
                label: l.unit,
                readOnly: false,
                hintText: "ex. mg/dL",
                onChanged: (v) => vm.updateUnit(v),
                initialValue: state.unit,
              ),

              /// 목표 수치
              ValidateTextformfield(
                label: l.goal_amount,
                readOnly: false,
                hintText: "ex. 2.46",
                validator: validateDouble,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (v) => vm.updateValue(v),
                initialValue: state.value.toString(),
              ),
            ],
          ),
        ),
      ),

      /// 완료 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: () async {
          // 사용자 입력값 검증 > 통과 안되면 진행 막기
          if (!enabled) {
            return;
          }

          if (isEditMode) {
            // 1. [목표 수정]
            await goalVM.updateGoal(
              prev: goal!,
              title: state.title,
              unit: state.unit,
              value: double.tryParse(state.value) ?? 0,
              date: state.selectedDate!,
            );
          } else {
            // 2. [목표 추가]
            await goalVM.addGoal(
              title: state.title,
              unit: state.unit,
              value: double.tryParse(state.value) ?? 0,
              date: state.selectedDate!,
            );
          }

          if (!context.mounted) return;
          context.pop();
          // 📝
          if (!isEditMode) {
            AnalyticsService.event('goal_action', p: {'action': 'create'});
          }
        },

        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DoneButton(
              onTap: onTap,
              text: l.complete,
              backgroundColor: enabled ? f.secondary400! : f.textcolor200!,
              textColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
