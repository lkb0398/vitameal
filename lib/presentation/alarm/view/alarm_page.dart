import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlarmEntity {
  AlarmEntity({
    this.userId,
    this.alarmId,
    required this.label,
    required this.time,
    required this.isEnabled,
  });

  final String? userId;
  final String? alarmId;
  final String label; // 아침, 점심 등
  final TimeOfDay time;
  bool isEnabled;
}

final List<AlarmEntity> alarms = [
  AlarmEntity(label: "아침", time: TimeOfDay.now(), isEnabled: true),
  AlarmEntity(label: "점심", time: TimeOfDay.now(), isEnabled: false),
  AlarmEntity(label: "저녁", time: TimeOfDay.now(), isEnabled: true),
  AlarmEntity(label: "야식", time: TimeOfDay.now(), isEnabled: false),
];

class AlarmPage extends HookConsumerWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 알람명 : 사용자 입력값 받기 + 검증 메시지
    final labelController = useTextEditingController();
    String? validateLabel(String? value) {
      if (value == null || value.trim().isEmpty) {
        return '이름을 입력해주세요.'; // 입력값 없을 때
      }
      return null; // 통과
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("알림 설정"),
        actions: [TextButton(onPressed: () {}, child: Text("편집"))],
      ),
      body: Column(
        spacing: 30,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: alarms.length,
            itemBuilder: (context, index) {
              final alarm = alarms[index];

              return Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey),
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  spacing: 10,
                  children: [
                    Text(
                      alarm.label,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // TODO : 알람 수정
                        },
                        onLongPress: () {
                          // TODO : 알림 삭제
                        },
                        child: Text(
                          alarm.time.format(context),
                          style: TextStyle(fontSize: 50),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: alarm.isEnabled,
                      activeThumbColor: Colors.white,
                      activeTrackColor: Colors.green,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              );
            },
          ),
          OutlinedButton.icon(
            onPressed: () {
              showTimePickerBottomSheet(
                context,
                initialTime: TimeOfDay.now(),
                onConfirm: (newTime) {
                  // 알람 추가
                  alarms.add(
                    AlarmEntity(
                      label: labelController.text,
                      time: newTime,
                      isEnabled: true,
                    ),
                  );
                },
                validator: validateLabel,
                controller: labelController,
              );
            },
            icon: Icon(Icons.add),
            label: Text('새 알림 추가하기'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              side: BorderSide(color: Colors.green),
              minimumSize: Size(double.infinity, 48),
            ),
          ),
        ],
      ),
    );
  }

  void showTimePickerBottomSheet(
    BuildContext context, {
    required TimeOfDay initialTime,
    required ValueChanged<TimeOfDay> onConfirm,
    required String? Function(String?) validator,
    required TextEditingController? controller,
  }) {
    TimeOfDay selectedTime = initialTime;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
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

              /// 알람명 입력창
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(width: 40, child: Text("이름")),
                    Expanded(
                      child: TextFormField(
                        // TODO : ValidateTextFormField 로 바꾸기
                        decoration: InputDecoration(
                          hintText: "아침",
                          // errorText: errorText,
                          helperText: "",
                          helperMaxLines: 1,
                          errorMaxLines: 1,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          isDense: true,
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validator,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
              ),

              /// Time Picker
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
              Padding(
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
                    onPressed: () {
                      onConfirm(selectedTime);
                      Navigator.pop(context);
                    },
                    child: const Text('완료'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
