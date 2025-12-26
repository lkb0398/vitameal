import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메뉴", style: TextStyle(fontSize: 20))),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              // TODO : 페이지 연결
              // context.go('/language');
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
              // TODO : 페이지 연결
              // context.go('/notification');
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
            },
            child: Container(
              decoration: BoxDecoration(
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
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              alignment: AlignmentDirectional.centerStart,
              height: 60,
              width: double.infinity,
              child: Text("회원 탈퇴"),
            ),
          ),
        ],
      ),
    );
  }
}
