import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    @JsonKey(name: 'user_id') required String userId,
    String? nickname,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? gender,
    @JsonKey(name: 'height_cm') double? heightCm,
    @JsonKey(name: 'weight_kg') double? weightKg,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
