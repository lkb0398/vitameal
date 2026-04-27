// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationPageViewModel)
const notificationPageViewModelProvider = NotificationPageViewModelFamily._();

final class NotificationPageViewModelProvider
    extends
        $NotifierProvider<NotificationPageViewModel, NotificationPageState> {
  const NotificationPageViewModelProvider._({
    required NotificationPageViewModelFamily super.from,
    required NotificationsEntity? super.argument,
  }) : super(
         retry: null,
         name: r'notificationPageViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$notificationPageViewModelHash();

  @override
  String toString() {
    return r'notificationPageViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NotificationPageViewModel create() => NotificationPageViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationPageState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NotificationPageViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$notificationPageViewModelHash() =>
    r'3002cc56c7f03dd4237d4276a45c633c58ae2aaa';

final class NotificationPageViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          NotificationPageViewModel,
          NotificationPageState,
          NotificationPageState,
          NotificationPageState,
          NotificationsEntity?
        > {
  const NotificationPageViewModelFamily._()
    : super(
        retry: null,
        name: r'notificationPageViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NotificationPageViewModelProvider call({
    required NotificationsEntity? noti,
  }) => NotificationPageViewModelProvider._(argument: noti, from: this);

  @override
  String toString() => r'notificationPageViewModelProvider';
}

abstract class _$NotificationPageViewModel
    extends $Notifier<NotificationPageState> {
  late final _$args = ref.$arg as NotificationsEntity?;
  NotificationsEntity? get noti => _$args;

  NotificationPageState build({required NotificationsEntity? noti});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(noti: _$args);
    final ref = this.ref as $Ref<NotificationPageState, NotificationPageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NotificationPageState, NotificationPageState>,
              NotificationPageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
