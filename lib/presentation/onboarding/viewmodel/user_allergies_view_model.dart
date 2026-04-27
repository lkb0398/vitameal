import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'user_allergies_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserAllergiesViewModel extends _$UserAllergiesViewModel {
  // State : 사용자 알레르기 id 목록 (Async)
  @override
  Future<List<int>> build() async {
    return _loadState();
  }

  // [데이터 불러오기]
  Future<List<int>> _loadState() async {
    final userId = ref.read(userIdProvider);
    return ref.read(allergiesRepositoryProvider).readUserAllergies(userId);
  }

  // [알레르기 목록 갱신]
  Future<void> saveAllergies(List<int> selectedIds) async {
    final userId = ref.read(userIdProvider);

    // 낙관적 업데이트
    final current = state.value ?? [];
    state = AsyncData([...selectedIds]);

    // 서버 반영
    try {
      await ref
          .read(allergiesRepositoryProvider)
          .upsertUserAllergies(userId: userId, allergyIds: selectedIds);
      ref.invalidateSelf(); // 갱신
    } catch (e) {
      state = AsyncData(current); // 롤백
    }
  }
}
