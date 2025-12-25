// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 액션 전용 ViewModel

@ProviderFor(SetViewModel)
const setViewModelProvider = SetViewModelProvider._();

/// 액션 전용 ViewModel
final class SetViewModelProvider extends $NotifierProvider<SetViewModel, void> {
  /// 액션 전용 ViewModel
  const SetViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setViewModelHash();

  @$internal
  @override
  SetViewModel create() => SetViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$setViewModelHash() => r'8abafd1f13b041ced0121b39bd7c0efd88cb1f08';

/// 액션 전용 ViewModel

abstract class _$SetViewModel extends $Notifier<void> {
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
