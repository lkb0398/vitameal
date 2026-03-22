// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eats_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ViewModel

@ProviderFor(EatsViewModel)
const eatsViewModelProvider = EatsViewModelProvider._();

/// ViewModel
final class EatsViewModelProvider
    extends $NotifierProvider<EatsViewModel, EatsState> {
  /// ViewModel
  const EatsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eatsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eatsViewModelHash();

  @$internal
  @override
  EatsViewModel create() => EatsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EatsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EatsState>(value),
    );
  }
}

String _$eatsViewModelHash() => r'd031d9619850cf290a5d7d630d5cc437d8a10624';

/// ViewModel

abstract class _$EatsViewModel extends $Notifier<EatsState> {
  EatsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EatsState, EatsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EatsState, EatsState>,
              EatsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
