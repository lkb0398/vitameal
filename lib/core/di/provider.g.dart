// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Supabase Client

@ProviderFor(supabaseClient)
const supabaseClientProvider = SupabaseClientProvider._();

/// Supabase Client

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  /// Supabase Client
  const SupabaseClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseClientHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabaseClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseClientHash() => r'834a58d6ae4b94e36f4e04a10d8a7684b929310e';

/// DataSource

@ProviderFor(profilesDataSource)
const profilesDataSourceProvider = ProfilesDataSourceProvider._();

/// DataSource

final class ProfilesDataSourceProvider
    extends
        $FunctionalProvider<
          ProfilesDataSource,
          ProfilesDataSource,
          ProfilesDataSource
        >
    with $Provider<ProfilesDataSource> {
  /// DataSource
  const ProfilesDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profilesDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profilesDataSourceHash();

  @$internal
  @override
  $ProviderElement<ProfilesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfilesDataSource create(Ref ref) {
    return profilesDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfilesDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfilesDataSource>(value),
    );
  }
}

String _$profilesDataSourceHash() =>
    r'30aae55e04069365c11dd90155ce8c67a3d49a62';

@ProviderFor(userDiseasesDataSource)
const userDiseasesDataSourceProvider = UserDiseasesDataSourceProvider._();

final class UserDiseasesDataSourceProvider
    extends
        $FunctionalProvider<
          UserDiseasesDataSource,
          UserDiseasesDataSource,
          UserDiseasesDataSource
        >
    with $Provider<UserDiseasesDataSource> {
  const UserDiseasesDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDiseasesDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDiseasesDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserDiseasesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserDiseasesDataSource create(Ref ref) {
    return userDiseasesDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserDiseasesDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserDiseasesDataSource>(value),
    );
  }
}

String _$userDiseasesDataSourceHash() =>
    r'eba12f69a75c2d31a44fa445bb920ec101d7efb9';

@ProviderFor(diseasesDataSource)
const diseasesDataSourceProvider = DiseasesDataSourceProvider._();

final class DiseasesDataSourceProvider
    extends
        $FunctionalProvider<
          DiseasesDataSource,
          DiseasesDataSource,
          DiseasesDataSource
        >
    with $Provider<DiseasesDataSource> {
  const DiseasesDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diseasesDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diseasesDataSourceHash();

  @$internal
  @override
  $ProviderElement<DiseasesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DiseasesDataSource create(Ref ref) {
    return diseasesDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiseasesDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiseasesDataSource>(value),
    );
  }
}

String _$diseasesDataSourceHash() =>
    r'7311d0154d69a4c9c0539d89ea0fe3dcbd207afc';

@ProviderFor(userAllergiesDataSource)
const userAllergiesDataSourceProvider = UserAllergiesDataSourceProvider._();

final class UserAllergiesDataSourceProvider
    extends
        $FunctionalProvider<
          UserAllergiesDataSource,
          UserAllergiesDataSource,
          UserAllergiesDataSource
        >
    with $Provider<UserAllergiesDataSource> {
  const UserAllergiesDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAllergiesDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAllergiesDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserAllergiesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserAllergiesDataSource create(Ref ref) {
    return userAllergiesDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAllergiesDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAllergiesDataSource>(value),
    );
  }
}

String _$userAllergiesDataSourceHash() =>
    r'60add92dc17acb72a0a786b1bedbd93d9ace5927';

@ProviderFor(allergiesDataSource)
const allergiesDataSourceProvider = AllergiesDataSourceProvider._();

final class AllergiesDataSourceProvider
    extends
        $FunctionalProvider<
          AllergiesDataSource,
          AllergiesDataSource,
          AllergiesDataSource
        >
    with $Provider<AllergiesDataSource> {
  const AllergiesDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allergiesDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allergiesDataSourceHash();

  @$internal
  @override
  $ProviderElement<AllergiesDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AllergiesDataSource create(Ref ref) {
    return allergiesDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AllergiesDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AllergiesDataSource>(value),
    );
  }
}

String _$allergiesDataSourceHash() =>
    r'3a9ed2f77f37d387165b860a0d742f6b7cf6b125';

/// Repository

@ProviderFor(profilesRepository)
const profilesRepositoryProvider = ProfilesRepositoryProvider._();

/// Repository

final class ProfilesRepositoryProvider
    extends
        $FunctionalProvider<
          ProfilesRepository,
          ProfilesRepository,
          ProfilesRepository
        >
    with $Provider<ProfilesRepository> {
  /// Repository
  const ProfilesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profilesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profilesRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfilesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfilesRepository create(Ref ref) {
    return profilesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfilesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfilesRepository>(value),
    );
  }
}

String _$profilesRepositoryHash() =>
    r'7ff6d8926664bccda7add95dc573e13be8b2fd62';

@ProviderFor(userDiseasesRepository)
const userDiseasesRepositoryProvider = UserDiseasesRepositoryProvider._();

final class UserDiseasesRepositoryProvider
    extends
        $FunctionalProvider<
          UserDiseasesRepository,
          UserDiseasesRepository,
          UserDiseasesRepository
        >
    with $Provider<UserDiseasesRepository> {
  const UserDiseasesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDiseasesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDiseasesRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserDiseasesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserDiseasesRepository create(Ref ref) {
    return userDiseasesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserDiseasesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserDiseasesRepository>(value),
    );
  }
}

String _$userDiseasesRepositoryHash() =>
    r'c8c2ab2c4827fab365be8db8a5fc8dd60e735521';

@ProviderFor(diseasesRepository)
const diseasesRepositoryProvider = DiseasesRepositoryProvider._();

final class DiseasesRepositoryProvider
    extends
        $FunctionalProvider<
          DiseasesRepository,
          DiseasesRepository,
          DiseasesRepository
        >
    with $Provider<DiseasesRepository> {
  const DiseasesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diseasesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diseasesRepositoryHash();

  @$internal
  @override
  $ProviderElement<DiseasesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DiseasesRepository create(Ref ref) {
    return diseasesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiseasesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiseasesRepository>(value),
    );
  }
}

String _$diseasesRepositoryHash() =>
    r'2a49e747c22713d4d01262e03bd3fe0b70a2f04b';

@ProviderFor(userAllergiesRepository)
const userAllergiesRepositoryProvider = UserAllergiesRepositoryProvider._();

final class UserAllergiesRepositoryProvider
    extends
        $FunctionalProvider<
          UserAllergiesRepository,
          UserAllergiesRepository,
          UserAllergiesRepository
        >
    with $Provider<UserAllergiesRepository> {
  const UserAllergiesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAllergiesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAllergiesRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserAllergiesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserAllergiesRepository create(Ref ref) {
    return userAllergiesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAllergiesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAllergiesRepository>(value),
    );
  }
}

String _$userAllergiesRepositoryHash() =>
    r'c6516d9dda75205a9d59f94f1430b228ff8a45f9';

@ProviderFor(allergiesRepository)
const allergiesRepositoryProvider = AllergiesRepositoryProvider._();

final class AllergiesRepositoryProvider
    extends
        $FunctionalProvider<
          AllergiesRepository,
          AllergiesRepository,
          AllergiesRepository
        >
    with $Provider<AllergiesRepository> {
  const AllergiesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allergiesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allergiesRepositoryHash();

  @$internal
  @override
  $ProviderElement<AllergiesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AllergiesRepository create(Ref ref) {
    return allergiesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AllergiesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AllergiesRepository>(value),
    );
  }
}

String _$allergiesRepositoryHash() =>
    r'774f4f8117b569bc29d92c0ee796d97752a1544b';
