// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarms_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlarmsEntity {

 String? get userId; String? get alarmId; String get label; TimeOfDay get time; bool get isEnabled;
/// Create a copy of AlarmsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmsEntityCopyWith<AlarmsEntity> get copyWith => _$AlarmsEntityCopyWithImpl<AlarmsEntity>(this as AlarmsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmsEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.alarmId, alarmId) || other.alarmId == alarmId)&&(identical(other.label, label) || other.label == label)&&(identical(other.time, time) || other.time == time)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,userId,alarmId,label,time,isEnabled);

@override
String toString() {
  return 'AlarmsEntity(userId: $userId, alarmId: $alarmId, label: $label, time: $time, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class $AlarmsEntityCopyWith<$Res>  {
  factory $AlarmsEntityCopyWith(AlarmsEntity value, $Res Function(AlarmsEntity) _then) = _$AlarmsEntityCopyWithImpl;
@useResult
$Res call({
 String? userId, String? alarmId, String label, TimeOfDay time, bool isEnabled
});




}
/// @nodoc
class _$AlarmsEntityCopyWithImpl<$Res>
    implements $AlarmsEntityCopyWith<$Res> {
  _$AlarmsEntityCopyWithImpl(this._self, this._then);

  final AlarmsEntity _self;
  final $Res Function(AlarmsEntity) _then;

/// Create a copy of AlarmsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? alarmId = freezed,Object? label = null,Object? time = null,Object? isEnabled = null,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,alarmId: freezed == alarmId ? _self.alarmId : alarmId // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeOfDay,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmsEntity].
extension AlarmsEntityPatterns on AlarmsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmsEntity value)  $default,){
final _that = this;
switch (_that) {
case _AlarmsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userId,  String? alarmId,  String label,  TimeOfDay time,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmsEntity() when $default != null:
return $default(_that.userId,_that.alarmId,_that.label,_that.time,_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userId,  String? alarmId,  String label,  TimeOfDay time,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _AlarmsEntity():
return $default(_that.userId,_that.alarmId,_that.label,_that.time,_that.isEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userId,  String? alarmId,  String label,  TimeOfDay time,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _AlarmsEntity() when $default != null:
return $default(_that.userId,_that.alarmId,_that.label,_that.time,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _AlarmsEntity implements AlarmsEntity {
  const _AlarmsEntity({this.userId, this.alarmId, required this.label, required this.time, required this.isEnabled});
  

@override final  String? userId;
@override final  String? alarmId;
@override final  String label;
@override final  TimeOfDay time;
@override final  bool isEnabled;

/// Create a copy of AlarmsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmsEntityCopyWith<_AlarmsEntity> get copyWith => __$AlarmsEntityCopyWithImpl<_AlarmsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmsEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.alarmId, alarmId) || other.alarmId == alarmId)&&(identical(other.label, label) || other.label == label)&&(identical(other.time, time) || other.time == time)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,userId,alarmId,label,time,isEnabled);

@override
String toString() {
  return 'AlarmsEntity(userId: $userId, alarmId: $alarmId, label: $label, time: $time, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$AlarmsEntityCopyWith<$Res> implements $AlarmsEntityCopyWith<$Res> {
  factory _$AlarmsEntityCopyWith(_AlarmsEntity value, $Res Function(_AlarmsEntity) _then) = __$AlarmsEntityCopyWithImpl;
@override @useResult
$Res call({
 String? userId, String? alarmId, String label, TimeOfDay time, bool isEnabled
});




}
/// @nodoc
class __$AlarmsEntityCopyWithImpl<$Res>
    implements _$AlarmsEntityCopyWith<$Res> {
  __$AlarmsEntityCopyWithImpl(this._self, this._then);

  final _AlarmsEntity _self;
  final $Res Function(_AlarmsEntity) _then;

/// Create a copy of AlarmsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? alarmId = freezed,Object? label = null,Object? time = null,Object? isEnabled = null,}) {
  return _then(_AlarmsEntity(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,alarmId: freezed == alarmId ? _self.alarmId : alarmId // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeOfDay,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
