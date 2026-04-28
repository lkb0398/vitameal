// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formatted_date_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 사용자가 선택한 날짜 형식에 따른 String 변환 provider

@ProviderFor(formattedDate)
const formattedDateProvider = FormattedDateFamily._();

/// 사용자가 선택한 날짜 형식에 따른 String 변환 provider

final class FormattedDateProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// 사용자가 선택한 날짜 형식에 따른 String 변환 provider
  const FormattedDateProvider._({
    required FormattedDateFamily super.from,
    required (DateTime, {bool showYear}) super.argument,
  }) : super(
         retry: null,
         name: r'formattedDateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$formattedDateHash();

  @override
  String toString() {
    return r'formattedDateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    final argument = this.argument as (DateTime, {bool showYear});
    return formattedDate(ref, argument.$1, showYear: argument.showYear);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FormattedDateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$formattedDateHash() => r'94f6054d0752719be95a59cb3c199f96e5e524a8';

/// 사용자가 선택한 날짜 형식에 따른 String 변환 provider

final class FormattedDateFamily extends $Family
    with $FunctionalFamilyOverride<String, (DateTime, {bool showYear})> {
  const FormattedDateFamily._()
    : super(
        retry: null,
        name: r'formattedDateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 사용자가 선택한 날짜 형식에 따른 String 변환 provider

  FormattedDateProvider call(DateTime date, {bool showYear = true}) =>
      FormattedDateProvider._(argument: (date, showYear: showYear), from: this);

  @override
  String toString() => r'formattedDateProvider';
}
