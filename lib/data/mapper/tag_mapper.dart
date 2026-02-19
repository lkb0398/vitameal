import 'package:vitameal/data/dto/tag_dto.dart';
import 'package:vitameal/domain/entity/tag_entity.dart';

extension TagDtoMapper on TagDto {
  /// DTO를 Domain Entity로 변환
  TagEntity toEntity() {
    return TagEntity(
      id: id,
      name: name,
      nameEn: nameEn, // 26.02.11 로컬라이제이션 위해 영문명 속성 추가
    );
  }
}
