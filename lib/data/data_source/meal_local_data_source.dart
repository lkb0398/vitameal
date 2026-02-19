import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:vitameal/core/util/date_time_utils.dart';
import 'package:vitameal/data/database/database.dart';
import 'package:vitameal/data/mapper/meal_day_mapper.dart';
import 'package:vitameal/data/mapper/meal_entry_mapper.dart';
import 'package:vitameal/domain/entity/meal_day_entity.dart';
import 'package:vitameal/domain/entity/meal_entry_entity.dart';
import 'package:vitameal/domain/enum/adherence_level_enum.dart';
import 'package:vitameal/domain/enum/meal_category_enum.dart';

abstract class MealLocalDataSource {
  /// 날짜 범위로 MealDay 목록 조회
  Future<List<MealDayEntity>> getMealDaysByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  });

  /// 특정 날짜의 MealDay 조회
  Future<MealDayEntity?> getMealDayByDate({
    required String userId,
    required DateTime date,
  });

  /// ID로 MealDay 조회
  Future<MealDayEntity?> getMealDayById(String mealDayId);

  /// MealDay Upsert
  Future<void> upsertMealDay(MealDayEntity entity);

  /// MealDay adherence 업데이트
  Future<void> updateMealDayAdherence({
    required String mealDayId,
    required AdherenceLevel adherence,
  });

  /// meal_entries 변경 후 MealDay AI 메타데이터 갱신
  Future<void> updateMealDayAiMeta(String mealDayId);

  /// AI 분석 완료 후 MealDay 메타데이터 갱신
  Future<void> updateMealDayMetaAfterAnalysis({
    required String mealDayId,
    required String summary,
  });

  /// MealEntry 목록 조회
  Future<List<MealEntryEntity>> getMealEntriesByMealDayId({
    required String mealDayId,
  });

  /// ID로 MealEntry 조회
  Future<MealEntryEntity?> getMealEntryById(String entryId);

  /// MealEntry 생성
  Future<void> createMealEntry(MealEntryEntity entity);

  /// MealEntry 수정
  Future<void> updateMealEntry({
    required String entryId,
    required MealCategory category,
    String? content,
    String? photoUrl,
    DateTime? eatenAt,
  });

  /// MealEntry 삭제 (Soft Delete)
  Future<void> deleteMealEntry(String entryId);
}

class MealLocalDataSourceImpl implements MealLocalDataSource {
  MealLocalDataSourceImpl(this._database);
  final AppDatabase _database;

