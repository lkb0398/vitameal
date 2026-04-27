// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationsViewModel)
const notificationsViewModelProvider = NotificationsViewModelProvider._();

final class NotificationsViewModelProvider
    extends
        $AsyncNotifierProvider<
          NotificationsViewModel,
          List<NotificationsEntity>?
        > {
  const NotificationsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsViewModelHash();

  @$internal
  @override
  NotificationsViewModel create() => NotificationsViewModel();
}

String _$notificationsViewModelHash() =>
    r'3bb5a6abc991f9d7bb33ecb454e57a5b1c709971';

abstract class _$NotificationsViewModel
    extends $AsyncNotifier<List<NotificationsEntity>?> {
  FutureOr<List<NotificationsEntity>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<NotificationsEntity>?>,
              List<NotificationsEntity>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NotificationsEntity>?>,
                List<NotificationsEntity>?
              >,
              AsyncValue<List<NotificationsEntity>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
