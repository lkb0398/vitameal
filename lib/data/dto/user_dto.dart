import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  // 생성자를 factory로, 각 필드 정의
  const factory UserDto({
    @JsonKey(name: 'user_id') required String userId,
    String? nickname,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? gender,
    @JsonKey(name: 'height_cm') double? heightCm,
    @JsonKey(name: 'weight_kg') double? weightKg,
  }) = _UserDto;

  // JSON 직렬화 기능을 위한 factory 설정
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
