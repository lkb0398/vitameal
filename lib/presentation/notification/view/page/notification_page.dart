import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/notification/view/widget/add_noti_bottom_sheet.dart';
import 'package:vitameal/presentation/ui_provider/notifications_provider.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_view_model.dart';
import 'package:vitameal/presentation/widget/button/add_button.dart';
import 'package:vitameal/presentation/widget/dialog/delete_dialog.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notisAsync = ref.watch(getAllNotisProvider);

    return Scaffold(
      appBar: AppBar(title: Text("알림 설정")),
      body: notisAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러 발생: $e')),
        data: (notis) {
          final list = notis ?? [];
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),

            /// 알림 리스트
            child: ListView.builder(
              itemCount: list.length + 1,
              itemBuilder: (context, index) {
                if (index == list.length) {
                  return Column(
                    spacing: 30,
                    children: [
                      // 알림 없을 때 화면
                      list.isEmpty
                          ? Column(
                              spacing: 20,
                              children: [
                                SizedBox(height: 60),
                                Icon(
                                  PhosphorIcons.bellSlash(),
                                  size: 120,
                                  color: vrc(context).emptyText,
                                ),
                                Text(
                                  "등록한 알림이 없어요 :(",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: vrc(context).emptyText,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            )
                          : SizedBox.shrink(),

                      /// 새 알림 추가 버튼
                      AddButton(
                        onTap: () async {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (context) {
                              return AddNotiBottomSheet(
                                noti: null,
                                initialTime: TimeOfDay.now(),
                              );
                            },
                          );
                        },
                        borderColor: fxc(context).primary400!,
                        text: "+ 새 알림 추가하기",
                        textColor: fxc(context).primary400!,
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
                    extentRatio: 0.20,
                    children: [
                      CustomSlidableAction(
                        onPressed: (_) async {
                          final yes = await showDialog<bool>(
                            context: context,
                            builder: (_) => DeleteDialog(
                              onDelete: () => Navigator.pop(context, true),
                            ),
                          );
                          if (yes != true) return;
                          // 알림 삭제
                          await ref
                              .read(notificationsViewModelProvider.notifier)
                              .deleteNoti(noti.notiId!);
                          // mounted 체크
                          if (!context.mounted) return;
                          // UI 반영
                          ref.invalidate(getAllNotisProvider);
                          // 📝
                          AnalyticsService.event(
                            'noti_action',
                            p: {'action': 'delete'},
                          );
                        },
                        backgroundColor: fxc(context).secondary400!,
                        child: Icon(
                          PhosphorIcons.x(),
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // 탭 > 알림 수정
                  child: InkWell(
                    onTap: () async {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return AddNotiBottomSheet(
                            noti: noti,
                            initialTime: noti.time,
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        spacing: 10,
                        children: [
                          /// 알림명
                          Expanded(
                            child: Text(
                              noti.label,
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          /// 알림 시간
                          Text(
                            noti.time.format(context),
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.right,
                          ),

                          /// on/off 토글
                          Switch.adaptive(
                            applyCupertinoTheme: true,
                            value: noti.isEnabled,
                            activeThumbColor: Colors.white,
                            activeTrackColor: fxc(context).accentsgreen,
                            onChanged: (value) async {
                              // 알림 활성화 여부 변경
                              await ref
                                  .read(notificationsViewModelProvider.notifier)
                                  .updateNoti(
                                    notiId: noti.notiId!,
                                    label: noti.label,
                                    time: noti.time,
                                    isEnabled: value,
                                    timezone: noti.timezone,
                                    nextFireAt: noti.nextFireAt,
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
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
