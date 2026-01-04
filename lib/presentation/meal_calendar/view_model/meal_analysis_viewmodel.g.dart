// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_analysis_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MealAnalysisViewModel)
const mealAnalysisViewModelProvider = MealAnalysisViewModelProvider._();

final class MealAnalysisViewModelProvider
    extends $NotifierProvider<MealAnalysisViewModel, void> {
  const MealAnalysisViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealAnalysisViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealAnalysisViewModelHash();

  @$internal
  @override
  MealAnalysisViewModel create() => MealAnalysisViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$mealAnalysisViewModelHash() =>
    r'23c1c7e432f3f2cfc5beaf607d85efad3e840532';

abstract class _$MealAnalysisViewModel extends $Notifier<void> {
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
