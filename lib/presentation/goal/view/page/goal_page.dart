import 'package:flutter/material.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/goal/view/widget/view_goal.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎

    return Scaffold(
      appBar: AppBar(title: Text(l.health_goals)),
      body: Column(
        children: [
          /// 제목 행
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 40,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: f.textcolor200!)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      l.goal_title,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      l.goal_value,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      l.set_representative,
                      style: TextStyle(color: f.secondary400),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 목표 리스트
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: const ViewGoal(),
            ),
          ),
        ],
      ),
    );
  }
}
