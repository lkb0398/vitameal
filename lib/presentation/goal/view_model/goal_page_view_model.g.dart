// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoalPageViewModel)
const goalPageViewModelProvider = GoalPageViewModelFamily._();

final class GoalPageViewModelProvider
    extends $NotifierProvider<GoalPageViewModel, GoalPageState> {
  const GoalPageViewModelProvider._({
    required GoalPageViewModelFamily super.from,
    required GoalsEntity? super.argument,
  }) : super(
         retry: null,
         name: r'goalPageViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$goalPageViewModelHash();

  @override
  String toString() {
    return r'goalPageViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GoalPageViewModel create() => GoalPageViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalPageState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GoalPageViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$goalPageViewModelHash() => r'da8d47f02c940be6407762438aa94b2a8990c56b';

final class GoalPageViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          GoalPageViewModel,
          GoalPageState,
          GoalPageState,
          GoalPageState,
          GoalsEntity?
        > {
  const GoalPageViewModelFamily._()
    : super(
        retry: null,
        name: r'goalPageViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GoalPageViewModelProvider call({required GoalsEntity? goal}) =>
      GoalPageViewModelProvider._(argument: goal, from: this);

  @override
  String toString() => r'goalPageViewModelProvider';
}

abstract class _$GoalPageViewModel extends $Notifier<GoalPageState> {
  late final _$args = ref.$arg as GoalsEntity?;
  GoalsEntity? get goal => _$args;

  GoalPageState build({required GoalsEntity? goal});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(goal: _$args);
    final ref = this.ref as $Ref<GoalPageState, GoalPageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoalPageState, GoalPageState>,
              GoalPageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
