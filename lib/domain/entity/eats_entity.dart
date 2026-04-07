import 'package:freezed_annotation/freezed_annotation.dart';

part 'eats_entity.freezed.dart';
part 'eats_entity.g.dart';

@freezed
abstract class EatsEntity with _$EatsEntity {
  const factory EatsEntity({
    required String name, // 음식점 이름
    required double lat, // 위도
    required double lng, // 경도
    required double rating, // 별점
    required double distance, // 거리
    required double score, // 건강 점수 (태그 적합도)
  }) = _EatsEntity;

  factory EatsEntity.fromJson(Map<String, dynamic> json) =>
      _$EatsEntityFromJson(json);
}
