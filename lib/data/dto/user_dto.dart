import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
  // 생성자를 factory로, 각 필드 정의
>>>>>>> 005c1d3 (feat: 로그인 리팩토링 & 주석 추가 및 수정)
=======
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)
>>>>>>> d24068e (feat: UI를 제외한 기능구현 및 리팩토링 완료)
  const factory UserDto({
    @JsonKey(name: 'user_id') required String userId,
    String? nickname,
    @JsonKey(name: 'photo_url') String? photoUrl,
    String? gender,
    @JsonKey(name: 'height_cm') double? heightCm,
    @JsonKey(name: 'weight_kg') double? weightKg,
  }) = _UserDto;

<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
  // JSON 직렬화 기능을 위한 factory 설정
>>>>>>> 005c1d3 (feat: 로그인 리팩토링 & 주석 추가 및 수정)
=======
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)
>>>>>>> d24068e (feat: UI를 제외한 기능구현 및 리팩토링 완료)
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
