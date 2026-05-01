// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_page_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationPageState {

 String? get label;// 알림명
 TimeOfDay? get selectedTime;
/// Create a copy of NotificationPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPageStateCopyWith<NotificationPageState> get copyWith => _$NotificationPageStateCopyWithImpl<NotificationPageState>(this as NotificationPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPageState&&(identical(other.label, label) || other.label == label)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime));
}


@override
int get hashCode => Object.hash(runtimeType,label,selectedTime);

@override
String toString() {
  return 'NotificationPageState(label: $label, selectedTime: $selectedTime)';
}


}

/// @nodoc
abstract mixin class $NotificationPageStateCopyWith<$Res>  {
  factory $NotificationPageStateCopyWith(NotificationPageState value, $Res Function(NotificationPageState) _then) = _$NotificationPageStateCopyWithImpl;
@useResult
$Res call({
 String? label, TimeOfDay? selectedTime
});




}
/// @nodoc
class _$NotificationPageStateCopyWithImpl<$Res>
    implements $NotificationPageStateCopyWith<$Res> {
  _$NotificationPageStateCopyWithImpl(this._self, this._then);

  final NotificationPageState _self;
  final $Res Function(NotificationPageState) _then;

/// Create a copy of NotificationPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = freezed,Object? selectedTime = freezed,}) {
  return _then(_self.copyWith(
label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPageState].
extension NotificationPageStatePatterns on NotificationPageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPageState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPageState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? label,  TimeOfDay? selectedTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPageState() when $default != null:
return $default(_that.label,_that.selectedTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? label,  TimeOfDay? selectedTime)  $default,) {final _that = this;
switch (_that) {
case _NotificationPageState():
return $default(_that.label,_that.selectedTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? label,  TimeOfDay? selectedTime)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPageState() when $default != null:
return $default(_that.label,_that.selectedTime);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationPageState implements NotificationPageState {
  const _NotificationPageState({this.label, this.selectedTime});
  

@override final  String? label;
// 알림명
@override final  TimeOfDay? selectedTime;

/// Create a copy of NotificationPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPageStateCopyWith<_NotificationPageState> get copyWith => __$NotificationPageStateCopyWithImpl<_NotificationPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPageState&&(identical(other.label, label) || other.label == label)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime));
}


@override
int get hashCode => Object.hash(runtimeType,label,selectedTime);

@override
String toString() {
  return 'NotificationPageState(label: $label, selectedTime: $selectedTime)';
}


}

/// @nodoc
abstract mixin class _$NotificationPageStateCopyWith<$Res> implements $NotificationPageStateCopyWith<$Res> {
  factory _$NotificationPageStateCopyWith(_NotificationPageState value, $Res Function(_NotificationPageState) _then) = __$NotificationPageStateCopyWithImpl;
@override @useResult
$Res call({
 String? label, TimeOfDay? selectedTime
});




}
/// @nodoc
class __$NotificationPageStateCopyWithImpl<$Res>
    implements _$NotificationPageStateCopyWith<$Res> {
  __$NotificationPageStateCopyWithImpl(this._self, this._then);

  final _NotificationPageState _self;
  final $Res Function(_NotificationPageState) _then;

/// Create a copy of NotificationPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = freezed,Object? selectedTime = freezed,}) {
  return _then(_NotificationPageState(
label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,
  ));
}


}

// dart format on
