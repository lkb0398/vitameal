// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eats_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EatsState {

 List<EatsEntity> get eats;// 음식점 리스트
 LatLng? get location;// 지도 위치
 bool get loading;// 로딩중 여부
 int get selected;// 선택된 음식점
 TagEntity? get selectedTag;// 선택된 태그
 bool get needSearch;// 재검색 필요 여부
 PermissionState get permission;
/// Create a copy of EatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EatsStateCopyWith<EatsState> get copyWith => _$EatsStateCopyWithImpl<EatsState>(this as EatsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EatsState&&const DeepCollectionEquality().equals(other.eats, eats)&&(identical(other.location, location) || other.location == location)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.selectedTag, selectedTag) || other.selectedTag == selectedTag)&&(identical(other.needSearch, needSearch) || other.needSearch == needSearch)&&(identical(other.permission, permission) || other.permission == permission));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(eats),location,loading,selected,selectedTag,needSearch,permission);

@override
String toString() {
  return 'EatsState(eats: $eats, location: $location, loading: $loading, selected: $selected, selectedTag: $selectedTag, needSearch: $needSearch, permission: $permission)';
}


}

/// @nodoc
abstract mixin class $EatsStateCopyWith<$Res>  {
  factory $EatsStateCopyWith(EatsState value, $Res Function(EatsState) _then) = _$EatsStateCopyWithImpl;
@useResult
$Res call({
 List<EatsEntity> eats, LatLng? location, bool loading, int selected, TagEntity? selectedTag, bool needSearch, PermissionState permission
});


$TagEntityCopyWith<$Res>? get selectedTag;

}
/// @nodoc
class _$EatsStateCopyWithImpl<$Res>
    implements $EatsStateCopyWith<$Res> {
  _$EatsStateCopyWithImpl(this._self, this._then);

  final EatsState _self;
  final $Res Function(EatsState) _then;

/// Create a copy of EatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eats = null,Object? location = freezed,Object? loading = null,Object? selected = null,Object? selectedTag = freezed,Object? needSearch = null,Object? permission = null,}) {
  return _then(_self.copyWith(
eats: null == eats ? _self.eats : eats // ignore: cast_nullable_to_non_nullable
as List<EatsEntity>,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as int,selectedTag: freezed == selectedTag ? _self.selectedTag : selectedTag // ignore: cast_nullable_to_non_nullable
as TagEntity?,needSearch: null == needSearch ? _self.needSearch : needSearch // ignore: cast_nullable_to_non_nullable
as bool,permission: null == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as PermissionState,
  ));
}
/// Create a copy of EatsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagEntityCopyWith<$Res>? get selectedTag {
    if (_self.selectedTag == null) {
    return null;
  }

  return $TagEntityCopyWith<$Res>(_self.selectedTag!, (value) {
    return _then(_self.copyWith(selectedTag: value));
  });
}
}


/// Adds pattern-matching-related methods to [EatsState].
extension EatsStatePatterns on EatsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EatsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EatsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EatsState value)  $default,){
final _that = this;
switch (_that) {
case _EatsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EatsState value)?  $default,){
final _that = this;
switch (_that) {
case _EatsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EatsEntity> eats,  LatLng? location,  bool loading,  int selected,  TagEntity? selectedTag,  bool needSearch,  PermissionState permission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EatsState() when $default != null:
return $default(_that.eats,_that.location,_that.loading,_that.selected,_that.selectedTag,_that.needSearch,_that.permission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EatsEntity> eats,  LatLng? location,  bool loading,  int selected,  TagEntity? selectedTag,  bool needSearch,  PermissionState permission)  $default,) {final _that = this;
switch (_that) {
case _EatsState():
return $default(_that.eats,_that.location,_that.loading,_that.selected,_that.selectedTag,_that.needSearch,_that.permission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EatsEntity> eats,  LatLng? location,  bool loading,  int selected,  TagEntity? selectedTag,  bool needSearch,  PermissionState permission)?  $default,) {final _that = this;
switch (_that) {
case _EatsState() when $default != null:
return $default(_that.eats,_that.location,_that.loading,_that.selected,_that.selectedTag,_that.needSearch,_that.permission);case _:
  return null;

}
}

}

/// @nodoc


class _EatsState implements EatsState {
  const _EatsState({required final  List<EatsEntity> eats, this.location, required this.loading, required this.selected, this.selectedTag, required this.needSearch, required this.permission}): _eats = eats;
  

 final  List<EatsEntity> _eats;
@override List<EatsEntity> get eats {
  if (_eats is EqualUnmodifiableListView) return _eats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eats);
}

// 음식점 리스트
@override final  LatLng? location;
// 지도 위치
@override final  bool loading;
// 로딩중 여부
@override final  int selected;
// 선택된 음식점
@override final  TagEntity? selectedTag;
// 선택된 태그
@override final  bool needSearch;
// 재검색 필요 여부
@override final  PermissionState permission;

/// Create a copy of EatsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EatsStateCopyWith<_EatsState> get copyWith => __$EatsStateCopyWithImpl<_EatsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EatsState&&const DeepCollectionEquality().equals(other._eats, _eats)&&(identical(other.location, location) || other.location == location)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.selectedTag, selectedTag) || other.selectedTag == selectedTag)&&(identical(other.needSearch, needSearch) || other.needSearch == needSearch)&&(identical(other.permission, permission) || other.permission == permission));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_eats),location,loading,selected,selectedTag,needSearch,permission);

@override
String toString() {
  return 'EatsState(eats: $eats, location: $location, loading: $loading, selected: $selected, selectedTag: $selectedTag, needSearch: $needSearch, permission: $permission)';
}


}

/// @nodoc
abstract mixin class _$EatsStateCopyWith<$Res> implements $EatsStateCopyWith<$Res> {
  factory _$EatsStateCopyWith(_EatsState value, $Res Function(_EatsState) _then) = __$EatsStateCopyWithImpl;
@override @useResult
$Res call({
 List<EatsEntity> eats, LatLng? location, bool loading, int selected, TagEntity? selectedTag, bool needSearch, PermissionState permission
});


@override $TagEntityCopyWith<$Res>? get selectedTag;

}
/// @nodoc
class __$EatsStateCopyWithImpl<$Res>
    implements _$EatsStateCopyWith<$Res> {
  __$EatsStateCopyWithImpl(this._self, this._then);

  final _EatsState _self;
  final $Res Function(_EatsState) _then;

/// Create a copy of EatsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eats = null,Object? location = freezed,Object? loading = null,Object? selected = null,Object? selectedTag = freezed,Object? needSearch = null,Object? permission = null,}) {
  return _then(_EatsState(
eats: null == eats ? _self._eats : eats // ignore: cast_nullable_to_non_nullable
as List<EatsEntity>,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as int,selectedTag: freezed == selectedTag ? _self.selectedTag : selectedTag // ignore: cast_nullable_to_non_nullable
as TagEntity?,needSearch: null == needSearch ? _self.needSearch : needSearch // ignore: cast_nullable_to_non_nullable
as bool,permission: null == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as PermissionState,
  ));
}

/// Create a copy of EatsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagEntityCopyWith<$Res>? get selectedTag {
    if (_self.selectedTag == null) {
    return null;
  }

  return $TagEntityCopyWith<$Res>(_self.selectedTag!, (value) {
    return _then(_self.copyWith(selectedTag: value));
  });
}
}

// dart format on
