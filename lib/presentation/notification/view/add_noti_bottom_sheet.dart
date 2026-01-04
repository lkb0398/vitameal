import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_entity.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class AddNotiBottomSheet extends HookConsumerWidget {
  const AddNotiBottomSheet({
    super.key,
    this.noti,
    required this.controller,
    required this.initialTime,
    required this.onConfirm,
  });

  final NotificationsEntity? noti;
  final TextEditingController controller;
  final TimeOfDay initialTime;
  final void Function(TimeOfDay newTime) onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TimeOfDay selectedTime = initialTime;

    // 알림명 : 입력값 검증 메시지
    String? validateLabel(String? value) {
      if (value == null || value.trim().isEmpty) {
        return '이름을 입력해주세요.'; // 입력값 없을 때
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
      controller.text = noti!.label;
      savedGoalRef.value = noti;
      return null;
    }, [noti]);

    return SizedBox(
      height: 300,
      child: Column(
        spacing: 15,
        children: [
          /// 상단 바
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          /// 알림명 입력창
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(width: 40, child: Text("이름")),
                Expanded(
                  child: ValidateTextformfield(
                    readOnly: false,
                    hintText: "아침",
                    validator: validateLabel,
                    controller: controller,
                  ),
                ),
              ],
            ),
          ),

          /// 시간 선택
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: false, // 오전/오후
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
              final label = controller.text.trim();
              if (validateLabel(label) != null) {
                return;
              }

              onConfirm(selectedTime);

              Navigator.pop(context);

              controller.clear();
            },
            builder: (BuildContext context, TapDebouncerFunc? onTap) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen[200],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: onTap,
                    child: const Text('완료'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
