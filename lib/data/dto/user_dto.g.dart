// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  userId: json['user_id'] as String,
  nickname: json['nickname'] as String?,
  photoUrl: json['photo_url'] as String?,
  gender: json['gender'] as String?,
  heightCm: (json['height_cm'] as num?)?.toDouble(),
  weightKg: (json['weight_kg'] as num?)?.toDouble(),
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'user_id': instance.userId,
  'nickname': instance.nickname,
  'photo_url': instance.photoUrl,
  'gender': instance.gender,
  'height_cm': instance.heightCm,
  'weight_kg': instance.weightKg,
};
