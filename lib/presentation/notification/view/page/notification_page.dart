import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/notification_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/notification/view/widget/add_noti_bottom_sheet.dart';
import 'package:vitameal/presentation/notification/view/widget/noti_item.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_view_model.dart';
import 'package:vitameal/presentation/widget/button/add_button.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    final notisAsync = ref.watch(notificationsViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.notification_setting)),
      body: notisAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const SizedBox.shrink(),
        data: (notis) {
          final list = notis ?? [];

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),

            /// 알림 리스트
            child: ListView.builder(
              itemCount: list.length + 1,
              itemBuilder: (context, index) {
                if (index == list.length) {
                  return Column(
                    children: [
                      // 알림 없을 때
                      if (list.isEmpty)
                        SizedBox(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Icon(
                                PhosphorIcons.bellSlash(),
                                size: 120,
                                color: v.emptyText,
                              ),
                              Text(
                                "${l.no_notifications} :(",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: v.emptyText,
                                ),
                              ),
                            ],
                          ),
                        ),

                      /// 새 알림 추가 버튼
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: AddButton(
                          onTap: () async {
                            // 알림 권한 요청
                            final service = NotificationService();
                            await service.requestPermission();

                            // 알림 권한 여부 확인
                            final isGranted = await service
                                .isPermissionGranted();

                            // 거부 시
                            if (!isGranted) {
                              await service.requestPermission();
                            }
                            if (!context.mounted) return;
                            // if (!isGranted) {
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return CustomDialog(
                            //         title: l.need_noti_perm,
                            //         content: l.request_noti_perm,
                            //         confirmText: l.open_setting,
                            //         cancelText: l.cancel,
                            //         onConfirm: () async {
                            //           await permission.Permission.notification
                            //               .request();
                            //           await permission.openAppSettings();
                            //         },
                            //       );
                            //     },
                            //   );
                            // }

                            // 허용 시
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
                          borderColor: f.primary400!,
                          text: "+ ${l.add_notification}",
                          textColor: f.primary400!,
                        ),
                      ),
                    ],
                  );
                }
                final noti = list[index];
                return NotiItem(noti: noti);
              },
            ),
          );
        },
      ),
    );
  }
}
