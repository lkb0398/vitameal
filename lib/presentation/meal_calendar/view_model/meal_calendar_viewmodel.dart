import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/core/util/date_time_utils.dart';
import 'package:vitameal/domain/entity/meal_day_entity.dart';
import 'package:vitameal/domain/entity/meal_entry_entity.dart';
import 'package:vitameal/domain/enum/adherence_level_enum.dart';
import 'package:vitameal/domain/repository/meal_repository.dart';

part 'meal_calendar_viewmodel.g.dart';

/// 선택된 날짜의 MealEntry 목록을 조회하는 프로바이더
/// TODO : 나중에 state 클래스로 관리하도록 리펙토링
@riverpod
Future<List<MealEntryEntity>> mealEntries(Ref ref, String mealDayId) async {
  final repository = ref.read(mealRepositoryProvider);
  return await repository.getMealEntriesByMealDayId(mealDayId: mealDayId);
}

@riverpod
class MealCalendarViewModel extends _$MealCalendarViewModel {
  MealRepository get _repository => ref.read(mealRepositoryProvider);

  /// MealDays 불러오기
  @override
  Future<List<MealDayEntity>> build(String userId, DateTime startDate, DateTime endDate) async {
    return await _repository.getMealDaysByDateRange(userId: userId, startDate: startDate, endDate: endDate);
  }

  /// 날짜 범위 변경 시 MealDays 불러오기
  Future<void> changeDateRange(DateTime newStartDate, DateTime newEndDate) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getMealDaysByDateRange(userId: userId, startDate: newStartDate, endDate: newEndDate);
    });
  }

  /// 새로고침
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getMealDaysByDateRange(userId: userId, startDate: startDate, endDate: endDate);
    });
  }

  /// 특정 날짜의 MealDay 조회 (VM의 캐시된 목록에서 찾기)
  MealDayEntity? getMealDayByDate(DateTime date) {
    return state.maybeWhen(
      data: (mealDays) => mealDays.firstWhereOrNull((mealDay) => isSameDate(mealDay.mealDate, date)),
      orElse: () => null,
    );
  }

  /// MealDay의 Adherence 업데이트
  Future<void> updateAdherence({required String mealDayId, required AdherenceLevel adherence}) async {
    // 로컬 db로 업데이트
    await _repository.updateMealDayAdherence(mealDayId: mealDayId, adherence: adherence);

    // state 업데이트 (UI 즉시 반영)
    state = state.whenData((mealDays) {
      return mealDays.map((mealDay) {
        if (mealDay.id == mealDayId) {
          return mealDay.copyWith(adherence: adherence);
        }
        return mealDay;
      }).toList();
    });
  }
}
