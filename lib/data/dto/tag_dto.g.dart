// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TagDto _$TagDtoFromJson(Map<String, dynamic> json) => _TagDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  nameEn: json['name_en'] as String,
);

Map<String, dynamic> _$TagDtoToJson(_TagDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'name_en': instance.nameEn,
};
