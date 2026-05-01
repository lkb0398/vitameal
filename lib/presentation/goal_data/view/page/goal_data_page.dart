import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal_data/view/widget/select_goal.dart';
import 'package:vitameal/presentation/util/show_gray_snackbar.dart';
import 'package:vitameal/presentation/goal_data/view/widget/add_data_bottom_sheet.dart';
import 'package:vitameal/presentation/goal_data/view/widget/view_data.dart';

class GoalDataPage extends ConsumerWidget {
  const GoalDataPage({super.key, required this.goal});

  final GoalsEntity goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎

    return Scaffold(
      appBar: AppBar(title: Text(l.recent_data)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 목표 선택 영역
            Padding(
              padding: const EdgeInsets.all(20),
              child: SelectGoal(goal: goal),
            ),
            // 데이터 리스트 영역
            ViewData(goal: goal, isDone: goal.isDone),
          ],
        ),
      ),

      /// 데이터 추가 버튼
      floatingActionButton: RawMaterialButton(
        onPressed: () async {
          // 완료된 목표일 시 비활성화
          if (goal.isDone) {
            showGraySnackBar(context, l.goal_already_achieved);
            return;
          }
          // 데이터 추가 bottomsheet
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return AddDataBottomSheet(goal: goal);
            },
          );
        },
        fillColor: f.secondary400,
        shape: const CircleBorder(),
        constraints: const BoxConstraints(minWidth: 60, minHeight: 60),
        elevation: 0,
        child: Icon(PhosphorIcons.plus(), size: 32, color: Colors.white),
      ),
    );
  }
}
