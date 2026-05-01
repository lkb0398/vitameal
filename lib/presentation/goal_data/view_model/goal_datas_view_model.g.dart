// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_datas_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoalDatasViewModel)
const goalDatasViewModelProvider = GoalDatasViewModelFamily._();

final class GoalDatasViewModelProvider
    extends $AsyncNotifierProvider<GoalDatasViewModel, List<GoalDatasEntity>?> {
  const GoalDatasViewModelProvider._({
    required GoalDatasViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'goalDatasViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$goalDatasViewModelHash();

  @override
  String toString() {
    return r'goalDatasViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GoalDatasViewModel create() => GoalDatasViewModel();

  @override
  bool operator ==(Object other) {
    return other is GoalDatasViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$goalDatasViewModelHash() =>
    r'9a0b960cc4d9a9153ae9a5be2a94c01fcb4f16b0';

final class GoalDatasViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          GoalDatasViewModel,
          AsyncValue<List<GoalDatasEntity>?>,
          List<GoalDatasEntity>?,
          FutureOr<List<GoalDatasEntity>?>,
          String
        > {
  const GoalDatasViewModelFamily._()
    : super(
        retry: null,
        name: r'goalDatasViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  GoalDatasViewModelProvider call({required String goalId}) =>
      GoalDatasViewModelProvider._(argument: goalId, from: this);

  @override
  String toString() => r'goalDatasViewModelProvider';
}

abstract class _$GoalDatasViewModel
    extends $AsyncNotifier<List<GoalDatasEntity>?> {
  late final _$args = ref.$arg as String;
  String get goalId => _$args;

  FutureOr<List<GoalDatasEntity>?> build({required String goalId});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(goalId: _$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<GoalDatasEntity>?>, List<GoalDatasEntity>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<GoalDatasEntity>?>,
                List<GoalDatasEntity>?
              >,
              AsyncValue<List<GoalDatasEntity>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
