import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';

part 'goal_page_view_model.freezed.dart';
part 'goal_page_view_model.g.dart';

// ==================== State ====================

@freezed
abstract class GoalPageState with _$GoalPageState {
  const factory GoalPageState({
    @Default('') String title, // 목표명 입력값
    @Default('') String unit, // 목표 단위 입력값
    @Default('') String value, // 목표 수치 입력값
    DateTime? selectedDate, // 날짜 선택값
  }) = _GoalPageState;
}

// ==================== ViewModel ====================

@riverpod
class GoalPageViewModel extends _$GoalPageViewModel {
  @override
  GoalPageState build({required GoalsEntity? goal}) {
    return _initState(goal);
  }

  // [상태 초기값 세팅]
  GoalPageState _initState(GoalsEntity? goal) {
    if (goal == null) return GoalPageState();
    // 수정모드
    return GoalPageState(
      title: goal.goalTitle,
      unit: goal.goalUnit,
      value: goal.goalValue.toString(),
      selectedDate: goal.goalDate,
    );
  }

  // [목표명 입력값 변경]
  void updateTitle(String v) => state = state.copyWith(title: v);

  // [목표 단위 입력값 변경]
  void updateUnit(String v) => state = state.copyWith(unit: v);

  // [목표 수치 입력값 변경]
  void updateValue(String v) => state = state.copyWith(value: v);

  // [날짜 선택값 변경]
  void updateSelectedDate(DateTime v) =>
      state = state.copyWith(selectedDate: v);
}
