// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_tag_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HealthTagViewModel)
const healthTagViewModelProvider = HealthTagViewModelProvider._();

final class HealthTagViewModelProvider
    extends $AsyncNotifierProvider<HealthTagViewModel, List<HealthTag>> {
  const HealthTagViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthTagViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthTagViewModelHash();

  @$internal
  @override
  HealthTagViewModel create() => HealthTagViewModel();
}

String _$healthTagViewModelHash() =>
    r'b824530f9f95ba325383dee4e6c280c203a22521';

abstract class _$HealthTagViewModel extends $AsyncNotifier<List<HealthTag>> {
  FutureOr<List<HealthTag>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<HealthTag>>, List<HealthTag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<HealthTag>>, List<HealthTag>>,
              AsyncValue<List<HealthTag>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
