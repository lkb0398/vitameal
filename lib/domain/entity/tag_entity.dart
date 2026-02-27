import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_entity.freezed.dart';

@freezed
abstract class TagEntity with _$TagEntity {
  const factory TagEntity({
    required int id,
    required String name,
    required String nameEn, // 26.02.11 로컬라이제이션 위해 영문명 속성 추가
  }) = _TagEntity;
}
