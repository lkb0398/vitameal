import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/notifications_entity.dart';
import 'package:vitameal/presentation/notification/view/widget/add_noti_bottom_sheet.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_view_model.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';

class NotiItem extends ConsumerWidget {
  const NotiItem({super.key, required this.noti});

  final NotificationsEntity noti;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎

    final notiVM = ref.read(notificationsViewModelProvider.notifier);

    return Slidable(
      key: ValueKey(noti.notiId),
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        extentRatio: 0.20,
        children: [
          /// 슬라이드 > 삭제
          CustomSlidableAction(
            onPressed: (_) async {
              final yes = await showDialog<bool>(
                context: context,
                builder: (_) => CustomDialog(
                  onConfirm: () => Navigator.pop(context, true),
                  title: l.confirm_delete,
                  confirmText: l.delete,
                  cancelText: l.cancel,
                ),
              );
              if (yes != true) return;

              // [알림 삭제]
              await notiVM.deleteNoti(id: noti.notiId!);

              // 📝
              AnalyticsService.event('noti_action', p: {'action': 'delete'});
            },
            backgroundColor: f.secondary400!,
            child: Icon(PhosphorIcons.x(), size: 30, color: Colors.white),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return AddNotiBottomSheet(noti: noti, initialTime: noti.time);
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          padding: const EdgeInsets.all(10),
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
                activeTrackColor: f.accentsgreen,
                onChanged: (value) async {
                  // [알림 활성화 여부 변경]
                  await notiVM.switchEnabled(id: noti.notiId, v: value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
