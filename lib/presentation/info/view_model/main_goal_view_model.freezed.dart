// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_goal_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainGoalState {

 GoalsEntity? get mainGoal;// 대표 설정된 목표
 List<GoalDatasEntity>? get mainGoalDatas;// 대표 설정된 목표의 데이터 전체 목록
 GoalDatasEntity? get oldestData;// 초기 데이터
 GoalDatasEntity? get latestData;// 최근 데이터
 List<GoalDatasEntity>? get latest5Datas;
/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainGoalStateCopyWith<MainGoalState> get copyWith => _$MainGoalStateCopyWithImpl<MainGoalState>(this as MainGoalState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainGoalState&&(identical(other.mainGoal, mainGoal) || other.mainGoal == mainGoal)&&const DeepCollectionEquality().equals(other.mainGoalDatas, mainGoalDatas)&&(identical(other.oldestData, oldestData) || other.oldestData == oldestData)&&(identical(other.latestData, latestData) || other.latestData == latestData)&&const DeepCollectionEquality().equals(other.latest5Datas, latest5Datas));
}


@override
int get hashCode => Object.hash(runtimeType,mainGoal,const DeepCollectionEquality().hash(mainGoalDatas),oldestData,latestData,const DeepCollectionEquality().hash(latest5Datas));

@override
String toString() {
  return 'MainGoalState(mainGoal: $mainGoal, mainGoalDatas: $mainGoalDatas, oldestData: $oldestData, latestData: $latestData, latest5Datas: $latest5Datas)';
}


}

/// @nodoc
abstract mixin class $MainGoalStateCopyWith<$Res>  {
  factory $MainGoalStateCopyWith(MainGoalState value, $Res Function(MainGoalState) _then) = _$MainGoalStateCopyWithImpl;
@useResult
$Res call({
 GoalsEntity? mainGoal, List<GoalDatasEntity>? mainGoalDatas, GoalDatasEntity? oldestData, GoalDatasEntity? latestData, List<GoalDatasEntity>? latest5Datas
});


$GoalsEntityCopyWith<$Res>? get mainGoal;$GoalDatasEntityCopyWith<$Res>? get oldestData;$GoalDatasEntityCopyWith<$Res>? get latestData;

}
/// @nodoc
class _$MainGoalStateCopyWithImpl<$Res>
    implements $MainGoalStateCopyWith<$Res> {
  _$MainGoalStateCopyWithImpl(this._self, this._then);

  final MainGoalState _self;
  final $Res Function(MainGoalState) _then;

/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainGoal = freezed,Object? mainGoalDatas = freezed,Object? oldestData = freezed,Object? latestData = freezed,Object? latest5Datas = freezed,}) {
  return _then(_self.copyWith(
mainGoal: freezed == mainGoal ? _self.mainGoal : mainGoal // ignore: cast_nullable_to_non_nullable
as GoalsEntity?,mainGoalDatas: freezed == mainGoalDatas ? _self.mainGoalDatas : mainGoalDatas // ignore: cast_nullable_to_non_nullable
as List<GoalDatasEntity>?,oldestData: freezed == oldestData ? _self.oldestData : oldestData // ignore: cast_nullable_to_non_nullable
as GoalDatasEntity?,latestData: freezed == latestData ? _self.latestData : latestData // ignore: cast_nullable_to_non_nullable
as GoalDatasEntity?,latest5Datas: freezed == latest5Datas ? _self.latest5Datas : latest5Datas // ignore: cast_nullable_to_non_nullable
as List<GoalDatasEntity>?,
  ));
}
/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalsEntityCopyWith<$Res>? get mainGoal {
    if (_self.mainGoal == null) {
    return null;
  }

  return $GoalsEntityCopyWith<$Res>(_self.mainGoal!, (value) {
    return _then(_self.copyWith(mainGoal: value));
  });
}/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalDatasEntityCopyWith<$Res>? get oldestData {
    if (_self.oldestData == null) {
    return null;
  }

  return $GoalDatasEntityCopyWith<$Res>(_self.oldestData!, (value) {
    return _then(_self.copyWith(oldestData: value));
  });
}/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalDatasEntityCopyWith<$Res>? get latestData {
    if (_self.latestData == null) {
    return null;
  }

  return $GoalDatasEntityCopyWith<$Res>(_self.latestData!, (value) {
    return _then(_self.copyWith(latestData: value));
  });
}
}


