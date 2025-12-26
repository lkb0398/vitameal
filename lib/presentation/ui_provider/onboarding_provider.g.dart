// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 수정모드 여부 Provider

@ProviderFor(isEditFlow)
const isEditFlowProvider = IsEditFlowProvider._();

/// 수정모드 여부 Provider

final class IsEditFlowProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 수정모드 여부 Provider
  const IsEditFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isEditFlowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isEditFlowHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isEditFlow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isEditFlowHash() => r'77c4e6f922c3af4e8c8ddb035d0d623f4ab4b763';

/// 온보딩 완료여부 Provider

@ProviderFor(OnboardingState)
const onboardingStateProvider = OnboardingStateProvider._();

/// 온보딩 완료여부 Provider
final class OnboardingStateProvider
    extends $NotifierProvider<OnboardingState, bool> {
  /// 온보딩 완료여부 Provider
  const OnboardingStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingStateHash();

  @$internal
  @override
  OnboardingState create() => OnboardingState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingStateHash() => r'92771166c984c1f183718096bed57d56197531d8';

/// 온보딩 완료여부 Provider

abstract class _$OnboardingState extends $Notifier<bool> {
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

@ProviderFor(onboardingCompleted)
const onboardingCompletedProvider = OnboardingCompletedProvider._();

final class OnboardingCompletedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const OnboardingCompletedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingCompletedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingCompletedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return onboardingCompleted(ref);
  }
}

String _$onboardingCompletedHash() =>
    r'c471ccf943e8ed24762cd020237ee69e5a5246a7';

/// userId Provider

@ProviderFor(currentUserId)
const currentUserIdProvider = CurrentUserIdProvider._();

/// userId Provider

final class CurrentUserIdProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// userId Provider
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

/// 사용자 정보 읽기 전용 Provider

@ProviderFor(myProfile)
const myProfileProvider = MyProfileProvider._();

/// 사용자 정보 읽기 전용 Provider

final class MyProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProfilesEntity?>,
          ProfilesEntity?,
          FutureOr<ProfilesEntity?>
        >
    with $FutureModifier<ProfilesEntity?>, $FutureProvider<ProfilesEntity?> {
  /// 사용자 정보 읽기 전용 Provider
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
