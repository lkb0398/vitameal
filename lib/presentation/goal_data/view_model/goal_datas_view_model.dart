import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/goal_datas_entity.dart';

part 'goal_datas_view_model.g.dart';

@Riverpod(keepAlive: true)
class GoalDatasViewModel extends _$GoalDatasViewModel {
  // State : 특정 목표의 데이터 전체 목록 (Async)
  @override
  Future<List<GoalDatasEntity>?> build({required String goalId}) async {
    return ref.read(goalDatasRepositoryProvider).readDatas(goalId);
  }

  // [데이터 추가]
  Future<void> addData({
    required String goalId,
    required DateTime dataDate,
    required double dataValue,
  }) async {
    final newData = GoalDatasEntity(
      goalId: goalId,
      dataDate: dataDate,
      dataValue: dataValue,
    );

    // 낙관적 업데이트
    final current = state.value ?? [];
    state = AsyncData([newData, ...current]);

    // 서버 반영
    try {
      await ref.read(goalDatasRepositoryProvider).createData(newData);
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }

  // [데이터 (다중) 삭제]
  Future<void> deleteDatas(List<String> dataIds) async {
    // 낙관적 업데이트
    final current = state.value ?? [];
    state = AsyncData(current.where((n) => !dataIds.contains(n)).toList());

    // 서버 반영
    try {
      await ref.read(goalDatasRepositoryProvider).deleteDatas(dataIds);
      ref.invalidateSelf(); // 목록 다시 불러오기
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }
}
