import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/goals_entity.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'goals_view_model.g.dart';

@Riverpod(keepAlive: true)
class GoalsViewModel extends _$GoalsViewModel {
  // State : 목표 전체 목록 (Async)
  @override
  Future<List<GoalsEntity>?> build() async {
    return ref.read(goalsRepositoryProvider).readGoals();
  }

  // [목표 추가]
  Future<void> addGoal({
    required String title,
    required String unit,
    required double value,
    required DateTime date,
  }) async {
    final userId = ref.read(userIdProvider);
    final newGoal = GoalsEntity(
      userId: userId,
      goalTitle: title,
      goalUnit: unit,
      goalValue: value,
      goalDate: date,
      isDone: false,
      isMain: false,
    );

    // 낙관적 업데이트
    final current = state.value ?? [];
    state = AsyncData([newGoal, ...current]);

    // 서버 반영
    try {
      await ref.read(goalsRepositoryProvider).createGoal(newGoal);
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }

  // [목표 수정]
  Future<void> updateGoal({
    required GoalsEntity prev,
    required String title,
    required String unit,
    required double value,
    required DateTime date,
  }) async {
    final updatedGoal = prev.copyWith(
      goalTitle: title,
      goalUnit: unit,
      goalValue: value,
      goalDate: date,
    );

    // 낙관적 업데이트
    final current = state.value ?? [];
    final newList = [
      for (final n in current) n.goalId == updatedGoal.goalId ? updatedGoal : n,
    ];
    state = AsyncData(newList);

    // 서버 반영
    try {
      await ref.read(goalsRepositoryProvider).updateGoal(updatedGoal);
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }

  // [목표 삭제]
  Future<void> deleteGoal({required String id}) async {
    // 낙관적 업데이트
    final current = state.value ?? [];
    state = AsyncData(current.where((n) => n.goalId != id).toList());

    // 서버 반영
    try {
      await ref.read(goalsRepositoryProvider).deleteGoal(id);
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }

  // [대표설정 변경]
  Future<void> switchMain({required String? id, required bool v}) async {
    if (id == null) return;

    // 낙관적 업데이트
    final current = state.value ?? [];
    final newList = [
      for (final n in current) n.goalId == id ? n.copyWith(isMain: v) : n,
    ];
    state = AsyncData(newList);

    // 서버 반영
    try {
      await ref
          .read(goalsRepositoryProvider)
          .updateGoal(
            current.firstWhere((n) => n.goalId == id).copyWith(isMain: v),
          );
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }
}
