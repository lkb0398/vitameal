// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_notation_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DateNotationViewModel)
const dateNotationViewModelProvider = DateNotationViewModelProvider._();

final class DateNotationViewModelProvider
    extends $NotifierProvider<DateNotationViewModel, DateNotationType?> {
  const DateNotationViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dateNotationViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dateNotationViewModelHash();

  @$internal
  @override
  DateNotationViewModel create() => DateNotationViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateNotationType? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateNotationType?>(value),
    );
  }
}

String _$dateNotationViewModelHash() =>
    r'117df4dee79378a0aaca3d0c534945b893f2a231';

abstract class _$DateNotationViewModel extends $Notifier<DateNotationType?> {
  DateNotationType? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateNotationType?, DateNotationType?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateNotationType?, DateNotationType?>,
              DateNotationType?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
