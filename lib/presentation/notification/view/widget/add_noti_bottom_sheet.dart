import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/notifications_entity.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_view_model.dart';
import 'package:vitameal/presentation/ui_provider/notifications_provider.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class AddNotiBottomSheet extends HookConsumerWidget {
  const AddNotiBottomSheet({super.key, this.noti, required this.initialTime});

  final NotificationsEntity? noti; // noti != null (수정) / noti == null (추가)
  final TimeOfDay initialTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    TimeOfDay selectedTime = initialTime;

    // next_fire_at 계산
    DateTime calculateNextFireAt({required TimeOfDay time}) {
      final now = DateTime.now();
      DateTime scheduled = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      // 이미 지났으면 다음 날
      if (scheduled.isBefore(now)) {
        scheduled = scheduled.add(const Duration(days: 1));
      }
      // DB에는 무조건 UTC
      return scheduled.toUtc();
    }

    // 알림명 : 사용자 입력값 받기 + 입력값 검증 메시지
    final labelController = useTextEditingController();
    String? validateLabel(String? value) {
      if (value == null || value.trim().isEmpty) {
        return l.enter_notification_name; // 입력값 없을 때
      }
      return null; // 통과
    }

    // 수정 화면에서 기존값 불러오기
    final didInit = useRef(false);
    final savedGoalRef = useRef<NotificationsEntity?>(null);
    useEffect(() {
      if (noti == null) return null;
      if (didInit.value) return null;
      didInit.value = true;
      labelController.text = noti!.label;
      savedGoalRef.value = noti;
      return null;
    }, [noti]);

    // 버튼 활성화 여부
    final isButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        final hasLabel = labelController.text.trim().isNotEmpty;
        isButtonEnabled.value = hasLabel;
      }

      labelController.addListener(listener);
      // 초기 상태 강제 계산 (수정 모드 대응)
      isButtonEnabled.value = labelController.text.trim().isNotEmpty;

      return () {
        labelController.removeListener(listener);
      };
    }, [noti]);

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
                  color: fxc(context).textcolor200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              /// 알림명 입력창
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(l.notification_name, style: TextStyle(fontSize: 16)),
                    ValidateTextformfield(
                      readOnly: false,
                      hintText: l.breakfast_alarm,
                      helperText: "",
                      validator: validateLabel,
                      controller: labelController,
                    ),
                  ],
                ),
              ),

              /// 시간 선택
              SizedBox(
                height: 120,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  initialDateTime: DateTime(
                    0,
                    0,
                    0,
                    initialTime.hour,
                    initialTime.minute,
                  ),
                  onDateTimeChanged: (dateTime) {
                    selectedTime = TimeOfDay(
                      hour: dateTime.hour,
                      minute: dateTime.minute,
                    );
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

                  noti != null
                      ?
                        // 1. 알림 수정
                        await ref
                            .read(notificationsViewModelProvider.notifier)
                            .updateNoti(
                              notiId: noti!.notiId!,
                              label: labelController.text,
                              time: selectedTime,
                              isEnabled: noti!.isEnabled,
                              timezone: noti!.timezone,
                              nextFireAt: calculateNextFireAt(
                                time: selectedTime,
                              ),
                            )
                      : // 2. 알림 추가
                        await ref
                            .read(notificationsViewModelProvider.notifier)
                            .saveNoti(
                              label: labelController.text,
                              time: selectedTime,
                              isEnabled: true,
                              timezone: "Asia/Seoul",
                              nextFireAt: calculateNextFireAt(
                                time: selectedTime,
                              ),
                            );
                  // mounted 체크
                  if (!context.mounted) return;
                  // UI 반영
                  ref.invalidate(getAllNotisProvider);
                  Navigator.pop(context);
                  // 📝
                  AnalyticsService.event(
                    'noti_action',
                    p: {'action': 'create'},
                  );
                },
                builder: (BuildContext context, TapDebouncerFunc? onTap) {
                  return DoneButton(
                    onTap: onTap,
                    backgroundColor: isButtonEnabled.value
                        ? fxc(context).primary100!
                        : fxc(context).textcolor300!,
                    text: l.complete,
                    textColor: isButtonEnabled.value
                        ? fxc(context).primary600!
                        : Colors.white,
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
