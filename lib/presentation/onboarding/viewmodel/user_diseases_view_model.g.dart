// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_diseases_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserDiseasesViewModel)
const userDiseasesViewModelProvider = UserDiseasesViewModelProvider._();

final class UserDiseasesViewModelProvider
    extends $AsyncNotifierProvider<UserDiseasesViewModel, List<int>> {
  const UserDiseasesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDiseasesViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDiseasesViewModelHash();

  @$internal
  @override
  UserDiseasesViewModel create() => UserDiseasesViewModel();
}

String _$userDiseasesViewModelHash() =>
    r'91f939195241cd53622a3735858f83f7dc00a06b';

abstract class _$UserDiseasesViewModel extends $AsyncNotifier<List<int>> {
  FutureOr<List<int>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<int>>, List<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<int>>, List<int>>,
              AsyncValue<List<int>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
