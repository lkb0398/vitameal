import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'user_diseases_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserDiseasesViewModel extends _$UserDiseasesViewModel {
  // State : 사용자 질병 id 목록 (Async)
  @override
  Future<List<int>> build() async {
    return _loadState();
  }

  // [데이터 불러오기]
  Future<List<int>> _loadState() async {
    final userId = ref.watch(userIdProvider);
    return ref.read(diseasesRepositoryProvider).readUserDiseases(userId);
  }

  // [질병 목록 갱신]
  Future<void> saveDiseases(List<int> selectedIds) async {
    final userId = ref.watch(userIdProvider);

    // 낙관적 업데이트
    final current = state.value ?? [];
    state = AsyncData([...selectedIds]);

    // 서버 반영
    try {
      await ref
          .read(diseasesRepositoryProvider)
          .upsertUserDiseases(userId: userId, diseaseIds: selectedIds);
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }
}
