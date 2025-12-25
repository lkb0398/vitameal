// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_diseases_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDiseasesDto _$UserDiseasesDtoFromJson(Map<String, dynamic> json) =>
    _UserDiseasesDto(
      userId: json['user_id'] as String,
      diseaseId: (json['disease_id'] as num).toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$UserDiseasesDtoToJson(_UserDiseasesDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'disease_id': instance.diseaseId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
