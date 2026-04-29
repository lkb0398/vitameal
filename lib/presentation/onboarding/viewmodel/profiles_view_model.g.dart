// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfilesViewModel)
const profilesViewModelProvider = ProfilesViewModelProvider._();

final class ProfilesViewModelProvider
    extends $AsyncNotifierProvider<ProfilesViewModel, ProfilesEntity?> {
  const ProfilesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profilesViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profilesViewModelHash();

  @$internal
  @override
  ProfilesViewModel create() => ProfilesViewModel();
}

String _$profilesViewModelHash() => r'42626591c09bfc109f96f5c03c6c7d878fa1399b';

abstract class _$ProfilesViewModel extends $AsyncNotifier<ProfilesEntity?> {
  FutureOr<ProfilesEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ProfilesEntity?>, ProfilesEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfilesEntity?>, ProfilesEntity?>,
              AsyncValue<ProfilesEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
