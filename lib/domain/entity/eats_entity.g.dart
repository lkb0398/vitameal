// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eats_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EatsEntity _$EatsEntityFromJson(Map<String, dynamic> json) => _EatsEntity(
  name: json['name'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  rating: (json['rating'] as num).toDouble(),
  distance: (json['distance'] as num).toDouble(),
  score: (json['score'] as num).toDouble(),
);

Map<String, dynamic> _$EatsEntityToJson(_EatsEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'rating': instance.rating,
      'distance': instance.distance,
      'score': instance.score,
    };
