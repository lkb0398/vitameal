import 'package:vitameal/domain/entity/meal_day_entity.dart';
import 'package:vitameal/domain/entity/meal_entry_entity.dart';
import 'package:vitameal/domain/enum/adherence_level_enum.dart';
import 'package:vitameal/domain/enum/meal_category_enum.dart';

abstract class MealRepository {
  /// 날짜 범위로 MealDay 목록 조회
  Future<List<MealDayEntity>> getMealDaysByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  });

  /// 날짜 범위로 MealDay 스트림 구독
  Stream<List<MealDayEntity>> watchMealDaysByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  });

  /// 특정 날짜의 MealDay 조회
  Future<MealDayEntity?> getMealDayByDate({
    required String userId,
    required DateTime date,
  });

  /// 특정 날짜의 MealDay 조회 (없으면 자동 생성)
  Future<MealDayEntity> getOrCreateMealDay({
    required String userId,
    required DateTime date,
  });

  /// MealDay의 adherence 업데이트
  Future<MealDayEntity> updateMealDayAdherence({
    required String mealDayId,
    required AdherenceLevel adherence,
  });

  /// AI 분석 완료 후 MealDay 메타데이터 갱신
  Future<void> updateMealDayAfterAnalysis({
    required String mealDayId,
    required String summary,
  });

  /// MealDay의 MealEntry 목록 조회
  Future<List<MealEntryEntity>> getMealEntriesByMealDayId({
    required String mealDayId,
  });

  /// MealEntry 생성
  Future<MealEntryEntity> createMealEntry({
    required String mealDayId,
    required MealCategory category,
    String? content,
    String? photoUrl,
    DateTime? eatenAt,
  });

  /// MealEntry 수정
  Future<MealEntryEntity> updateMealEntry({
    required String entryId,
    required MealCategory category,
    String? content,
    String? photoUrl,
    DateTime? eatenAt,
  });

  /// MealEntry 삭제
  Future<void> deleteMealEntry({required String entryId});
}
