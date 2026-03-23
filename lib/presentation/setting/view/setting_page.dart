import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/auth/view_model/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:vitameal/presentation/setting/view/widgets/menu_item.dart';
import 'package:vitameal/presentation/util/show_gray_snackbar.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    final themeVrc = vrc(context);
    final themeFxc = fxc(context);

    return Scaffold(
      /// 앱바
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: themeVrc.text,
              size: 28,
            ),
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
        title: Text(
          l.menu,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: themeVrc.text,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// 알림 설정
              MenuItem(
                title: l.notification_setting,
                showArrow: true,
                onTap: () => context.push('/noti'),
              ),

              /// 언어 설정
              MenuItem(
                title: l.language_setting,
                showArrow: true,
                onTap: () => context.push('/language'),
              ),

              /// 날짜 설정
              MenuItem(
                title: l.date_setting,
                showArrow: true,
                onTap: () => context.push('/date'),
              ),

              /// 로그아웃
              MenuItem(
                title: l.logout,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: l.confirm_logout,
                      cancelText: l.cancel,
                      confirmText: l.confirm,
                      confirmColor: themeFxc.secondary400,
                      onConfirm: () async {
                        Navigator.pop(context);
                        await ref.read(authViewModelProvider.notifier).logout();
                        // 📝
                        AnalyticsService.event('logout');
                      },
                    ),
                  );
                },
              ),

              /// 회원 탈퇴
              MenuItem(
                title: l.withdraw_account,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: l.confirm_withdraw,
                      content: l.withdraw_warning,
                      cancelText: l.keep_account,
                      confirmText: l.withdraw,
                      confirmColor: themeFxc.primary400,
                      reverseButtons: true,
                      onConfirm: () async {
                        Navigator.pop(context);
                        await ref
                            .read(authViewModelProvider.notifier)
                            .withdraw(
                              onError: () {
                                showGraySnackBar(context, l.withdraw_error);
                              },
                            );
                        // 📝
                        AnalyticsService.event('withdraw');
                      },
                    ),
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
