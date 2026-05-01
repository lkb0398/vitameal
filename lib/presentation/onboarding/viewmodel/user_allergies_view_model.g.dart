// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_allergies_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserAllergiesViewModel)
const userAllergiesViewModelProvider = UserAllergiesViewModelProvider._();

final class UserAllergiesViewModelProvider
    extends $AsyncNotifierProvider<UserAllergiesViewModel, List<int>> {
  const UserAllergiesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAllergiesViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAllergiesViewModelHash();

  @$internal
  @override
  UserAllergiesViewModel create() => UserAllergiesViewModel();
}

String _$userAllergiesViewModelHash() =>
    r'433442daa684159f10d69b230ec907c701499373';

abstract class _$UserAllergiesViewModel extends $AsyncNotifier<List<int>> {
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
