import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/user_goals_entity.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'user_goals_view_model.g.dart';

@riverpod
class UserGoalsViewModel extends _$UserGoalsViewModel {
  @override
  void build() {}

  Future<void> saveGoal({
    required String goalTitle,
    required String goalUnit,
    required double goalValue,
    required DateTime goalDate,
    required bool isDone,
    required bool isMain,
  }) async {
    final userId = ref.read(userIdProvider);
    await ref
        .read(userGoalsRepositoryProvider)
        .saveGoal(
          UserGoalsEntity(
            userId: userId,
            goalTitle: goalTitle,
            goalUnit: goalUnit,
            goalValue: goalValue,
            goalDate: goalDate,
            isDone: isDone,
            isMain: isMain,
          ),
        );
  }

  Future<void> updateGoal({
    required String goalId,
    required String goalTitle,
    required String goalUnit,
    required double goalValue,
    required DateTime goalDate,
    required bool isDone,
    required bool isMain,
  }) async {
    await ref
        .read(userGoalsRepositoryProvider)
        .updateGoal(
          UserGoalsEntity(
            goalId: goalId,
            goalTitle: goalTitle,
            goalUnit: goalUnit,
            goalValue: goalValue,
            goalDate: goalDate,
            isDone: isDone,
            isMain: isMain,
          ),
        );
  }

  Future<void> updateMainGoal(String goalId) async {
    await ref.read(userGoalsRepositoryProvider).updateMainGoal(goalId);
  }

  Future<void> deleteGoal(String goalId) async {
    await ref.read(userGoalsRepositoryProvider).deleteGoal(goalId);
  }
}
