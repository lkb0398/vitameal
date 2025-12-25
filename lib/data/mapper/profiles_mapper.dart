import 'package:vitameal/data/dto/profiles_dto.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';

class ProfilesMapper {
  /// Entity > DTO (업데이트/업서트용)
  static ProfilesDto toDto(ProfilesEntity entity) {
    return ProfilesDto(
      userId: entity.userId!,
      nickname: entity.nickname,
      photoUrl: entity.photoUrl,
      gender: entity.gender?.name,
      heightCm: entity.heightCm,
      weightKg: entity.weightKg,
      birthYear: entity.birthYear,
    );
  }

  /// DTO > Entity (조회 용)
  static ProfilesEntity toEntity(ProfilesDto dto) {
    return ProfilesEntity(
      userId: dto.userId,
      nickname: dto.nickname,
      photoUrl: dto.photoUrl,
      gender: dto.gender != null ? GenderType.values.byName(dto.gender!) : null,
      heightCm: dto.heightCm?.toDouble(),
      weightKg: dto.weightKg?.toDouble(),
      birthYear: dto.birthYear,
    );
  }
}
