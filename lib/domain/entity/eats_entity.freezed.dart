// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eats_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EatsEntity {

 String get name;// 음식점 이름
 double get lat;// 위도
 double get lng;// 경도
 double get rating;// 별점
 double get distance;// 거리
 double get score;
/// Create a copy of EatsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EatsEntityCopyWith<EatsEntity> get copyWith => _$EatsEntityCopyWithImpl<EatsEntity>(this as EatsEntity, _$identity);

  /// Serializes this EatsEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EatsEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,lat,lng,rating,distance,score);

@override
String toString() {
  return 'EatsEntity(name: $name, lat: $lat, lng: $lng, rating: $rating, distance: $distance, score: $score)';
}


}

/// @nodoc
abstract mixin class $EatsEntityCopyWith<$Res>  {
  factory $EatsEntityCopyWith(EatsEntity value, $Res Function(EatsEntity) _then) = _$EatsEntityCopyWithImpl;
@useResult
$Res call({
 String name, double lat, double lng, double rating, double distance, double score
});




}
/// @nodoc
class _$EatsEntityCopyWithImpl<$Res>
    implements $EatsEntityCopyWith<$Res> {
  _$EatsEntityCopyWithImpl(this._self, this._then);

  final EatsEntity _self;
  final $Res Function(EatsEntity) _then;

/// Create a copy of EatsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? lat = null,Object? lng = null,Object? rating = null,Object? distance = null,Object? score = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EatsEntity].
extension EatsEntityPatterns on EatsEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EatsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EatsEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EatsEntity value)  $default,){
final _that = this;
switch (_that) {
case _EatsEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EatsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _EatsEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double lat,  double lng,  double rating,  double distance,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EatsEntity() when $default != null:
return $default(_that.name,_that.lat,_that.lng,_that.rating,_that.distance,_that.score);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double lat,  double lng,  double rating,  double distance,  double score)  $default,) {final _that = this;
switch (_that) {
case _EatsEntity():
return $default(_that.name,_that.lat,_that.lng,_that.rating,_that.distance,_that.score);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double lat,  double lng,  double rating,  double distance,  double score)?  $default,) {final _that = this;
switch (_that) {
case _EatsEntity() when $default != null:
return $default(_that.name,_that.lat,_that.lng,_that.rating,_that.distance,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EatsEntity implements EatsEntity {
  const _EatsEntity({required this.name, required this.lat, required this.lng, required this.rating, required this.distance, required this.score});
  factory _EatsEntity.fromJson(Map<String, dynamic> json) => _$EatsEntityFromJson(json);

@override final  String name;
// 음식점 이름
@override final  double lat;
// 위도
@override final  double lng;
// 경도
@override final  double rating;
// 별점
@override final  double distance;
// 거리
@override final  double score;

/// Create a copy of EatsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EatsEntityCopyWith<_EatsEntity> get copyWith => __$EatsEntityCopyWithImpl<_EatsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EatsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EatsEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,lat,lng,rating,distance,score);

@override
String toString() {
  return 'EatsEntity(name: $name, lat: $lat, lng: $lng, rating: $rating, distance: $distance, score: $score)';
}


}

/// @nodoc
abstract mixin class _$EatsEntityCopyWith<$Res> implements $EatsEntityCopyWith<$Res> {
  factory _$EatsEntityCopyWith(_EatsEntity value, $Res Function(_EatsEntity) _then) = __$EatsEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, double lat, double lng, double rating, double distance, double score
});




}
/// @nodoc
class __$EatsEntityCopyWithImpl<$Res>
    implements _$EatsEntityCopyWith<$Res> {
  __$EatsEntityCopyWithImpl(this._self, this._then);

  final _EatsEntity _self;
  final $Res Function(_EatsEntity) _then;

/// Create a copy of EatsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? lat = null,Object? lng = null,Object? rating = null,Object? distance = null,Object? score = null,}) {
  return _then(_EatsEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
