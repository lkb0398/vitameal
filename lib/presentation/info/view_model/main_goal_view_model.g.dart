// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_goal_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MainGoalViewModel)
const mainGoalViewModelProvider = MainGoalViewModelProvider._();

final class MainGoalViewModelProvider
    extends $NotifierProvider<MainGoalViewModel, MainGoalState> {
  const MainGoalViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainGoalViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainGoalViewModelHash();

  @$internal
  @override
  MainGoalViewModel create() => MainGoalViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MainGoalState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MainGoalState>(value),
    );
  }
}

String _$mainGoalViewModelHash() => r'4a99c784a9eef6ffd721b385caae20e93e362f10';

abstract class _$MainGoalViewModel extends $Notifier<MainGoalState> {
  MainGoalState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MainGoalState, MainGoalState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MainGoalState, MainGoalState>,
              MainGoalState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
