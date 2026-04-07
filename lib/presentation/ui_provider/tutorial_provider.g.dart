// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 식단 기록 페이지 튜토리얼 완료 여부 provider

@ProviderFor(MealTutorialShown)
const mealTutorialShownProvider = MealTutorialShownProvider._();

/// 식단 기록 페이지 튜토리얼 완료 여부 provider
final class MealTutorialShownProvider
    extends $AsyncNotifierProvider<MealTutorialShown, bool> {
  /// 식단 기록 페이지 튜토리얼 완료 여부 provider
  const MealTutorialShownProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealTutorialShownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealTutorialShownHash();

  @$internal
  @override
  MealTutorialShown create() => MealTutorialShown();
}

String _$mealTutorialShownHash() => r'148e9fa6f006cb8ded581e71ef42ec87a685ce70';

/// 식단 기록 페이지 튜토리얼 완료 여부 provider

abstract class _$MealTutorialShown extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
