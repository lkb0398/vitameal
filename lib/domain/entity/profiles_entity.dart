import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';

part 'profiles_entity.freezed.dart';

@freezed
abstract class ProfilesEntity with _$ProfilesEntity {
  const ProfilesEntity._(); // getter 사용 위해

  const factory ProfilesEntity({
    required String userId,
    String? nickname,
    String? photoUrl,
    GenderType? genderType,
    double? heightCm,
    double? weightKg,
    int? birthYear,
    bool? onboardingCompleted,
  }) = _ProfilesEntity;

  // 나이 계산
  int? get age {
    if (birthYear == null) return null;
    return DateTime.now().year - birthYear!;
  }

  // 성별 String 변환
  String? gender(Locale locale) {
    if (genderType == null) return null;

    if (locale.languageCode == 'en') {
      if (genderType == GenderType.male) return "Male";
      if (genderType == GenderType.female) return "Female";
    } else {
      if (genderType == GenderType.male) return "남성";
      if (genderType == GenderType.female) return "여성";
    }

    return null;
  }
}
