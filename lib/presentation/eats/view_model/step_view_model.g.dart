// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StepViewModel)
const stepViewModelProvider = StepViewModelProvider._();

final class StepViewModelProvider
    extends $NotifierProvider<StepViewModel, ({double calories, int steps})> {
  const StepViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stepViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stepViewModelHash();

  @$internal
  @override
  StepViewModel create() => StepViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({double calories, int steps}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({double calories, int steps})>(
        value,
      ),
    );
  }
}

String _$stepViewModelHash() => r'30058c524129648b6fce610ece6e3726556a0f98';

abstract class _$StepViewModel
    extends $Notifier<({double calories, int steps})> {
  ({double calories, int steps}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              ({double calories, int steps}),
              ({double calories, int steps})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({double calories, int steps}),
                ({double calories, int steps})
              >,
              ({double calories, int steps}),
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
