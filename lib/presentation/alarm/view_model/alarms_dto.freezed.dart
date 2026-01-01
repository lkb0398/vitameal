// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarms_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlarmsDto {

@JsonKey(name: 'user_id') String? get userId;@JsonKey(name: 'alarm_id') String? get alarmId; String get label; String get time;@JsonKey(name: 'is_enabled') bool get isEnabled;
/// Create a copy of AlarmsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmsDtoCopyWith<AlarmsDto> get copyWith => _$AlarmsDtoCopyWithImpl<AlarmsDto>(this as AlarmsDto, _$identity);

  /// Serializes this AlarmsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmsDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.alarmId, alarmId) || other.alarmId == alarmId)&&(identical(other.label, label) || other.label == label)&&(identical(other.time, time) || other.time == time)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,alarmId,label,time,isEnabled);

@override
String toString() {
  return 'AlarmsDto(userId: $userId, alarmId: $alarmId, label: $label, time: $time, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class $AlarmsDtoCopyWith<$Res>  {
  factory $AlarmsDtoCopyWith(AlarmsDto value, $Res Function(AlarmsDto) _then) = _$AlarmsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'alarm_id') String? alarmId, String label, String time,@JsonKey(name: 'is_enabled') bool isEnabled
});




}
/// @nodoc
class _$AlarmsDtoCopyWithImpl<$Res>
    implements $AlarmsDtoCopyWith<$Res> {
  _$AlarmsDtoCopyWithImpl(this._self, this._then);

  final AlarmsDto _self;
  final $Res Function(AlarmsDto) _then;

/// Create a copy of AlarmsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? alarmId = freezed,Object? label = null,Object? time = null,Object? isEnabled = null,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,alarmId: freezed == alarmId ? _self.alarmId : alarmId // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmsDto].
extension AlarmsDtoPatterns on AlarmsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmsDto value)  $default,){
final _that = this;
switch (_that) {
case _AlarmsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmsDto value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'alarm_id')  String? alarmId,  String label,  String time, @JsonKey(name: 'is_enabled')  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmsDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'alarm_id')  String? alarmId,  String label,  String time, @JsonKey(name: 'is_enabled')  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _AlarmsDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'alarm_id')  String? alarmId,  String label,  String time, @JsonKey(name: 'is_enabled')  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _AlarmsDto() when $default != null:
return $default(_that.userId,_that.alarmId,_that.label,_that.time,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlarmsDto implements AlarmsDto {
  const _AlarmsDto({@JsonKey(name: 'user_id') this.userId, @JsonKey(name: 'alarm_id') this.alarmId, required this.label, required this.time, @JsonKey(name: 'is_enabled') required this.isEnabled});
  factory _AlarmsDto.fromJson(Map<String, dynamic> json) => _$AlarmsDtoFromJson(json);

@override@JsonKey(name: 'user_id') final  String? userId;
@override@JsonKey(name: 'alarm_id') final  String? alarmId;
@override final  String label;
@override final  String time;
@override@JsonKey(name: 'is_enabled') final  bool isEnabled;

/// Create a copy of AlarmsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmsDtoCopyWith<_AlarmsDto> get copyWith => __$AlarmsDtoCopyWithImpl<_AlarmsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlarmsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmsDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.alarmId, alarmId) || other.alarmId == alarmId)&&(identical(other.label, label) || other.label == label)&&(identical(other.time, time) || other.time == time)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,alarmId,label,time,isEnabled);

@override
String toString() {
  return 'AlarmsDto(userId: $userId, alarmId: $alarmId, label: $label, time: $time, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$AlarmsDtoCopyWith<$Res> implements $AlarmsDtoCopyWith<$Res> {
  factory _$AlarmsDtoCopyWith(_AlarmsDto value, $Res Function(_AlarmsDto) _then) = __$AlarmsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'alarm_id') String? alarmId, String label, String time,@JsonKey(name: 'is_enabled') bool isEnabled
});




}
/// @nodoc
class __$AlarmsDtoCopyWithImpl<$Res>
    implements _$AlarmsDtoCopyWith<$Res> {
  __$AlarmsDtoCopyWithImpl(this._self, this._then);

  final _AlarmsDto _self;
  final $Res Function(_AlarmsDto) _then;

/// Create a copy of AlarmsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? alarmId = freezed,Object? label = null,Object? time = null,Object? isEnabled = null,}) {
  return _then(_AlarmsDto(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,alarmId: freezed == alarmId ? _self.alarmId : alarmId // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
