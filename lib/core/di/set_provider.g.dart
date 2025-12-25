// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// UI 상태 (수정모드) Provider

@ProviderFor(IsEditing)
const isEditingProvider = IsEditingProvider._();

/// UI 상태 (수정모드) Provider
final class IsEditingProvider extends $NotifierProvider<IsEditing, bool> {
  /// UI 상태 (수정모드) Provider
  const IsEditingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isEditingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isEditingHash();

  @$internal
  @override
  IsEditing create() => IsEditing();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isEditingHash() => r'9303d0d1727e973f5477074b905a9e1fe9a3f83d';

/// UI 상태 (수정모드) Provider

abstract class _$IsEditing extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 인증/세션 (userId) Provider

@ProviderFor(currentUserId)
const currentUserIdProvider = CurrentUserIdProvider._();

/// 인증/세션 (userId) Provider

final class CurrentUserIdProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// 인증/세션 (userId) Provider
  const CurrentUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserIdHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return currentUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentUserIdHash() => r'53e36a8b79d432a69abb79cd85449ab0b1142454';

/// 읽기 전용 Provider

@ProviderFor(myProfile)
const myProfileProvider = MyProfileProvider._();

/// 읽기 전용 Provider

final class MyProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProfilesEntity?>,
          ProfilesEntity?,
          FutureOr<ProfilesEntity?>
        >
    with $FutureModifier<ProfilesEntity?>, $FutureProvider<ProfilesEntity?> {
  /// 읽기 전용 Provider
  const MyProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProfileHash();

  @$internal
  @override
  $FutureProviderElement<ProfilesEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ProfilesEntity?> create(Ref ref) {
    return myProfile(ref);
  }
}

String _$myProfileHash() => r'0614a4c0b8b7c640f06b0ac1e842de7b245ea8f1';

@ProviderFor(diseasesList)
const diseasesListProvider = DiseasesListProvider._();

final class DiseasesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DiseasesEntity>>,
          List<DiseasesEntity>,
          FutureOr<List<DiseasesEntity>>
        >
    with
        $FutureModifier<List<DiseasesEntity>>,
        $FutureProvider<List<DiseasesEntity>> {
  const DiseasesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diseasesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diseasesListHash();

  @$internal
  @override
  $FutureProviderElement<List<DiseasesEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DiseasesEntity>> create(Ref ref) {
    return diseasesList(ref);
  }
}

String _$diseasesListHash() => r'cb398f907aab939ef212b531b2ba29e374f659ea';

@ProviderFor(userSelectedDiseases)
const userSelectedDiseasesProvider = UserSelectedDiseasesProvider._();

final class UserSelectedDiseasesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  const UserSelectedDiseasesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSelectedDiseasesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSelectedDiseasesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return userSelectedDiseases(ref);
  }
}

String _$userSelectedDiseasesHash() =>
    r'5c4a0748e96397731d715657f676bc822644c7d5';

@ProviderFor(allergiesList)
const allergiesListProvider = AllergiesListProvider._();

final class AllergiesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AllergiesEntity>>,
          List<AllergiesEntity>,
          FutureOr<List<AllergiesEntity>>
        >
    with
        $FutureModifier<List<AllergiesEntity>>,
        $FutureProvider<List<AllergiesEntity>> {
  const AllergiesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allergiesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allergiesListHash();

  @$internal
  @override
  $FutureProviderElement<List<AllergiesEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AllergiesEntity>> create(Ref ref) {
    return allergiesList(ref);
  }
}

String _$allergiesListHash() => r'2f1c779c3756b91966a4556d2c4c6d0bb4b946fe';

@ProviderFor(userSelectedAllergies)
const userSelectedAllergiesProvider = UserSelectedAllergiesProvider._();

final class UserSelectedAllergiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  const UserSelectedAllergiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSelectedAllergiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSelectedAllergiesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return userSelectedAllergies(ref);
  }
}

String _$userSelectedAllergiesHash() =>
    r'a70f21c8383c6a42eda912fd0ecdbdb1df94e561';
