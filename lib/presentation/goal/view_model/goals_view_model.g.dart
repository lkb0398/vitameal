// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoalsViewModel)
const goalsViewModelProvider = GoalsViewModelProvider._();

final class GoalsViewModelProvider
    extends $AsyncNotifierProvider<GoalsViewModel, List<GoalsEntity>?> {
  const GoalsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsViewModelHash();

  @$internal
  @override
  GoalsViewModel create() => GoalsViewModel();
}

String _$goalsViewModelHash() => r'4bb43f97263b2ac950c29a03ca2eeac6febadafc';

abstract class _$GoalsViewModel extends $AsyncNotifier<List<GoalsEntity>?> {
  FutureOr<List<GoalsEntity>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<GoalsEntity>?>, List<GoalsEntity>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GoalsEntity>?>, List<GoalsEntity>?>,
              AsyncValue<List<GoalsEntity>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
