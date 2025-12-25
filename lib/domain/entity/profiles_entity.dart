import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';

part 'profiles_entity.freezed.dart';

@freezed
abstract class ProfilesEntity with _$ProfilesEntity {
  const ProfilesEntity._(); // getter 사용 위해

  const factory ProfilesEntity({
    String? userId,
    String? nickname,
    String? photoUrl,
    GenderType? gender,
    double? heightCm,
    double? weightKg,
    int? birthYear,
  }) = _ProfilesEntity;

  // 나이 계산
  int? get age {
    if (birthYear == null) return null;
    return DateTime.now().year - birthYear!;
  }
}
