// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_calendar_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MealCalendarViewModel)
const mealCalendarViewModelProvider = MealCalendarViewModelFamily._();

final class MealCalendarViewModelProvider
    extends
        $StreamNotifierProvider<MealCalendarViewModel, List<MealDayEntity>> {
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
    r'83ed0f05797e211e7956a347cebbb3f9dd76957f';

final class MealCalendarViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          MealCalendarViewModel,
          AsyncValue<List<MealDayEntity>>,
          List<MealDayEntity>,
          Stream<List<MealDayEntity>>,
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
    extends $StreamNotifier<List<MealDayEntity>> {
  late final _$args = ref.$arg as (String, DateTime, DateTime);
  String get userId => _$args.$1;
  DateTime get startDate => _$args.$2;
  DateTime get endDate => _$args.$3;

  Stream<List<MealDayEntity>> build(
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
