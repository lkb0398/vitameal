// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profiles_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfilesEntity {

 String? get userId; String? get nickname; String? get photoUrl; GenderType? get gender; double? get heightCm; double? get weightKg; int? get birthYear;
/// Create a copy of ProfilesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilesEntityCopyWith<ProfilesEntity> get copyWith => _$ProfilesEntityCopyWithImpl<ProfilesEntity>(this as ProfilesEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilesEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.birthYear, birthYear) || other.birthYear == birthYear));
}


@override
int get hashCode => Object.hash(runtimeType,userId,nickname,photoUrl,gender,heightCm,weightKg,birthYear);

@override
String toString() {
  return 'ProfilesEntity(userId: $userId, nickname: $nickname, photoUrl: $photoUrl, gender: $gender, heightCm: $heightCm, weightKg: $weightKg, birthYear: $birthYear)';
}


}

/// @nodoc
abstract mixin class $ProfilesEntityCopyWith<$Res>  {
  factory $ProfilesEntityCopyWith(ProfilesEntity value, $Res Function(ProfilesEntity) _then) = _$ProfilesEntityCopyWithImpl;
@useResult
$Res call({
 String? userId, String? nickname, String? photoUrl, GenderType? gender, double? heightCm, double? weightKg, int? birthYear
});




}
/// @nodoc
class _$ProfilesEntityCopyWithImpl<$Res>
    implements $ProfilesEntityCopyWith<$Res> {
  _$ProfilesEntityCopyWithImpl(this._self, this._then);

  final ProfilesEntity _self;
  final $Res Function(ProfilesEntity) _then;

/// Create a copy of ProfilesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? nickname = freezed,Object? photoUrl = freezed,Object? gender = freezed,Object? heightCm = freezed,Object? weightKg = freezed,Object? birthYear = freezed,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderType?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,birthYear: freezed == birthYear ? _self.birthYear : birthYear // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfilesEntity].
extension ProfilesEntityPatterns on ProfilesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfilesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfilesEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfilesEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProfilesEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfilesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProfilesEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userId,  String? nickname,  String? photoUrl,  GenderType? gender,  double? heightCm,  double? weightKg,  int? birthYear)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfilesEntity() when $default != null:
return $default(_that.userId,_that.nickname,_that.photoUrl,_that.gender,_that.heightCm,_that.weightKg,_that.birthYear);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userId,  String? nickname,  String? photoUrl,  GenderType? gender,  double? heightCm,  double? weightKg,  int? birthYear)  $default,) {final _that = this;
switch (_that) {
case _ProfilesEntity():
return $default(_that.userId,_that.nickname,_that.photoUrl,_that.gender,_that.heightCm,_that.weightKg,_that.birthYear);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userId,  String? nickname,  String? photoUrl,  GenderType? gender,  double? heightCm,  double? weightKg,  int? birthYear)?  $default,) {final _that = this;
switch (_that) {
case _ProfilesEntity() when $default != null:
return $default(_that.userId,_that.nickname,_that.photoUrl,_that.gender,_that.heightCm,_that.weightKg,_that.birthYear);case _:
  return null;

}
}

}

/// @nodoc


class _ProfilesEntity extends ProfilesEntity {
  const _ProfilesEntity({this.userId, this.nickname, this.photoUrl, this.gender, this.heightCm, this.weightKg, this.birthYear}): super._();
  

@override final  String? userId;
@override final  String? nickname;
@override final  String? photoUrl;
@override final  GenderType? gender;
@override final  double? heightCm;
@override final  double? weightKg;
@override final  int? birthYear;

/// Create a copy of ProfilesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfilesEntityCopyWith<_ProfilesEntity> get copyWith => __$ProfilesEntityCopyWithImpl<_ProfilesEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfilesEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.birthYear, birthYear) || other.birthYear == birthYear));
}


@override
int get hashCode => Object.hash(runtimeType,userId,nickname,photoUrl,gender,heightCm,weightKg,birthYear);

@override
String toString() {
  return 'ProfilesEntity(userId: $userId, nickname: $nickname, photoUrl: $photoUrl, gender: $gender, heightCm: $heightCm, weightKg: $weightKg, birthYear: $birthYear)';
}


}

/// @nodoc
abstract mixin class _$ProfilesEntityCopyWith<$Res> implements $ProfilesEntityCopyWith<$Res> {
  factory _$ProfilesEntityCopyWith(_ProfilesEntity value, $Res Function(_ProfilesEntity) _then) = __$ProfilesEntityCopyWithImpl;
@override @useResult
$Res call({
 String? userId, String? nickname, String? photoUrl, GenderType? gender, double? heightCm, double? weightKg, int? birthYear
});




}
/// @nodoc
class __$ProfilesEntityCopyWithImpl<$Res>
    implements _$ProfilesEntityCopyWith<$Res> {
  __$ProfilesEntityCopyWithImpl(this._self, this._then);

  final _ProfilesEntity _self;
  final $Res Function(_ProfilesEntity) _then;

/// Create a copy of ProfilesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? nickname = freezed,Object? photoUrl = freezed,Object? gender = freezed,Object? heightCm = freezed,Object? weightKg = freezed,Object? birthYear = freezed,}) {
  return _then(_ProfilesEntity(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderType?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,birthYear: freezed == birthYear ? _self.birthYear : birthYear // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
