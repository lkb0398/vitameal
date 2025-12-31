// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_goals_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserGoalsViewModel)
const userGoalsViewModelProvider = UserGoalsViewModelProvider._();

final class UserGoalsViewModelProvider
    extends $NotifierProvider<UserGoalsViewModel, void> {
  const UserGoalsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userGoalsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userGoalsViewModelHash();

  @$internal
  @override
  UserGoalsViewModel create() => UserGoalsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$userGoalsViewModelHash() =>
    r'5b2041721535c7abdf58cb41bdb7ef4b4b91bc09';

abstract class _$UserGoalsViewModel extends $Notifier<void> {
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
