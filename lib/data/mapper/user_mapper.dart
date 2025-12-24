import '../../domain/entity/user_entity.dart';
import '../dto/user_dto.dart';

extension UserMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      uid: userId,
      nickname: nickname,
      photoUrl: photoUrl,
      gender: gender,
      height: heightCm,
      weight: weightKg,
    );
  }
}
