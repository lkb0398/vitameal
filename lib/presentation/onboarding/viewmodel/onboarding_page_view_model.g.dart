// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingPageViewModel)
const onboardingPageViewModelProvider = OnboardingPageViewModelProvider._();

final class OnboardingPageViewModelProvider
    extends $NotifierProvider<OnboardingPageViewModel, OnboardingPageState> {
  const OnboardingPageViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingPageViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingPageViewModelHash();

  @$internal
  @override
  OnboardingPageViewModel create() => OnboardingPageViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingPageState>(value),
    );
  }
}

String _$onboardingPageViewModelHash() =>
    r'70d9702cd2cb923dfa01218c515e6f1a479d1b37';

abstract class _$OnboardingPageViewModel
    extends $Notifier<OnboardingPageState> {
  OnboardingPageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<OnboardingPageState, OnboardingPageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OnboardingPageState, OnboardingPageState>,
              OnboardingPageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
