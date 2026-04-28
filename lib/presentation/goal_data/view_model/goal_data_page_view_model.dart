import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';

part 'goal_data_page_view_model.freezed.dart';
part 'goal_data_page_view_model.g.dart';

// ==================== State ====================

@freezed
abstract class GoalDataPageState with _$GoalDataPageState {
  const factory GoalDataPageState({
    required GoalsEntity selectedGoal, // 목표 선택값
    @Default(false) bool isReversed, // 정렬 (false = 최신순, true = 오래된순)
    @Default({}) Set<String> selectedDataIds, // 삭제 선택값 집합
    @Default('') String value, // 데이터 수치 입력값
    DateTime? selectedDate, // 날짜 선택값
  }) = _GoalDataPageState;
}

// ==================== ViewModel ====================

@riverpod
class GoalDataPageViewModel extends _$GoalDataPageViewModel {
  @override
  GoalDataPageState build({required GoalsEntity selectedGoal}) {
    return GoalDataPageState(selectedGoal: selectedGoal);
  }

  // [목표 선택값 변경]
  void updateGoal(GoalsEntity v) => state = state.copyWith(selectedGoal: v);

  // [정렬 변경]
  void updateReversed(bool v) => state = state.copyWith(isReversed: v);

  // [삭제 선택값 집합 변경]
  void updateIds(Set<String> v) => state = state.copyWith(selectedDataIds: v);

  // [데이터 수치 입력값 변경]
  void updateValue(String v) => state = state.copyWith(value: v);

  // [날짜 선택값 변경]
  void updateSelectedDate(DateTime? v) =>
      state = state.copyWith(selectedDate: v);
}
