import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:vitameal/presentation/notification/view/add_noti_bottom_sheet.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_provider.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_view_model.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notisAsync = ref.watch(getAllNotisProvider);

    // 알림명 : 사용자 입력값 받기
    final labelController = useTextEditingController();

    // 사용자 timezone 가져오기
    final timezoneState = useState<String>('Asia/Seoul');
    useEffect(() {
      () async {
        final tzName = await FlutterNativeTimezone.getLocalTimezone();
        timezoneState.value = tzName;
      }();
      return null;
    }, const []);

    // next_fire_at 계산
    DateTime calculateNextFireAt({
      required TimeOfDay time,
      required String timezone,
    }) {
      final now = tz.TZDateTime.now(tz.getLocation(timezone));
      // 오늘 알림 시각
      tz.TZDateTime scheduled = tz.TZDateTime(
        tz.getLocation(timezone),
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      // 이미 지났으면 내일
      if (scheduled.isBefore(now)) {
        scheduled = scheduled.add(const Duration(days: 1));
      }
      // DB > UTC로 저장
      return scheduled.toUtc();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("알림 설정"),
        actions: [TextButton(onPressed: () {}, child: Text("편집"))],
      ),

      /// 알림 목록
      body: notisAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러 발생: $e')),
        data: (notis) {
          final list = notis ?? [];

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
                            return AddNotiBottomSheet(
                              controller: labelController,
                              initialTime: TimeOfDay.now(),
                              onConfirm: (newTime) async {
                                final tzName = timezoneState.value;
                                final nextFireAt = calculateNextFireAt(
                                  time: newTime,
                                  timezone: tzName,
                                );

                                // 알림 추가
                                await ref
                                    .read(
                                      notificationsViewModelProvider.notifier,
                                    )
                                    .saveNoti(
                                      label: labelController.text,
                                      time: newTime,
                                      isEnabled: true,
                                      timezone: tzName,
                                      nextFireAt: nextFireAt,
                                    );

                                // mounted 체크
                                if (!context.mounted) return;

                                // UI 반영
                                ref.invalidate(getAllNotisProvider);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }
              final noti = list[index];

              /// 스와이프
              return Slidable(
                key: ValueKey(noti.notiId),
                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (_) async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('알림 삭제'),
                            content: const Text('이 알림을 삭제할까요?'),
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

                        // 알림 삭제
                        await ref
                            .read(notificationsViewModelProvider.notifier)
                            .deleteNoti(noti.notiId!);

                        // mounted 체크
                        if (!context.mounted) return;

                        // UI 반영
                        ref.invalidate(getAllNotisProvider);
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
                      /// 알림명
                      Text(
                        noti.label,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// 알림 시간
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
                                return AddNotiBottomSheet(
                                  noti: noti,
                                  controller: labelController,
                                  initialTime: noti.time,
                                  onConfirm: (newTime) async {
                                    // 알림 업데이트
                                    await ref
                                        .read(
                                          notificationsViewModelProvider
                                              .notifier,
                                        )
                                        .updateNoti(
                                          notiId: noti.notiId!,
                                          label: labelController.text,
                                          time: newTime,
                                          isEnabled: noti.isEnabled,
                                          timezone: noti.timezone,
                                          nextFireAt: calculateNextFireAt(
                                            time: newTime,
                                            timezone: noti.timezone,
                                          ),
                                        );

                                    // mounted 체크
                                    if (!context.mounted) return;

                                    // UI 반영
                                    ref.invalidate(getAllNotisProvider);
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            noti.time.format(context),
                            style: TextStyle(fontSize: 50),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),

                      /// on/off 토글
                      Switch.adaptive(
                        value: noti.isEnabled,
                        activeThumbColor: Colors.white,
                        activeTrackColor: Colors.green,
                        onChanged: (value) async {
                          // 알림 업데이트
                          await ref
                              .read(notificationsViewModelProvider.notifier)
                              .updateNoti(
                                notiId: noti.notiId!,
                                label: noti.label,
                                time: noti.time,
                                isEnabled: value,
                                timezone: noti.timezone,
                                nextFireAt: calculateNextFireAt(
                                  time: noti.time,
                                  timezone: noti.timezone,
                                ),
                              );

                          // mounted 체크
                          if (!context.mounted) return;

                          // UI 반영
                          ref.invalidate(getAllNotisProvider);
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
