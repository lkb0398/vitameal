// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoalViewModel)
const goalViewModelProvider = GoalViewModelProvider._();

final class GoalViewModelProvider
    extends $NotifierProvider<GoalViewModel, void> {
  const GoalViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalViewModelHash();

  @$internal
  @override
  GoalViewModel create() => GoalViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$goalViewModelHash() => r'a5b4cf8d08a46914eb5d6ae382f3ad7416f9a6f7';

abstract class _$GoalViewModel extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