  @override
  Future<List<MealDayEntity>> getMealDaysByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final dataList = await _database.mealDao.getMealDaysByDateRange(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );
      final entities = dataList.map((data) => data.toEntity()).toList();
      debugPrint(
        '🥕 MealDays 불러오기 [${startDate.logFormat} ~ ${startDate.logFormat}]',
      );
      debugPrint('🥕 MealDays 불러옴 [${entities.length}개]');
      return entities;
    } catch (e) {
      debugPrint('🥕 getMealDaysByDateRange: $e');
      throw Exception('getMealDaysByDateRange: $e');
    }
  }

  @override
  Future<MealDayEntity?> getMealDayByDate({
    required String userId,
    required DateTime date,
  }) async {
    try {
      final data = await _database.mealDao.getMealDayByDate(
        userId: userId,
        date: date,
      );
      final entity = data?.toEntity();
      if (entity != null) {
        debugPrint('🥕 MealDay 조회 [${entity.mealDate.logFormat}]');
      } else {
        debugPrint('🥕 MealDay가 없음');
      }
      return entity;
    } catch (e) {
      debugPrint('🥕 getMealDayByDate: $e');
      throw Exception('getMealDayByDate: $e');
    }
  }

  @override
  Future<MealDayEntity?> getMealDayById(String mealDayId) async {
    try {
      final data = await _database.mealDao.getMealDayById(mealDayId);
      final entity = data?.toEntity();
      if (entity != null) {
        debugPrint('🥕 MealDay 조회 [${mealDayId.substring(0, 8)}]');
      } else {
        debugPrint('🥕 MealDay가 없음 [${mealDayId.substring(0, 8)}]');
      }
      return entity;
    } catch (e) {
      debugPrint('🥕 getMealDayById: $e');
      throw Exception('getMealDayById: $e');
    }
  }

  @override
  Future<void> upsertMealDay(MealDayEntity entity) async {
    try {
      await _database.mealDao.upsertMealDay(entity.toCompanion());
      debugPrint(
        '🥕 MealDay 업서트 ${jsonEncode({'version': entity.dataVersion, 'needsAiRefresh': entity.needsAiRefresh})}',
      );
    } catch (e) {
      debugPrint('🥕 upsertMealDay: $e');
      throw Exception('upsertMealDay: $e');
    }
  }

  @override
  Future<void> updateMealDayAdherence({
    required String mealDayId,
    required AdherenceLevel adherence,
  }) async {
    try {
      await _database.mealDao.updateMealDayAdherence(
        mealDayId: mealDayId,
        adherence: adherence.value,
      );
      debugPrint('🥕 MealDay 성취도 자가평가 변경 [${adherence.value}]');
    } catch (e) {
      debugPrint('🥕 updateMealDayAdherence: $e');
      throw Exception('updateMealDayAdherence: $e');
    }
  }

  @override
  Future<void> updateMealDayAiMeta(String mealDayId) async {
    try {
      await _database.mealDao.updateMealDayAiMeta(mealDayId);
      debugPrint('🥕 meal_entries 변경 후 MealDay AI 메타데이터 갱신 [${mealDayId.substring(0, 8)}]');
    } catch (e) {
      debugPrint('🥕 updateMealDayAiMeta: $e');
      throw Exception('updateMealDayAiMeta: $e');
    }
  }

  @override
  Future<void> updateMealDayMetaAfterAnalysis({
    required String mealDayId,
    required String summary,
  }) async {
    try {
      await _database.mealDao.updateMealDayAiMetaAfterAnalysis(
        mealDayId: mealDayId,
        summary: summary,
      );
      debugPrint('🥕 AI 분석 후 MealDay 메타데이터 갱신 [${mealDayId.substring(0, 8)}]');
    } catch (e) {
      debugPrint('🥕 updateMealDayMetaAfterAnalysis: $e');
      throw Exception('updateMealDayMetaAfterAnalysis: $e');
    }
  }

  @override
  Future<List<MealEntryEntity>> getMealEntriesByMealDayId({
    required String mealDayId,
  }) async {
    try {
      final dataList = await _database.mealDao.getMealEntriesByMealDayId(
        mealDayId: mealDayId,
      );
      final entities = dataList.map((data) => data.toEntity()).toList();
      debugPrint(
        '🥕 MealEntries 불러옴 ${jsonEncode(entities.map((e) => {'category': e.category.value}).toList())}',
      );
      return entities;
    } catch (e) {
      debugPrint('🥕 getMealEntriesByMealDayId: $e');
      throw Exception('getMealEntriesByMealDayId: $e');
    }
  }

  @override
  Future<MealEntryEntity?> getMealEntryById(String entryId) async {
    try {
      final data = await _database.mealDao.getMealEntryById(entryId);
      final entity = data?.toEntity();
      if (entity != null) {
        debugPrint('🥕 MealEntry 조회 [${entryId.substring(0, 8)}]');
      } else {
        debugPrint('🥕 MealEntry가 없음 [${entryId.substring(0, 8)}]');
      }
      return entity;
    } catch (e) {
      debugPrint('🥕 getMealEntryById: $e');
      throw Exception('getMealEntryById: $e');
    }
  }

  @override
  Future<void> createMealEntry(MealEntryEntity entity) async {
    try {
      await _database.mealDao.insertMealEntry(entity.toCompanion());
      debugPrint('🥕 MealEntry 생성 [${entity.id.substring(0, 8)}]');
    } catch (e) {
      debugPrint('🥕 createMealEntry: $e');
      throw Exception('createMealEntry: $e');
    }
  }

  @override
  Future<void> updateMealEntry({
    required String entryId,
    required MealCategory category,
    String? content,
    String? photoUrl,
    DateTime? eatenAt,
  }) async {
    try {
      await _database.mealDao.updateMealEntry(
        entryId: entryId,
        category: category,
        content: content,
        photoUrl: photoUrl,
        eatenAt: eatenAt,
      );
      debugPrint('🥕 MealEntry 수정 [${entryId.substring(0, 8)}]');
    } catch (e) {
      debugPrint('🥕 updateMealEntry: $e');
      throw Exception('updateMealEntry: $e');
    }
  }

  @override
  Future<void> deleteMealEntry(String entryId) async {
    try {
      await _database.mealDao.deleteMealEntry(entryId);
      debugPrint('🥕 MealEntry 삭제 [${entryId.substring(0, 8)}]');
    } catch (e) {
      debugPrint('🥕 deleteMealEntry: $e');
      throw Exception('deleteMealEntry: $e');
    }
  }
}
