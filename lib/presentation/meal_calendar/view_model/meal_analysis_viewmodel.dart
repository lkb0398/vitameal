import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/meal_analysis_entity.dart';
import 'package:vitameal/domain/repository/meal_analysis_repository.dart';

part 'meal_analysis_viewmodel.g.dart';

@riverpod
class MealAnalysisViewModel extends _$MealAnalysisViewModel {
  MealAnalysisRepository get _repository => ref.read(mealAnalysisRepositoryProvider);

  /// 상태는 Hook으로 관리
  @override
  void build() {}

  /// AI 분석 요청
  Future<MealAnalysisEntity> requestAnalysis(String mealDayId) async {
    return await _repository.requestAnalysis(mealDayId);
  }

  /// 특정 MealDay의 최신 분석 결과 조회
  Future<MealAnalysisEntity?> getLatestAnalysis(String mealDayId) async {
    return await _repository.getLatestAnalysis(mealDayId);
  }
}
