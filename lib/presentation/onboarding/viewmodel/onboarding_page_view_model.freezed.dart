// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_page_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingPageState {

 String? get url;// 프로필 사진 선택값
 String? get name;// 닉네임 입력값
 GenderType? get gender;// 성별 선택값
 String? get birth;// 출생년도 입력값
 String? get height;// 키 입력값
 String? get weight;// 몸무게 입력값
 List<int> get diseaseIds;// 질병 id 선택값 목록
 List<int> get allergyIds;// 알레르기 id 선택값 목록
 bool get uploading;// 이미지 업로드 중 여부
 String? get nicknameError;
/// Create a copy of OnboardingPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingPageStateCopyWith<OnboardingPageState> get copyWith => _$OnboardingPageStateCopyWithImpl<OnboardingPageState>(this as OnboardingPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingPageState&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birth, birth) || other.birth == birth)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&const DeepCollectionEquality().equals(other.diseaseIds, diseaseIds)&&const DeepCollectionEquality().equals(other.allergyIds, allergyIds)&&(identical(other.uploading, uploading) || other.uploading == uploading)&&(identical(other.nicknameError, nicknameError) || other.nicknameError == nicknameError));
}


@override
int get hashCode => Object.hash(runtimeType,url,name,gender,birth,height,weight,const DeepCollectionEquality().hash(diseaseIds),const DeepCollectionEquality().hash(allergyIds),uploading,nicknameError);

@override
String toString() {
  return 'OnboardingPageState(url: $url, name: $name, gender: $gender, birth: $birth, height: $height, weight: $weight, diseaseIds: $diseaseIds, allergyIds: $allergyIds, uploading: $uploading, nicknameError: $nicknameError)';
}


}

/// @nodoc
abstract mixin class $OnboardingPageStateCopyWith<$Res>  {
  factory $OnboardingPageStateCopyWith(OnboardingPageState value, $Res Function(OnboardingPageState) _then) = _$OnboardingPageStateCopyWithImpl;
@useResult
$Res call({
 String? url, String? name, GenderType? gender, String? birth, String? height, String? weight, List<int> diseaseIds, List<int> allergyIds, bool uploading, String? nicknameError
});




}
/// @nodoc
class _$OnboardingPageStateCopyWithImpl<$Res>
    implements $OnboardingPageStateCopyWith<$Res> {
  _$OnboardingPageStateCopyWithImpl(this._self, this._then);

  final OnboardingPageState _self;
  final $Res Function(OnboardingPageState) _then;

/// Create a copy of OnboardingPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? name = freezed,Object? gender = freezed,Object? birth = freezed,Object? height = freezed,Object? weight = freezed,Object? diseaseIds = null,Object? allergyIds = null,Object? uploading = null,Object? nicknameError = freezed,}) {
  return _then(_self.copyWith(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderType?,birth: freezed == birth ? _self.birth : birth // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as String?,diseaseIds: null == diseaseIds ? _self.diseaseIds : diseaseIds // ignore: cast_nullable_to_non_nullable
as List<int>,allergyIds: null == allergyIds ? _self.allergyIds : allergyIds // ignore: cast_nullable_to_non_nullable
as List<int>,uploading: null == uploading ? _self.uploading : uploading // ignore: cast_nullable_to_non_nullable
as bool,nicknameError: freezed == nicknameError ? _self.nicknameError : nicknameError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingPageState].
extension OnboardingPageStatePatterns on OnboardingPageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingPageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingPageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingPageState value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingPageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingPageState value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingPageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url,  String? name,  GenderType? gender,  String? birth,  String? height,  String? weight,  List<int> diseaseIds,  List<int> allergyIds,  bool uploading,  String? nicknameError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingPageState() when $default != null:
return $default(_that.url,_that.name,_that.gender,_that.birth,_that.height,_that.weight,_that.diseaseIds,_that.allergyIds,_that.uploading,_that.nicknameError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url,  String? name,  GenderType? gender,  String? birth,  String? height,  String? weight,  List<int> diseaseIds,  List<int> allergyIds,  bool uploading,  String? nicknameError)  $default,) {final _that = this;
switch (_that) {
case _OnboardingPageState():
return $default(_that.url,_that.name,_that.gender,_that.birth,_that.height,_that.weight,_that.diseaseIds,_that.allergyIds,_that.uploading,_that.nicknameError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url,  String? name,  GenderType? gender,  String? birth,  String? height,  String? weight,  List<int> diseaseIds,  List<int> allergyIds,  bool uploading,  String? nicknameError)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingPageState() when $default != null:
return $default(_that.url,_that.name,_that.gender,_that.birth,_that.height,_that.weight,_that.diseaseIds,_that.allergyIds,_that.uploading,_that.nicknameError);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingPageState implements OnboardingPageState {
  const _OnboardingPageState({this.url, this.name = '', this.gender = GenderType.unknown, this.birth = '', this.height = '', this.weight = '', final  List<int> diseaseIds = const [], final  List<int> allergyIds = const [], this.uploading = false, this.nicknameError}): _diseaseIds = diseaseIds,_allergyIds = allergyIds;
  

@override final  String? url;
// 프로필 사진 선택값
@override@JsonKey() final  String? name;
// 닉네임 입력값
@override@JsonKey() final  GenderType? gender;
// 성별 선택값
@override@JsonKey() final  String? birth;
// 출생년도 입력값
@override@JsonKey() final  String? height;
// 키 입력값
@override@JsonKey() final  String? weight;
// 몸무게 입력값
 final  List<int> _diseaseIds;
// 몸무게 입력값
@override@JsonKey() List<int> get diseaseIds {
  if (_diseaseIds is EqualUnmodifiableListView) return _diseaseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_diseaseIds);
}

// 질병 id 선택값 목록
 final  List<int> _allergyIds;
// 질병 id 선택값 목록
@override@JsonKey() List<int> get allergyIds {
  if (_allergyIds is EqualUnmodifiableListView) return _allergyIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allergyIds);
}

// 알레르기 id 선택값 목록
@override@JsonKey() final  bool uploading;
// 이미지 업로드 중 여부
@override final  String? nicknameError;

/// Create a copy of OnboardingPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingPageStateCopyWith<_OnboardingPageState> get copyWith => __$OnboardingPageStateCopyWithImpl<_OnboardingPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingPageState&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birth, birth) || other.birth == birth)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&const DeepCollectionEquality().equals(other._diseaseIds, _diseaseIds)&&const DeepCollectionEquality().equals(other._allergyIds, _allergyIds)&&(identical(other.uploading, uploading) || other.uploading == uploading)&&(identical(other.nicknameError, nicknameError) || other.nicknameError == nicknameError));
}


@override
int get hashCode => Object.hash(runtimeType,url,name,gender,birth,height,weight,const DeepCollectionEquality().hash(_diseaseIds),const DeepCollectionEquality().hash(_allergyIds),uploading,nicknameError);

@override
String toString() {
  return 'OnboardingPageState(url: $url, name: $name, gender: $gender, birth: $birth, height: $height, weight: $weight, diseaseIds: $diseaseIds, allergyIds: $allergyIds, uploading: $uploading, nicknameError: $nicknameError)';
}


}

