// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_calendar_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 선택된 날짜의 MealEntry 목록을 조회하는 프로바이더
/// TODO : 나중에 state 클래스로 관리하도록 리펙토링

@ProviderFor(mealEntries)
const mealEntriesProvider = MealEntriesFamily._();

/// 선택된 날짜의 MealEntry 목록을 조회하는 프로바이더
/// TODO : 나중에 state 클래스로 관리하도록 리펙토링

final class MealEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MealEntryEntity>>,
          List<MealEntryEntity>,
          FutureOr<List<MealEntryEntity>>
        >
    with
        $FutureModifier<List<MealEntryEntity>>,
        $FutureProvider<List<MealEntryEntity>> {
  /// 선택된 날짜의 MealEntry 목록을 조회하는 프로바이더
  /// TODO : 나중에 state 클래스로 관리하도록 리펙토링
  const MealEntriesProvider._({
    required MealEntriesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'mealEntriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mealEntriesHash();

  @override
  String toString() {
    return r'mealEntriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MealEntryEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MealEntryEntity>> create(Ref ref) {
    final argument = this.argument as String;
    return mealEntries(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MealEntriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mealEntriesHash() => r'75da4b2a16b2b0dbfedcfb0029731050455ec77e';

/// 선택된 날짜의 MealEntry 목록을 조회하는 프로바이더
/// TODO : 나중에 state 클래스로 관리하도록 리펙토링

final class MealEntriesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MealEntryEntity>>, String> {
  const MealEntriesFamily._()
    : super(
        retry: null,
        name: r'mealEntriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 선택된 날짜의 MealEntry 목록을 조회하는 프로바이더
  /// TODO : 나중에 state 클래스로 관리하도록 리펙토링

  MealEntriesProvider call(String mealDayId) =>
      MealEntriesProvider._(argument: mealDayId, from: this);

  @override
  String toString() => r'mealEntriesProvider';
}

@ProviderFor(MealCalendarViewModel)
const mealCalendarViewModelProvider = MealCalendarViewModelFamily._();

final class MealCalendarViewModelProvider
    extends $AsyncNotifierProvider<MealCalendarViewModel, List<MealDayEntity>> {
  const MealCalendarViewModelProvider._({
    required MealCalendarViewModelFamily super.from,
    required (String, DateTime, DateTime) super.argument,
  }) : super(
         retry: null,
         name: r'mealCalendarViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mealCalendarViewModelHash();

  @override
  String toString() {
    return r'mealCalendarViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  MealCalendarViewModel create() => MealCalendarViewModel();

  @override
  bool operator ==(Object other) {
    return other is MealCalendarViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mealCalendarViewModelHash() =>
    r'1bb72093f7d0e1d2f4a2c443cbe50faadec6f9f6';

final class MealCalendarViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          MealCalendarViewModel,
          AsyncValue<List<MealDayEntity>>,
          List<MealDayEntity>,
          FutureOr<List<MealDayEntity>>,
          (String, DateTime, DateTime)
        > {
  const MealCalendarViewModelFamily._()
    : super(
        retry: null,
        name: r'mealCalendarViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MealCalendarViewModelProvider call(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) => MealCalendarViewModelProvider._(
    argument: (userId, startDate, endDate),
    from: this,
  );

  @override
  String toString() => r'mealCalendarViewModelProvider';
}

abstract class _$MealCalendarViewModel
    extends $AsyncNotifier<List<MealDayEntity>> {
  late final _$args = ref.$arg as (String, DateTime, DateTime);
  String get userId => _$args.$1;
  DateTime get startDate => _$args.$2;
  DateTime get endDate => _$args.$3;

  FutureOr<List<MealDayEntity>> build(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2, _$args.$3);
    final ref =
        this.ref as $Ref<AsyncValue<List<MealDayEntity>>, List<MealDayEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MealDayEntity>>, List<MealDayEntity>>,
              AsyncValue<List<MealDayEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
