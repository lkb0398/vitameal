import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/auth/view_model/auth_view_model.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("메뉴", style: TextStyle(fontSize: 20))),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              // TODO : 페이지 연결
              // context.push('/language');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("언어 설정"), Icon(Icons.arrow_forward_ios)],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.push('/alarm');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("알림 설정"), Icon(Icons.arrow_forward_ios)],
              ),
            ),
          ),

          InkWell(
            onTap: () {
              // TODO : 로그아웃 기능 구현하기
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("로그아웃"),
                  content: const Text("로그아웃 하시겠습니까?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("취소"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await ref.read(authViewModelProvider.notifier).logout();
                      },
                      child: const Text("확인"),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              alignment: AlignmentDirectional.centerStart,
              height: 60,
              width: double.infinity,
              child: Text("로그아웃"),
            ),
          ),

          InkWell(
            onTap: () {
              // TODO : 회원 탈퇴 기능 구현하기
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("회원 탈퇴"),
                  content: const Text(
                    "정말로 탈퇴 하시겠습니까?\n모든 데이터가 즉시 삭제되며 복구할 수 없습니다.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("취소"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();

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
                      child: const Text(
                        "확인",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              alignment: AlignmentDirectional.centerStart,
              height: 60,
              width: double.infinity,
              child: const Text("회원 탈퇴", style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
