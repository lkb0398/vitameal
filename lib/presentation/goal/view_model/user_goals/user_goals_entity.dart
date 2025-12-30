import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_goals_entity.freezed.dart';

@freezed
abstract class UserGoalsEntity with _$UserGoalsEntity {
  const factory UserGoalsEntity({
    String? userId,
    required String goalTitle, // 목표명
    required String goalUnit, // 목표 단위
    required double goalValue, // 목표 수치
    required DateTime goalDate, // 목표 날짜
    required bool isDone, // 달성 여부
    bool? isMain, // 대표설정 여부
  }) = _UserGoalsEntity;
}
