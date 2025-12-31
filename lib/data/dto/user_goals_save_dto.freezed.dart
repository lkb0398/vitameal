// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_goals_save_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserGoalsSaveDto {

@JsonKey(name: 'user_id') String? get userId;@JsonKey(name: 'goal_title') String get goalTitle;@JsonKey(name: 'goal_unit') String get goalUnit;@JsonKey(name: 'goal_value') num get goalValue;@JsonKey(name: 'goal_date') String get goalDate;@JsonKey(name: 'is_done') bool get isDone;@JsonKey(name: 'is_main') bool get isMain;
/// Create a copy of UserGoalsSaveDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserGoalsSaveDtoCopyWith<UserGoalsSaveDto> get copyWith => _$UserGoalsSaveDtoCopyWithImpl<UserGoalsSaveDto>(this as UserGoalsSaveDto, _$identity);

  /// Serializes this UserGoalsSaveDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserGoalsSaveDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.goalTitle, goalTitle) || other.goalTitle == goalTitle)&&(identical(other.goalUnit, goalUnit) || other.goalUnit == goalUnit)&&(identical(other.goalValue, goalValue) || other.goalValue == goalValue)&&(identical(other.goalDate, goalDate) || other.goalDate == goalDate)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.isMain, isMain) || other.isMain == isMain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,goalTitle,goalUnit,goalValue,goalDate,isDone,isMain);

@override
String toString() {
  return 'UserGoalsSaveDto(userId: $userId, goalTitle: $goalTitle, goalUnit: $goalUnit, goalValue: $goalValue, goalDate: $goalDate, isDone: $isDone, isMain: $isMain)';
}


}

