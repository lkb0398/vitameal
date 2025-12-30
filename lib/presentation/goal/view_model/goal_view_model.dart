import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_entity.dart';
import 'package:vitameal/presentation/ui_provider/user_id_provider.dart';

part 'goal_view_model.g.dart';

@riverpod
class GoalViewModel extends _$GoalViewModel {
  @override
  void build() {
    return;
  }

  Future<void> saveGoal({
    required String goalTitle,
    required String goalUnit,
    required double goalValue,
    required DateTime goalDate,
    required bool isDone,
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
          ),
        );
  }
}
