// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 현재 Location 얻기 Provider

@ProviderFor(routerLocation)
const routerLocationProvider = RouterLocationProvider._();

/// 현재 Location 얻기 Provider

final class RouterLocationProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// 현재 Location 얻기 Provider
  const RouterLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerLocationHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return routerLocation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$routerLocationHash() => r'f0773dde6d6d0beca1cb5e420b7e28ee8cdf5395';