/// @nodoc
abstract mixin class $UserGoalsSaveDtoCopyWith<$Res>  {
  factory $UserGoalsSaveDtoCopyWith(UserGoalsSaveDto value, $Res Function(UserGoalsSaveDto) _then) = _$UserGoalsSaveDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'goal_title') String goalTitle,@JsonKey(name: 'goal_unit') String goalUnit,@JsonKey(name: 'goal_value') num goalValue,@JsonKey(name: 'goal_date') String goalDate,@JsonKey(name: 'is_done') bool isDone,@JsonKey(name: 'is_main') bool isMain
});




}
/// @nodoc
class _$UserGoalsSaveDtoCopyWithImpl<$Res>
    implements $UserGoalsSaveDtoCopyWith<$Res> {
  _$UserGoalsSaveDtoCopyWithImpl(this._self, this._then);

  final UserGoalsSaveDto _self;
  final $Res Function(UserGoalsSaveDto) _then;

/// Create a copy of UserGoalsSaveDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? goalTitle = null,Object? goalUnit = null,Object? goalValue = null,Object? goalDate = null,Object? isDone = null,Object? isMain = null,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,goalTitle: null == goalTitle ? _self.goalTitle : goalTitle // ignore: cast_nullable_to_non_nullable
as String,goalUnit: null == goalUnit ? _self.goalUnit : goalUnit // ignore: cast_nullable_to_non_nullable
as String,goalValue: null == goalValue ? _self.goalValue : goalValue // ignore: cast_nullable_to_non_nullable
as num,goalDate: null == goalDate ? _self.goalDate : goalDate // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,isMain: null == isMain ? _self.isMain : isMain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserGoalsSaveDto].
extension UserGoalsSaveDtoPatterns on UserGoalsSaveDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserGoalsSaveDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserGoalsSaveDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserGoalsSaveDto value)  $default,){
final _that = this;
switch (_that) {
case _UserGoalsSaveDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserGoalsSaveDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserGoalsSaveDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'goal_title')  String goalTitle, @JsonKey(name: 'goal_unit')  String goalUnit, @JsonKey(name: 'goal_value')  num goalValue, @JsonKey(name: 'goal_date')  String goalDate, @JsonKey(name: 'is_done')  bool isDone, @JsonKey(name: 'is_main')  bool isMain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserGoalsSaveDto() when $default != null:
return $default(_that.userId,_that.goalTitle,_that.goalUnit,_that.goalValue,_that.goalDate,_that.isDone,_that.isMain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'goal_title')  String goalTitle, @JsonKey(name: 'goal_unit')  String goalUnit, @JsonKey(name: 'goal_value')  num goalValue, @JsonKey(name: 'goal_date')  String goalDate, @JsonKey(name: 'is_done')  bool isDone, @JsonKey(name: 'is_main')  bool isMain)  $default,) {final _that = this;
switch (_that) {
case _UserGoalsSaveDto():
return $default(_that.userId,_that.goalTitle,_that.goalUnit,_that.goalValue,_that.goalDate,_that.isDone,_that.isMain);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'goal_title')  String goalTitle, @JsonKey(name: 'goal_unit')  String goalUnit, @JsonKey(name: 'goal_value')  num goalValue, @JsonKey(name: 'goal_date')  String goalDate, @JsonKey(name: 'is_done')  bool isDone, @JsonKey(name: 'is_main')  bool isMain)?  $default,) {final _that = this;
switch (_that) {
case _UserGoalsSaveDto() when $default != null:
return $default(_that.userId,_that.goalTitle,_that.goalUnit,_that.goalValue,_that.goalDate,_that.isDone,_that.isMain);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserGoalsSaveDto implements UserGoalsSaveDto {
  const _UserGoalsSaveDto({@JsonKey(name: 'user_id') this.userId, @JsonKey(name: 'goal_title') required this.goalTitle, @JsonKey(name: 'goal_unit') required this.goalUnit, @JsonKey(name: 'goal_value') required this.goalValue, @JsonKey(name: 'goal_date') required this.goalDate, @JsonKey(name: 'is_done') required this.isDone, @JsonKey(name: 'is_main') required this.isMain});
  factory _UserGoalsSaveDto.fromJson(Map<String, dynamic> json) => _$UserGoalsSaveDtoFromJson(json);

@override@JsonKey(name: 'user_id') final  String? userId;
@override@JsonKey(name: 'goal_title') final  String goalTitle;
@override@JsonKey(name: 'goal_unit') final  String goalUnit;
@override@JsonKey(name: 'goal_value') final  num goalValue;
@override@JsonKey(name: 'goal_date') final  String goalDate;
@override@JsonKey(name: 'is_done') final  bool isDone;
@override@JsonKey(name: 'is_main') final  bool isMain;

/// Create a copy of UserGoalsSaveDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserGoalsSaveDtoCopyWith<_UserGoalsSaveDto> get copyWith => __$UserGoalsSaveDtoCopyWithImpl<_UserGoalsSaveDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserGoalsSaveDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserGoalsSaveDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.goalTitle, goalTitle) || other.goalTitle == goalTitle)&&(identical(other.goalUnit, goalUnit) || other.goalUnit == goalUnit)&&(identical(other.goalValue, goalValue) || other.goalValue == goalValue)&&(identical(other.goalDate, goalDate) || other.goalDate == goalDate)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.isMain, isMain) || other.isMain == isMain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,goalTitle,goalUnit,goalValue,goalDate,isDone,isMain);

@override
String toString() {
  return 'UserGoalsSaveDto(userId: $userId, goalTitle: $goalTitle, goalUnit: $goalUnit, goalValue: $goalValue, goalDate: $goalDate, isDone: $isDone, isMain: $isMain)';
}


}

/// @nodoc
abstract mixin class _$UserGoalsSaveDtoCopyWith<$Res> implements $UserGoalsSaveDtoCopyWith<$Res> {
  factory _$UserGoalsSaveDtoCopyWith(_UserGoalsSaveDto value, $Res Function(_UserGoalsSaveDto) _then) = __$UserGoalsSaveDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'goal_title') String goalTitle,@JsonKey(name: 'goal_unit') String goalUnit,@JsonKey(name: 'goal_value') num goalValue,@JsonKey(name: 'goal_date') String goalDate,@JsonKey(name: 'is_done') bool isDone,@JsonKey(name: 'is_main') bool isMain
});




}
/// @nodoc
class __$UserGoalsSaveDtoCopyWithImpl<$Res>
    implements _$UserGoalsSaveDtoCopyWith<$Res> {
  __$UserGoalsSaveDtoCopyWithImpl(this._self, this._then);

  final _UserGoalsSaveDto _self;
  final $Res Function(_UserGoalsSaveDto) _then;

/// Create a copy of UserGoalsSaveDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? goalTitle = null,Object? goalUnit = null,Object? goalValue = null,Object? goalDate = null,Object? isDone = null,Object? isMain = null,}) {
  return _then(_UserGoalsSaveDto(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,goalTitle: null == goalTitle ? _self.goalTitle : goalTitle // ignore: cast_nullable_to_non_nullable
as String,goalUnit: null == goalUnit ? _self.goalUnit : goalUnit // ignore: cast_nullable_to_non_nullable
as String,goalValue: null == goalValue ? _self.goalValue : goalValue // ignore: cast_nullable_to_non_nullable
as num,goalDate: null == goalDate ? _self.goalDate : goalDate // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,isMain: null == isMain ? _self.isMain : isMain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
