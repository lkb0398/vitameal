// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_datas_save_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalDatasSaveDto {

@JsonKey(name: 'goal_id') String? get goalId;@JsonKey(name: 'data_date') DateTime get dataDate;@JsonKey(name: 'data_value') double get dataValue;
/// Create a copy of GoalDatasSaveDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalDatasSaveDtoCopyWith<GoalDatasSaveDto> get copyWith => _$GoalDatasSaveDtoCopyWithImpl<GoalDatasSaveDto>(this as GoalDatasSaveDto, _$identity);

  /// Serializes this GoalDatasSaveDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalDatasSaveDto&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.dataDate, dataDate) || other.dataDate == dataDate)&&(identical(other.dataValue, dataValue) || other.dataValue == dataValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,goalId,dataDate,dataValue);

@override
String toString() {
  return 'GoalDatasSaveDto(goalId: $goalId, dataDate: $dataDate, dataValue: $dataValue)';
}


}

/// @nodoc
abstract mixin class $GoalDatasSaveDtoCopyWith<$Res>  {
  factory $GoalDatasSaveDtoCopyWith(GoalDatasSaveDto value, $Res Function(GoalDatasSaveDto) _then) = _$GoalDatasSaveDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'goal_id') String? goalId,@JsonKey(name: 'data_date') DateTime dataDate,@JsonKey(name: 'data_value') double dataValue
});




}
/// @nodoc
class _$GoalDatasSaveDtoCopyWithImpl<$Res>
    implements $GoalDatasSaveDtoCopyWith<$Res> {
  _$GoalDatasSaveDtoCopyWithImpl(this._self, this._then);

  final GoalDatasSaveDto _self;
  final $Res Function(GoalDatasSaveDto) _then;

/// Create a copy of GoalDatasSaveDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? goalId = freezed,Object? dataDate = null,Object? dataValue = null,}) {
  return _then(_self.copyWith(
goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,dataDate: null == dataDate ? _self.dataDate : dataDate // ignore: cast_nullable_to_non_nullable
as DateTime,dataValue: null == dataValue ? _self.dataValue : dataValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalDatasSaveDto].
extension GoalDatasSaveDtoPatterns on GoalDatasSaveDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalDatasSaveDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalDatasSaveDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalDatasSaveDto value)  $default,){
final _that = this;
switch (_that) {
case _GoalDatasSaveDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalDatasSaveDto value)?  $default,){
final _that = this;
switch (_that) {
case _GoalDatasSaveDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'goal_id')  String? goalId, @JsonKey(name: 'data_date')  DateTime dataDate, @JsonKey(name: 'data_value')  double dataValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalDatasSaveDto() when $default != null:
return $default(_that.goalId,_that.dataDate,_that.dataValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'goal_id')  String? goalId, @JsonKey(name: 'data_date')  DateTime dataDate, @JsonKey(name: 'data_value')  double dataValue)  $default,) {final _that = this;
switch (_that) {
case _GoalDatasSaveDto():
return $default(_that.goalId,_that.dataDate,_that.dataValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'goal_id')  String? goalId, @JsonKey(name: 'data_date')  DateTime dataDate, @JsonKey(name: 'data_value')  double dataValue)?  $default,) {final _that = this;
switch (_that) {
case _GoalDatasSaveDto() when $default != null:
return $default(_that.goalId,_that.dataDate,_that.dataValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalDatasSaveDto implements GoalDatasSaveDto {
  const _GoalDatasSaveDto({@JsonKey(name: 'goal_id') this.goalId, @JsonKey(name: 'data_date') required this.dataDate, @JsonKey(name: 'data_value') required this.dataValue});
  factory _GoalDatasSaveDto.fromJson(Map<String, dynamic> json) => _$GoalDatasSaveDtoFromJson(json);

@override@JsonKey(name: 'goal_id') final  String? goalId;
@override@JsonKey(name: 'data_date') final  DateTime dataDate;
@override@JsonKey(name: 'data_value') final  double dataValue;

/// Create a copy of GoalDatasSaveDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalDatasSaveDtoCopyWith<_GoalDatasSaveDto> get copyWith => __$GoalDatasSaveDtoCopyWithImpl<_GoalDatasSaveDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalDatasSaveDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalDatasSaveDto&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.dataDate, dataDate) || other.dataDate == dataDate)&&(identical(other.dataValue, dataValue) || other.dataValue == dataValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,goalId,dataDate,dataValue);

@override
String toString() {
  return 'GoalDatasSaveDto(goalId: $goalId, dataDate: $dataDate, dataValue: $dataValue)';
}


}

/// @nodoc
abstract mixin class _$GoalDatasSaveDtoCopyWith<$Res> implements $GoalDatasSaveDtoCopyWith<$Res> {
  factory _$GoalDatasSaveDtoCopyWith(_GoalDatasSaveDto value, $Res Function(_GoalDatasSaveDto) _then) = __$GoalDatasSaveDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'goal_id') String? goalId,@JsonKey(name: 'data_date') DateTime dataDate,@JsonKey(name: 'data_value') double dataValue
});




}
/// @nodoc
class __$GoalDatasSaveDtoCopyWithImpl<$Res>
    implements _$GoalDatasSaveDtoCopyWith<$Res> {
  __$GoalDatasSaveDtoCopyWithImpl(this._self, this._then);

  final _GoalDatasSaveDto _self;
  final $Res Function(_GoalDatasSaveDto) _then;

/// Create a copy of GoalDatasSaveDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goalId = freezed,Object? dataDate = null,Object? dataValue = null,}) {
  return _then(_GoalDatasSaveDto(
goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,dataDate: null == dataDate ? _self.dataDate : dataDate // ignore: cast_nullable_to_non_nullable
as DateTime,dataValue: null == dataValue ? _self.dataValue : dataValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
