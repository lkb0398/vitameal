import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/domain/entity/goal_datas_entity.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/goal/view_model/goals_view_model.dart';
import 'package:vitameal/presentation/goal_data/view_model/goal_datas_view_model.dart';

part 'main_goal_view_model.freezed.dart';
part 'main_goal_view_model.g.dart';

// ==================== State ====================

@freezed
abstract class MainGoalState with _$MainGoalState {
  const factory MainGoalState({
    GoalsEntity? mainGoal, // 대표 설정된 목표
    List<GoalDatasEntity>? mainGoalDatas, // 대표 설정된 목표의 데이터 전체 목록

    GoalDatasEntity? oldestData, // 초기 데이터
    GoalDatasEntity? latestData, // 최근 데이터
    List<GoalDatasEntity>? latest5Datas, // 최근 데이터 5개 목록
  }) = _MainGoalState;
}

// ==================== ViewModel ====================

@Riverpod(keepAlive: true)
class MainGoalViewModel extends _$MainGoalViewModel {
  // [데이터 로드]
  @override
  MainGoalState build() {
    final goalsAsync = ref.watch(goalsViewModelProvider);

    final mainGoal = goalsAsync.whenOrNull(
      data: (goals) {
        if (goals == null || goals.isEmpty) return null;
        return goals.firstWhere((g) => g.isMain);
      },
    );

    final datasAsync = mainGoal == null
        ? null
        : ref.watch(goalDatasViewModelProvider(goalId: mainGoal.goalId!));

    final datas = datasAsync?.whenOrNull(data: (d) => d);

    if (datas == null || datas.isEmpty) {
      return MainGoalState(mainGoal: mainGoal, mainGoalDatas: datas);
    }

    return MainGoalState(
      mainGoal: mainGoal,
      mainGoalDatas: datas,
      oldestData: datas.last,
      latestData: datas.first,
      latest5Datas: datas.take(5).toList(),
    );
  }
}
