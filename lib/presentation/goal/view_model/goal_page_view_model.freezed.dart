// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_page_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoalPageState {

 String get title;// 목표명 입력값
 String get unit;// 목표 단위 입력값
 String get value;// 목표 수치 입력값
 DateTime? get selectedDate;
/// Create a copy of GoalPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalPageStateCopyWith<GoalPageState> get copyWith => _$GoalPageStateCopyWithImpl<GoalPageState>(this as GoalPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalPageState&&(identical(other.title, title) || other.title == title)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.value, value) || other.value == value)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,title,unit,value,selectedDate);

@override
String toString() {
  return 'GoalPageState(title: $title, unit: $unit, value: $value, selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class $GoalPageStateCopyWith<$Res>  {
  factory $GoalPageStateCopyWith(GoalPageState value, $Res Function(GoalPageState) _then) = _$GoalPageStateCopyWithImpl;
@useResult
$Res call({
 String title, String unit, String value, DateTime? selectedDate
});




}
/// @nodoc
class _$GoalPageStateCopyWithImpl<$Res>
    implements $GoalPageStateCopyWith<$Res> {
  _$GoalPageStateCopyWithImpl(this._self, this._then);

  final GoalPageState _self;
  final $Res Function(GoalPageState) _then;

/// Create a copy of GoalPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? unit = null,Object? value = null,Object? selectedDate = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalPageState].
extension GoalPageStatePatterns on GoalPageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalPageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalPageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalPageState value)  $default,){
final _that = this;
switch (_that) {
case _GoalPageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalPageState value)?  $default,){
final _that = this;
switch (_that) {
case _GoalPageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String unit,  String value,  DateTime? selectedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalPageState() when $default != null:
return $default(_that.title,_that.unit,_that.value,_that.selectedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String unit,  String value,  DateTime? selectedDate)  $default,) {final _that = this;
switch (_that) {
case _GoalPageState():
return $default(_that.title,_that.unit,_that.value,_that.selectedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String unit,  String value,  DateTime? selectedDate)?  $default,) {final _that = this;
switch (_that) {
case _GoalPageState() when $default != null:
return $default(_that.title,_that.unit,_that.value,_that.selectedDate);case _:
  return null;

}
}

}

/// @nodoc


class _GoalPageState implements GoalPageState {
  const _GoalPageState({this.title = '', this.unit = '', this.value = '', this.selectedDate});
  

@override@JsonKey() final  String title;
// 목표명 입력값
@override@JsonKey() final  String unit;
// 목표 단위 입력값
@override@JsonKey() final  String value;
// 목표 수치 입력값
@override final  DateTime? selectedDate;

/// Create a copy of GoalPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalPageStateCopyWith<_GoalPageState> get copyWith => __$GoalPageStateCopyWithImpl<_GoalPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalPageState&&(identical(other.title, title) || other.title == title)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.value, value) || other.value == value)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,title,unit,value,selectedDate);

@override
String toString() {
  return 'GoalPageState(title: $title, unit: $unit, value: $value, selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class _$GoalPageStateCopyWith<$Res> implements $GoalPageStateCopyWith<$Res> {
  factory _$GoalPageStateCopyWith(_GoalPageState value, $Res Function(_GoalPageState) _then) = __$GoalPageStateCopyWithImpl;
@override @useResult
$Res call({
 String title, String unit, String value, DateTime? selectedDate
});




}
/// @nodoc
class __$GoalPageStateCopyWithImpl<$Res>
    implements _$GoalPageStateCopyWith<$Res> {
  __$GoalPageStateCopyWithImpl(this._self, this._then);

  final _GoalPageState _self;
  final $Res Function(_GoalPageState) _then;

/// Create a copy of GoalPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? unit = null,Object? value = null,Object? selectedDate = freezed,}) {
  return _then(_GoalPageState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
