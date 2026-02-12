// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocaleViewModel)
const localeViewModelProvider = LocaleViewModelProvider._();

final class LocaleViewModelProvider
    extends $NotifierProvider<LocaleViewModel, Locale?> {
  const LocaleViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeViewModelHash();

  @$internal
  @override
  LocaleViewModel create() => LocaleViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale?>(value),
    );
  }
}

String _$localeViewModelHash() => r'46575e63f2224ea698430f7ab6191ed02bbadc84';

abstract class _$LocaleViewModel extends $Notifier<Locale?> {
  Locale? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Locale?, Locale?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale?, Locale?>,
              Locale?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
