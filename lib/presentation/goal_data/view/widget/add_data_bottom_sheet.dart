import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal_data/view_model/goal_data_page_view_model.dart';
import 'package:vitameal/presentation/goal_data/view_model/goal_datas_view_model.dart';
import 'package:vitameal/presentation/ui_provider/formatted_date_provider.dart';
import 'package:vitameal/presentation/util/date_time_utils.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';
import 'package:vitameal/presentation/goal_data/view/util/pick_datetime.dart.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class AddDataBottomSheet extends HookConsumerWidget {
  const AddDataBottomSheet({super.key, required this.goal});

  final GoalsEntity goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎

    final state = ref.watch(goalDataPageViewModelProvider(selectedGoal: goal));
    final vm = ref.read(
      goalDataPageViewModelProvider(selectedGoal: goal).notifier,
    );

    final dataVM = ref.read(
      goalDatasViewModelProvider(goalId: state.selectedGoal.goalId!).notifier,
    );

    // (데이터 날짜) 날짜 입력 받기 위한 controller 및 state 동기화
    final dataDateController = useTextEditingController();
    useEffect(() {
      dataDateController.text = state.selectedDate != null
          ? '${ref.watch(formattedDateProvider(state.selectedDate!))}  ${state.selectedDate!.timeLabel}'
          : '';
      return null;
    }, [state.selectedDate]);

    // (데이터 수치) 입력값 검증 메시지
    String? validateDouble(String? value) {
      if (value == null || value.isEmpty) {
        return l.enter_value; // 입력값 없을 때
      }
      final dataValue = double.tryParse(value);
      if (dataValue == null) {
        return l.invalid_number; // 숫자가 아닐 때
      }
      return null; // 통과
    }

    // 버튼 활성화 여부
    final bool enabled =
        state.selectedDate != null && validateDouble(state.value) == null;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          spacing: 10,
          children: [
            /// 상단 바
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: f.textcolor200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            /// 데이터 입력창
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    l.add_data,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),

                  /// 데이터 날짜
                  ValidateTextformfield(
                    readOnly: true,
                    title: l.date,
                    hintText:
                        "ex. ${ref.watch(formattedDateProvider(DateTime(2000, 1, 31)))}  13:30",
                    controller: dataDateController,
                    onTap: () async {
                      final selectedDate = await pickDateTime(context);
                      if (selectedDate == null) return;
                      vm.updateSelectedDate(selectedDate);
                    },
                  ),

                  /// 데이터 수치
                  ValidateTextformfield(
                    readOnly: false,
                    title: l.value,
                    hintText: "ex. 5.0",
                    helperText: "",
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

            /// 완료 버튼
            TapDebouncer(
              onTap: () async {
                // 사용자 입력값 검증 > 통과 안되면 진행 막기
                if (!enabled) {
                  return;
                }

                // [데이터 추가]
                await dataVM.addData(
                  goalId: state.selectedGoal.goalId!,
                  dataDate: state.selectedDate!,
                  dataValue: double.tryParse(state.value) ?? 0,
                );

                if (!context.mounted) return;
                Navigator.pop(context);

                // 입력값 초기화
                vm.updateValue('');
                vm.updateSelectedDate(null);

                // 📝
                AnalyticsService.event(
                  'goal_actoin',
                  p: {'action': 'add_data'},
                );
              },

              builder: (BuildContext context, TapDebouncerFunc? onTap) {
                return SafeArea(
                  top: false,
                  child: DoneButton(
                    onTap: onTap,
                    backgroundColor: enabled
                        ? f.secondary100!
                        : f.textcolor300!,
                    textColor: enabled ? f.secondary400! : Colors.white,
                    text: l.complete,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
