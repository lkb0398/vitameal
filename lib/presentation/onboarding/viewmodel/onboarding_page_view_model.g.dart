// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingPageViewModel)
const onboardingPageViewModelProvider = OnboardingPageViewModelFamily._();

final class OnboardingPageViewModelProvider
    extends $NotifierProvider<OnboardingPageViewModel, OnboardingPageState> {
  const OnboardingPageViewModelProvider._({
    required OnboardingPageViewModelFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'onboardingPageViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$onboardingPageViewModelHash();

  @override
  String toString() {
    return r'onboardingPageViewModelProvider'
        ''
        '($argument)';
  }

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

  @override
  bool operator ==(Object other) {
    return other is OnboardingPageViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$onboardingPageViewModelHash() =>
    r'5345642245d9ef5631f1f1b3e96cbe1b550568fb';

final class OnboardingPageViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          OnboardingPageViewModel,
          OnboardingPageState,
          OnboardingPageState,
          OnboardingPageState,
          bool
        > {
  const OnboardingPageViewModelFamily._()
    : super(
        retry: null,
        name: r'onboardingPageViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OnboardingPageViewModelProvider call(bool isEditMode) =>
      OnboardingPageViewModelProvider._(argument: isEditMode, from: this);

  @override
  String toString() => r'onboardingPageViewModelProvider';
}

abstract class _$OnboardingPageViewModel
    extends $Notifier<OnboardingPageState> {
  late final _$args = ref.$arg as bool;
  bool get isEditMode => _$args;

  OnboardingPageState build(bool isEditMode);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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
