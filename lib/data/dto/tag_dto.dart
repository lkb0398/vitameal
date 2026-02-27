import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_dto.freezed.dart';
part 'tag_dto.g.dart';

@freezed
abstract class TagDto with _$TagDto {
  const factory TagDto({
    required int id,
    required String name,
    @JsonKey(name: 'name_en')
    required String nameEn, // 26.02.11 로컬라이제이션 위해 영문명 속성 추가
  }) = _TagDto;

  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);
}
