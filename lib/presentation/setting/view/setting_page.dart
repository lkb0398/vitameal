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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leadingWidth: 64,
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
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MenuItem(
                onTap: () => context.push('/language'),
                title: l.language_setting,
                showArrow: true,
              ),
              const SizedBox(height: 3),

              MenuItem(
                onTap: () => context.push('/noti'),
                title: l.notification_setting,
                showArrow: true,
              ),
              const SizedBox(height: 3),

              MenuItem(
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
                title: l.logout,
              ),
              const SizedBox(height: 3),

              MenuItem(
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
                        await ref
                            .read(authViewModelProvider.notifier)
                            .withdraw(
                              onError: () {
                                showGraySnackBar(context, l.withdraw_error);
                              },
                            );
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        // 📝
                        AnalyticsService.event('withdraw');
                      },
                    ),
                  );
                },
                title: l.withdraw_account,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
