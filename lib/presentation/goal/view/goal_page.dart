import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitameal/presentation/goal/view/entity.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("건강 목표")),
      body: Column(
        children: [
          /// 제목 행
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            height: 40,
            child: Row(
              children: [
                SizedBox(width: 100, child: Center(child: Text("목표명"))),
                Expanded(child: Center(child: Text("목표 수치값"))),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text("대표설정", style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];

                return InkWell(
                  onTap: () {
                    context.push('/edit/goal', extra: goal); // 페이지 이동 시 객체 전달
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                      color: goal.isDone ? Colors.grey : null,
                    ),
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Center(child: Text(goal.goalTitle)),
                        ),
                        Expanded(
                          child: Center(
                            child: Text('${goal.goalValue} ${goal.goalUnit}'),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: goal.isDone
                              ? Icon(Icons.remove)
                              : goal.isMain
                              ? Icon(Icons.check, color: Colors.red)
                              : SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      /// 목표 추가 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add/goal');
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
