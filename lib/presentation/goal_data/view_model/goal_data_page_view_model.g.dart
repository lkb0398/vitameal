// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_data_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoalDataPageViewModel)
const goalDataPageViewModelProvider = GoalDataPageViewModelFamily._();

final class GoalDataPageViewModelProvider
    extends $NotifierProvider<GoalDataPageViewModel, GoalDataPageState> {
  const GoalDataPageViewModelProvider._({
    required GoalDataPageViewModelFamily super.from,
    required GoalsEntity super.argument,
  }) : super(
         retry: null,
         name: r'goalDataPageViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$goalDataPageViewModelHash();

  @override
  String toString() {
    return r'goalDataPageViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GoalDataPageViewModel create() => GoalDataPageViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalDataPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalDataPageState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GoalDataPageViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$goalDataPageViewModelHash() =>
    r'1f85b8f96d01437ce7205727ef27370fdeea7a19';

final class GoalDataPageViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          GoalDataPageViewModel,
          GoalDataPageState,
          GoalDataPageState,
          GoalDataPageState,
          GoalsEntity
        > {
  const GoalDataPageViewModelFamily._()
    : super(
        retry: null,
        name: r'goalDataPageViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GoalDataPageViewModelProvider call({required GoalsEntity selectedGoal}) =>
      GoalDataPageViewModelProvider._(argument: selectedGoal, from: this);

  @override
  String toString() => r'goalDataPageViewModelProvider';
}

abstract class _$GoalDataPageViewModel extends $Notifier<GoalDataPageState> {
  late final _$args = ref.$arg as GoalsEntity;
  GoalsEntity get selectedGoal => _$args;

  GoalDataPageState build({required GoalsEntity selectedGoal});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(selectedGoal: _$args);
    final ref = this.ref as $Ref<GoalDataPageState, GoalDataPageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoalDataPageState, GoalDataPageState>,
              GoalDataPageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
