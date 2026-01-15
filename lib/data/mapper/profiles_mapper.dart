import 'package:vitameal/data/dto/profiles_dto.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';

class ProfilesMapper {
  // Entity > Dto
  static ProfilesDto toDto(ProfilesEntity entity) {
    return ProfilesDto(
      userId: entity.userId,
      nickname: entity.nickname,
      photoUrl: entity.photoUrl,
      gender: entity.genderType?.name,
      heightCm: entity.heightCm,
      weightKg: entity.weightKg,
      birthYear: entity.birthYear,
      onboardingCompleted: entity.onboardingCompleted,
    );
  }

  // Dto > Entity
  static ProfilesEntity toEntity(ProfilesDto dto) {
    return ProfilesEntity(
      userId: dto.userId,
      nickname: dto.nickname,
      photoUrl: dto.photoUrl,
      genderType: dto.gender != null
          ? GenderType.values.byName(dto.gender!)
          : null,
      heightCm: dto.heightCm?.toDouble(),
      weightKg: dto.weightKg?.toDouble(),
      birthYear: dto.birthYear,
      onboardingCompleted: dto.onboardingCompleted,
    );
  }
}
