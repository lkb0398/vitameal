// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_data_page_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoalDataPageState {

 GoalsEntity get selectedGoal;// 목표 선택값
 bool get isReversed;// 정렬 (false = 최신순, true = 오래된순)
 Set<String> get selectedDataIds;// 삭제 선택값 집합
 String get value;// 데이터 수치 입력값
 DateTime? get selectedDate;
/// Create a copy of GoalDataPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalDataPageStateCopyWith<GoalDataPageState> get copyWith => _$GoalDataPageStateCopyWithImpl<GoalDataPageState>(this as GoalDataPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalDataPageState&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed)&&const DeepCollectionEquality().equals(other.selectedDataIds, selectedDataIds)&&(identical(other.value, value) || other.value == value)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,selectedGoal,isReversed,const DeepCollectionEquality().hash(selectedDataIds),value,selectedDate);

@override
String toString() {
  return 'GoalDataPageState(selectedGoal: $selectedGoal, isReversed: $isReversed, selectedDataIds: $selectedDataIds, value: $value, selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class $GoalDataPageStateCopyWith<$Res>  {
  factory $GoalDataPageStateCopyWith(GoalDataPageState value, $Res Function(GoalDataPageState) _then) = _$GoalDataPageStateCopyWithImpl;
@useResult
$Res call({
 GoalsEntity selectedGoal, bool isReversed, Set<String> selectedDataIds, String value, DateTime? selectedDate
});


$GoalsEntityCopyWith<$Res> get selectedGoal;

}
/// @nodoc
class _$GoalDataPageStateCopyWithImpl<$Res>
    implements $GoalDataPageStateCopyWith<$Res> {
  _$GoalDataPageStateCopyWithImpl(this._self, this._then);

  final GoalDataPageState _self;
  final $Res Function(GoalDataPageState) _then;

/// Create a copy of GoalDataPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedGoal = null,Object? isReversed = null,Object? selectedDataIds = null,Object? value = null,Object? selectedDate = freezed,}) {
  return _then(_self.copyWith(
selectedGoal: null == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalsEntity,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,selectedDataIds: null == selectedDataIds ? _self.selectedDataIds : selectedDataIds // ignore: cast_nullable_to_non_nullable
as Set<String>,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of GoalDataPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalsEntityCopyWith<$Res> get selectedGoal {
  
  return $GoalsEntityCopyWith<$Res>(_self.selectedGoal, (value) {
    return _then(_self.copyWith(selectedGoal: value));
  });
}
}


/// Adds pattern-matching-related methods to [GoalDataPageState].
extension GoalDataPageStatePatterns on GoalDataPageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalDataPageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalDataPageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalDataPageState value)  $default,){
final _that = this;
switch (_that) {
case _GoalDataPageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalDataPageState value)?  $default,){
final _that = this;
switch (_that) {
case _GoalDataPageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GoalsEntity selectedGoal,  bool isReversed,  Set<String> selectedDataIds,  String value,  DateTime? selectedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalDataPageState() when $default != null:
return $default(_that.selectedGoal,_that.isReversed,_that.selectedDataIds,_that.value,_that.selectedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GoalsEntity selectedGoal,  bool isReversed,  Set<String> selectedDataIds,  String value,  DateTime? selectedDate)  $default,) {final _that = this;
switch (_that) {
case _GoalDataPageState():
return $default(_that.selectedGoal,_that.isReversed,_that.selectedDataIds,_that.value,_that.selectedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GoalsEntity selectedGoal,  bool isReversed,  Set<String> selectedDataIds,  String value,  DateTime? selectedDate)?  $default,) {final _that = this;
switch (_that) {
case _GoalDataPageState() when $default != null:
return $default(_that.selectedGoal,_that.isReversed,_that.selectedDataIds,_that.value,_that.selectedDate);case _:
  return null;

}
}

}

/// @nodoc


class _GoalDataPageState implements GoalDataPageState {
  const _GoalDataPageState({required this.selectedGoal, this.isReversed = false, final  Set<String> selectedDataIds = const {}, this.value = '', this.selectedDate}): _selectedDataIds = selectedDataIds;
  

@override final  GoalsEntity selectedGoal;
// 목표 선택값
@override@JsonKey() final  bool isReversed;
// 정렬 (false = 최신순, true = 오래된순)
 final  Set<String> _selectedDataIds;
// 정렬 (false = 최신순, true = 오래된순)
@override@JsonKey() Set<String> get selectedDataIds {
  if (_selectedDataIds is EqualUnmodifiableSetView) return _selectedDataIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedDataIds);
}

// 삭제 선택값 집합
@override@JsonKey() final  String value;
// 데이터 수치 입력값
@override final  DateTime? selectedDate;

/// Create a copy of GoalDataPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalDataPageStateCopyWith<_GoalDataPageState> get copyWith => __$GoalDataPageStateCopyWithImpl<_GoalDataPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalDataPageState&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed)&&const DeepCollectionEquality().equals(other._selectedDataIds, _selectedDataIds)&&(identical(other.value, value) || other.value == value)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,selectedGoal,isReversed,const DeepCollectionEquality().hash(_selectedDataIds),value,selectedDate);

@override
String toString() {
  return 'GoalDataPageState(selectedGoal: $selectedGoal, isReversed: $isReversed, selectedDataIds: $selectedDataIds, value: $value, selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class _$GoalDataPageStateCopyWith<$Res> implements $GoalDataPageStateCopyWith<$Res> {
  factory _$GoalDataPageStateCopyWith(_GoalDataPageState value, $Res Function(_GoalDataPageState) _then) = __$GoalDataPageStateCopyWithImpl;
@override @useResult
$Res call({
 GoalsEntity selectedGoal, bool isReversed, Set<String> selectedDataIds, String value, DateTime? selectedDate
});


@override $GoalsEntityCopyWith<$Res> get selectedGoal;

}
/// @nodoc
class __$GoalDataPageStateCopyWithImpl<$Res>
    implements _$GoalDataPageStateCopyWith<$Res> {
  __$GoalDataPageStateCopyWithImpl(this._self, this._then);

  final _GoalDataPageState _self;
  final $Res Function(_GoalDataPageState) _then;

/// Create a copy of GoalDataPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedGoal = null,Object? isReversed = null,Object? selectedDataIds = null,Object? value = null,Object? selectedDate = freezed,}) {
  return _then(_GoalDataPageState(
selectedGoal: null == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalsEntity,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,selectedDataIds: null == selectedDataIds ? _self._selectedDataIds : selectedDataIds // ignore: cast_nullable_to_non_nullable
as Set<String>,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of GoalDataPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalsEntityCopyWith<$Res> get selectedGoal {
  
  return $GoalsEntityCopyWith<$Res>(_self.selectedGoal, (value) {
    return _then(_self.copyWith(selectedGoal: value));
  });
}
}

// dart format on
