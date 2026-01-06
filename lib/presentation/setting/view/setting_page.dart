import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/auth/view_model/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:vitameal/presentation/setting/view/widgets/custom_dialog.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/setting/view/widgets/menu_item.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          "메뉴",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            MenuItem(
              onTap: () {
                // TODO : 페이지 연결
                // context.go('/language');
              },
              title: "언어 설정",
              showArrow: true,
            ),
            const SizedBox(height: 3),

            MenuItem(
              onTap: () {
                // TODO : 페이지 연결
                // context.go('/notification');
              },
              title: "알림 설정",
              showArrow: true,
            ),
            const SizedBox(height: 3),

            MenuItem(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: "로그아웃 하시겠습니까?",
                    cancelText: "취소",
                    confirmText: "확인",
                    confirmColor: themeFxc.secondary400,
                    onCancel: () => Navigator.pop(context),
                    onConfirm: () async {
                      Navigator.pop(context);
                      await ref.read(authViewModelProvider.notifier).logout();
                    },
                  ),
                );
              },
              title: "로그아웃",
            ),
            const SizedBox(height: 3),

            MenuItem(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: "정말 탈퇴하시겠습니까?",
                    titleFontFamily: 'Inter',
                    content: "탈퇴 시 데이터가 모두 삭제되며 복구되지 않습니다.",
                    cancelText: "탈퇴하기",
                    confirmText: "유지하기",
                    confirmColor: themeFxc.primary400,
                    reverseButtons: true,
                    onCancel: () async {
                      Navigator.pop(context);
                      await ref
                          .read(authViewModelProvider.notifier)
                          .withdraw(
                            onError: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("회원 탈퇴 중 오류가 발생했습니다."),
                                ),
                              );
                            },
                          );
                    },
                    onConfirm: () => Navigator.pop(context),
                  ),
                );
              },
              title: "회원 탈퇴",
//       appBar: AppBar(title: Text("메뉴", style: TextStyle(fontSize: 20))),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 // TODO : 페이지 연결
//                 // context.push('/language');
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: fxc(context).textcolor300!),
//                   ),
//                 ),
//                 height: 60,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("언어 설정", style: TextStyle(fontSize: 14)),
//                     Icon(Icons.arrow_forward_ios, size: 14),
//                   ],
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 context.push('/noti');
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: fxc(context).textcolor300!),
//                   ),
//                 ),
//                 height: 60,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("알림 설정", style: TextStyle(fontSize: 14)),
//                     Icon(Icons.arrow_forward_ios, size: 14),
//                   ],
//                 ),
//               ),
//             ),

//             InkWell(
//               onTap: () {
//                 // TODO : 로그아웃 기능 구현하기
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text("로그아웃"),
//                     content: const Text("로그아웃 하시겠습니까?"),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text("취소"),
//                       ),
//                       TextButton(
//                         onPressed: () async {
//                           Navigator.pop(context);
//                           await ref
//                               .read(authViewModelProvider.notifier)
//                               .logout();
//                         },
//                         child: const Text("확인"),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: fxc(context).textcolor300!),
//                   ),
//                 ),
//                 alignment: AlignmentDirectional.centerStart,
//                 height: 60,
//                 width: double.infinity,
//                 child: Text("로그아웃"),
//               ),
//             ),

//             InkWell(
//               onTap: () {
//                 // TODO : 회원 탈퇴 기능 구현하기
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text("회원 탈퇴"),
//                     content: const Text(
//                       "정말로 탈퇴 하시겠습니까?\n모든 데이터가 즉시 삭제되며 복구할 수 없습니다.",
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text("취소"),
//                       ),
//                       TextButton(
//                         onPressed: () async {
//                           Navigator.of(context).pop();

//                           await ref
//                               .read(authViewModelProvider.notifier)
//                               .withdraw(
//                                 onError: () {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text("회원 탈퇴 중 오류가 발생했습니다."),
//                                     ),
//                                   );
//                                 },
//                               );
//                         },
//                         child: const Text(
//                           "확인",
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: fxc(context).textcolor300!),
//                   ),
//                 ),
//                 alignment: AlignmentDirectional.centerStart,
//                 height: 60,
//                 width: double.infinity,
//                 child: const Text("회원 탈퇴", style: TextStyle(color: Colors.red)),
//               ),
            ),
          ],
        ),
      ),
    );
  }
}
