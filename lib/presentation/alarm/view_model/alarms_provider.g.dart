// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 전체 알람 가져오기 Provider

@ProviderFor(getAllAlarms)
const getAllAlarmsProvider = GetAllAlarmsProvider._();

/// 전체 알람 가져오기 Provider

final class GetAllAlarmsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AlarmsEntity>?>,
          List<AlarmsEntity>?,
          FutureOr<List<AlarmsEntity>?>
        >
    with
        $FutureModifier<List<AlarmsEntity>?>,
        $FutureProvider<List<AlarmsEntity>?> {
  /// 전체 알람 가져오기 Provider
  const GetAllAlarmsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllAlarmsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllAlarmsHash();

  @$internal
  @override
  $FutureProviderElement<List<AlarmsEntity>?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AlarmsEntity>?> create(Ref ref) {
    return getAllAlarms(ref);
  }
}

String _$getAllAlarmsHash() => r'b0e19250198bbbcd31b04f3e72d0eeaa397584d6';
