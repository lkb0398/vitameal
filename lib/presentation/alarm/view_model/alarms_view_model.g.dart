// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarms_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AlarmsViewModel)
const alarmsViewModelProvider = AlarmsViewModelProvider._();

final class AlarmsViewModelProvider
    extends $NotifierProvider<AlarmsViewModel, void> {
  const AlarmsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmsViewModelHash();

  @$internal
  @override
  AlarmsViewModel create() => AlarmsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$alarmsViewModelHash() => r'a2426abbb76b8eee55eaa10cfc01a43ee0183913';

abstract class _$AlarmsViewModel extends $Notifier<void> {
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
