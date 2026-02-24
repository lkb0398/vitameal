import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/core/util/date_time_utils.dart';
import 'package:vitameal/domain/entity/meal_day_entity.dart';
import 'package:vitameal/domain/enum/adherence_level_enum.dart';
import 'package:vitameal/domain/repository/meal_repository.dart';

part 'meal_calendar_viewmodel.g.dart';

@riverpod
class MealCalendarViewModel extends _$MealCalendarViewModel {
  MealRepository get _repository => ref.read(mealRepositoryProvider);

  /// MealDays 불러오기
  @override
  Stream<List<MealDayEntity>> build(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) {
    return _repository.watchMealDaysByDateRange(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// 특정 날짜의 MealDay 조회 (vm의 state 이용)
  MealDayEntity? getMealDayByDate(DateTime date) {
    return state.maybeWhen(
      data: (mealDays) => mealDays.firstWhereOrNull(
        (mealDay) => isSameDate(mealDay.mealDate, date),
      ),
      orElse: () => null,
    );
  }

  /// MealDay의 Adherence 업데이트
  Future<void> updateAdherence({
    required String mealDayId,
    required AdherenceLevel adherence,
  }) async {
    // 로컬 db로 업데이트
    await _repository.updateMealDayAdherence(
      mealDayId: mealDayId,
      adherence: adherence,
    );

    // 위젯 갱신
    final widgetService = ref.read(widgetServiceProvider); // TODO : 리팩토링
    widgetService.updateWidgetData(userId);
  }
}