/// @nodoc
abstract mixin class _$OnboardingPageStateCopyWith<$Res> implements $OnboardingPageStateCopyWith<$Res> {
  factory _$OnboardingPageStateCopyWith(_OnboardingPageState value, $Res Function(_OnboardingPageState) _then) = __$OnboardingPageStateCopyWithImpl;
@override @useResult
$Res call({
 String? url, String? name, GenderType? gender, String? birth, String? height, String? weight, List<int> diseaseIds, List<int> allergyIds, bool uploading, String? nicknameError
});




}
/// @nodoc
class __$OnboardingPageStateCopyWithImpl<$Res>
    implements _$OnboardingPageStateCopyWith<$Res> {
  __$OnboardingPageStateCopyWithImpl(this._self, this._then);

  final _OnboardingPageState _self;
  final $Res Function(_OnboardingPageState) _then;

/// Create a copy of OnboardingPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? name = freezed,Object? gender = freezed,Object? birth = freezed,Object? height = freezed,Object? weight = freezed,Object? diseaseIds = null,Object? allergyIds = null,Object? uploading = null,Object? nicknameError = freezed,}) {
  return _then(_OnboardingPageState(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderType?,birth: freezed == birth ? _self.birth : birth // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as String?,diseaseIds: null == diseaseIds ? _self._diseaseIds : diseaseIds // ignore: cast_nullable_to_non_nullable
as List<int>,allergyIds: null == allergyIds ? _self._allergyIds : allergyIds // ignore: cast_nullable_to_non_nullable
as List<int>,uploading: null == uploading ? _self.uploading : uploading // ignore: cast_nullable_to_non_nullable
as bool,nicknameError: freezed == nicknameError ? _self.nicknameError : nicknameError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
