import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/alarm/view/alarm_bottom_sheet.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_provider.dart';
import 'package:vitameal/presentation/alarm/view_model/alarms_view_model.dart';

class AlarmPage extends HookConsumerWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmsAsync = ref.watch(getAllAlarmsProvider);

    // 알람명 : 사용자 입력값 받기
    final labelController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("알람 설정"),
        actions: [TextButton(onPressed: () {}, child: Text("편집"))],
      ),

      /// 알람 목록
      body: alarmsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러 발생: $e')),
        data: (alarms) {
          final list = alarms ?? [];

          return ListView.builder(
            itemCount: list.length + 1,
            itemBuilder: (context, index) {
              /// 새 알림 추가 버튼
              if (index == list.length) {
                return Column(
                  children: [
                    SizedBox(height: 30),
                    OutlinedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text('새 알림 추가하기'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: BorderSide(color: Colors.green),
                        minimumSize: Size(double.infinity, 48),
                        padding: EdgeInsets.all(16),
                      ),
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (context) {
                            return AlarmBottomSheet(
                              controller: labelController,
                              initialTime: TimeOfDay.now(),
                              onConfirm: (newTime) async {
                                // 알람 추가
                                await ref
                                    .read(alarmsViewModelProvider.notifier)
                                    .saveAlarm(
                                      label: labelController.text,
                                      time: newTime,
                                      isEnabled: true,
                                    );

                                // mounted 체크
                                if (!context.mounted) return;

                                // UI 반영
                                ref.invalidate(getAllAlarmsProvider);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }
              final alarm = list[index];

              /// 스와이프
              return Slidable(
                key: ValueKey(alarm.alarmId),
                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (_) async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('알람 삭제'),
                            content: const Text('이 알람을 삭제할까요?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('취소'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('삭제'),
                              ),
                            ],
                          ),
                        );

                        if (ok != true) return;

                        // 알람 삭제
                        await ref
                            .read(alarmsViewModelProvider.notifier)
                            .deleteAlarm(alarm.alarmId!);

                        // mounted 체크
                        if (!context.mounted) return;

                        // UI 반영
                        ref.invalidate(getAllAlarmsProvider);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: '삭제',
                    ),
                  ],
                ),

                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    spacing: 10,
                    children: [
                      /// 알람명
                      Text(
                        alarm.label,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// 알람 시간
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              builder: (context) {
                                return AlarmBottomSheet(
                                  alarm: alarm,
                                  controller: labelController,
                                  initialTime: alarm.time,
                                  onConfirm: (newTime) async {
                                    // 알람 수정
                                    await ref
                                        .read(alarmsViewModelProvider.notifier)
                                        .updateAlarm(
                                          alarmId: alarm.alarmId!,
                                          label: labelController.text,
                                          time: newTime,
                                          isEnabled: true,
                                        );

                                    // mounted 체크
                                    if (!context.mounted) return;

                                    // UI 반영
                                    ref.invalidate(getAllAlarmsProvider);
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            alarm.time.format(context),
                            style: TextStyle(fontSize: 50),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),

                      /// on/off 토글
                      Switch.adaptive(
                        value: alarm.isEnabled,
                        activeThumbColor: Colors.white,
                        activeTrackColor: Colors.green,
                        onChanged: (value) async {
                          // 알람 활성화 업데이트
                          await ref
                              .read(alarmsViewModelProvider.notifier)
                              .updateEnableAlarm(alarm);

                          // mounted 체크
                          if (!context.mounted) return;

                          // UI 반영
                          ref.invalidate(getAllAlarmsProvider);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
