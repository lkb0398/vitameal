import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/notifications_entity.dart';
import 'package:vitameal/presentation/notification/view_model/notification_page_view_model.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_view_model.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class AddNotiBottomSheet extends HookConsumerWidget {
  const AddNotiBottomSheet({super.key, this.noti, required this.initialTime});

  final NotificationsEntity? noti;
  final TimeOfDay initialTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎

    final notiVM = ref.read(notificationsViewModelProvider.notifier);

    final vm = ref.read(notificationPageViewModelProvider(noti: noti).notifier);
    final state = ref.watch(notificationPageViewModelProvider(noti: noti));

    final bool isEditMode = noti != null; // 수정모드 분기

    // 알림명 : 사용자 입력값 받기 + 검증 메세지
    final labelController = useTextEditingController();
    String? validateLabel(String? value) {
      if (value == null || value.trim().isEmpty) {
        return l.enter_notification_name; // 입력값 없을 때
      }
      return null; // 통과
    }

    // controller 텍스트와 상태 동기화
    useEffect(() {
      labelController.text = state.label ?? '';
      return null;
    }, []);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 340,
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

              /// 알림명 입력창
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValidateTextformfield(
                  label: l.notification_name,
                  readOnly: false,
                  hintText: l.breakfast_alarm,
                  helperText: "",
                  validator: validateLabel,
                  controller: labelController,
                  onChanged: (v) => vm.updateLabel(v),
                ),
              ),

              /// 시간 선택
              SizedBox(
                height: 120,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  initialDateTime: DateTime(
                    2000,
                    1,
                    1,
                    initialTime.hour,
                    initialTime.minute,
                  ),
                  onDateTimeChanged: (dateTime) {
                    final time = TimeOfDay(
                      hour: dateTime.hour,
                      minute: dateTime.minute,
                    );
                    vm.updateSelectedTime(time);
                  },
                ),
              ),

              /// 완료 버튼
              TapDebouncer(
                onTap: () async {
                  // 사용자 입력값 검증 > 통과 안되면 진행 막기
                  final label = labelController.text.trim();
                  if (validateLabel(label) != null) {
                    return;
                  }

                  if (isEditMode) {
                    // 1. [알림 수정]
                    await notiVM.updateNoti(
                      prev: noti!,
                      label: state.label!,
                      time: state.selectedTime!,
                    );
                  } else {
                    // 2. [알림 추가]
                    await notiVM.addNoti(
                      label: state.label!,
                      time: state.selectedTime!,
                    );
                  }

                  if (!context.mounted) return;
                  Navigator.pop(context);
                  // 📝
                  AnalyticsService.event(
                    'noti_action',
                    p: {'action': 'create'},
                  );
                },
                builder: (BuildContext context, TapDebouncerFunc? onTap) {
                  final enabled = state.label?.trim().isNotEmpty ?? false;

                  return DoneButton(
                    onTap: onTap,
                    backgroundColor: enabled ? f.primary100! : f.textcolor300!,
                    text: l.complete,
                    textColor: enabled ? f.primary600! : Colors.white,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