/// Adds pattern-matching-related methods to [MainGoalState].
extension MainGoalStatePatterns on MainGoalState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MainGoalState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MainGoalState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MainGoalState value)  $default,){
final _that = this;
switch (_that) {
case _MainGoalState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MainGoalState value)?  $default,){
final _that = this;
switch (_that) {
case _MainGoalState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GoalsEntity? mainGoal,  List<GoalDatasEntity>? mainGoalDatas,  GoalDatasEntity? oldestData,  GoalDatasEntity? latestData,  List<GoalDatasEntity>? latest5Datas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainGoalState() when $default != null:
return $default(_that.mainGoal,_that.mainGoalDatas,_that.oldestData,_that.latestData,_that.latest5Datas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GoalsEntity? mainGoal,  List<GoalDatasEntity>? mainGoalDatas,  GoalDatasEntity? oldestData,  GoalDatasEntity? latestData,  List<GoalDatasEntity>? latest5Datas)  $default,) {final _that = this;
switch (_that) {
case _MainGoalState():
return $default(_that.mainGoal,_that.mainGoalDatas,_that.oldestData,_that.latestData,_that.latest5Datas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GoalsEntity? mainGoal,  List<GoalDatasEntity>? mainGoalDatas,  GoalDatasEntity? oldestData,  GoalDatasEntity? latestData,  List<GoalDatasEntity>? latest5Datas)?  $default,) {final _that = this;
switch (_that) {
case _MainGoalState() when $default != null:
return $default(_that.mainGoal,_that.mainGoalDatas,_that.oldestData,_that.latestData,_that.latest5Datas);case _:
  return null;

}
}

}

/// @nodoc


class _MainGoalState implements MainGoalState {
  const _MainGoalState({this.mainGoal, final  List<GoalDatasEntity>? mainGoalDatas, this.oldestData, this.latestData, final  List<GoalDatasEntity>? latest5Datas}): _mainGoalDatas = mainGoalDatas,_latest5Datas = latest5Datas;
  

@override final  GoalsEntity? mainGoal;
// 대표 설정된 목표
 final  List<GoalDatasEntity>? _mainGoalDatas;
// 대표 설정된 목표
@override List<GoalDatasEntity>? get mainGoalDatas {
  final value = _mainGoalDatas;
  if (value == null) return null;
  if (_mainGoalDatas is EqualUnmodifiableListView) return _mainGoalDatas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// 대표 설정된 목표의 데이터 전체 목록
@override final  GoalDatasEntity? oldestData;
// 초기 데이터
@override final  GoalDatasEntity? latestData;
// 최근 데이터
 final  List<GoalDatasEntity>? _latest5Datas;
// 최근 데이터
@override List<GoalDatasEntity>? get latest5Datas {
  final value = _latest5Datas;
  if (value == null) return null;
  if (_latest5Datas is EqualUnmodifiableListView) return _latest5Datas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MainGoalStateCopyWith<_MainGoalState> get copyWith => __$MainGoalStateCopyWithImpl<_MainGoalState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MainGoalState&&(identical(other.mainGoal, mainGoal) || other.mainGoal == mainGoal)&&const DeepCollectionEquality().equals(other._mainGoalDatas, _mainGoalDatas)&&(identical(other.oldestData, oldestData) || other.oldestData == oldestData)&&(identical(other.latestData, latestData) || other.latestData == latestData)&&const DeepCollectionEquality().equals(other._latest5Datas, _latest5Datas));
}


@override
int get hashCode => Object.hash(runtimeType,mainGoal,const DeepCollectionEquality().hash(_mainGoalDatas),oldestData,latestData,const DeepCollectionEquality().hash(_latest5Datas));

@override
String toString() {
  return 'MainGoalState(mainGoal: $mainGoal, mainGoalDatas: $mainGoalDatas, oldestData: $oldestData, latestData: $latestData, latest5Datas: $latest5Datas)';
}


}

/// @nodoc
abstract mixin class _$MainGoalStateCopyWith<$Res> implements $MainGoalStateCopyWith<$Res> {
  factory _$MainGoalStateCopyWith(_MainGoalState value, $Res Function(_MainGoalState) _then) = __$MainGoalStateCopyWithImpl;
@override @useResult
$Res call({
 GoalsEntity? mainGoal, List<GoalDatasEntity>? mainGoalDatas, GoalDatasEntity? oldestData, GoalDatasEntity? latestData, List<GoalDatasEntity>? latest5Datas
});


@override $GoalsEntityCopyWith<$Res>? get mainGoal;@override $GoalDatasEntityCopyWith<$Res>? get oldestData;@override $GoalDatasEntityCopyWith<$Res>? get latestData;

}
/// @nodoc
class __$MainGoalStateCopyWithImpl<$Res>
    implements _$MainGoalStateCopyWith<$Res> {
  __$MainGoalStateCopyWithImpl(this._self, this._then);

  final _MainGoalState _self;
  final $Res Function(_MainGoalState) _then;

/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainGoal = freezed,Object? mainGoalDatas = freezed,Object? oldestData = freezed,Object? latestData = freezed,Object? latest5Datas = freezed,}) {
  return _then(_MainGoalState(
mainGoal: freezed == mainGoal ? _self.mainGoal : mainGoal // ignore: cast_nullable_to_non_nullable
as GoalsEntity?,mainGoalDatas: freezed == mainGoalDatas ? _self._mainGoalDatas : mainGoalDatas // ignore: cast_nullable_to_non_nullable
as List<GoalDatasEntity>?,oldestData: freezed == oldestData ? _self.oldestData : oldestData // ignore: cast_nullable_to_non_nullable
as GoalDatasEntity?,latestData: freezed == latestData ? _self.latestData : latestData // ignore: cast_nullable_to_non_nullable
as GoalDatasEntity?,latest5Datas: freezed == latest5Datas ? _self._latest5Datas : latest5Datas // ignore: cast_nullable_to_non_nullable
as List<GoalDatasEntity>?,
  ));
}

/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalsEntityCopyWith<$Res>? get mainGoal {
    if (_self.mainGoal == null) {
    return null;
  }

  return $GoalsEntityCopyWith<$Res>(_self.mainGoal!, (value) {
    return _then(_self.copyWith(mainGoal: value));
  });
}/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalDatasEntityCopyWith<$Res>? get oldestData {
    if (_self.oldestData == null) {
    return null;
  }

  return $GoalDatasEntityCopyWith<$Res>(_self.oldestData!, (value) {
    return _then(_self.copyWith(oldestData: value));
  });
}/// Create a copy of MainGoalState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalDatasEntityCopyWith<$Res>? get latestData {
    if (_self.latestData == null) {
    return null;
  }

  return $GoalDatasEntityCopyWith<$Res>(_self.latestData!, (value) {
    return _then(_self.copyWith(latestData: value));
  });
}
}

// dart format on
