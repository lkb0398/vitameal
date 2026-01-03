// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 🤍 Supabase Client

@ProviderFor(supabaseClient)
const supabaseClientProvider = SupabaseClientProvider._();

/// 🤍 Supabase Client

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  /// 🤍 Supabase Client
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

/// 🤍 DataSource

@ProviderFor(profilesDataSource)
const profilesDataSourceProvider = ProfilesDataSourceProvider._();

/// 🤍 DataSource

final class ProfilesDataSourceProvider
    extends
        $FunctionalProvider<
          ProfilesDataSource,
          ProfilesDataSource,
          ProfilesDataSource
        >
    with $Provider<ProfilesDataSource> {
  /// 🤍 DataSource
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

@ProviderFor(userGoalsDataSource)
const userGoalsDataSourceProvider = UserGoalsDataSourceProvider._();

final class UserGoalsDataSourceProvider
    extends
        $FunctionalProvider<
          UserGoalsDataSource,
          UserGoalsDataSource,
          UserGoalsDataSource
        >
    with $Provider<UserGoalsDataSource> {
  const UserGoalsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userGoalsDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userGoalsDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserGoalsDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserGoalsDataSource create(Ref ref) {
    return userGoalsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserGoalsDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserGoalsDataSource>(value),
    );
  }
}

String _$userGoalsDataSourceHash() =>
    r'd4c5f6f160379303d427f86d49d810d3ec73e23b';

@ProviderFor(goalDatasDataSource)
const goalDatasDataSourceProvider = GoalDatasDataSourceProvider._();

final class GoalDatasDataSourceProvider
    extends
        $FunctionalProvider<
          GoalDatasDataSource,
          GoalDatasDataSource,
          GoalDatasDataSource
        >
    with $Provider<GoalDatasDataSource> {
  const GoalDatasDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalDatasDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalDatasDataSourceHash();

  @$internal
  @override
  $ProviderElement<GoalDatasDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoalDatasDataSource create(Ref ref) {
    return goalDatasDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalDatasDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalDatasDataSource>(value),
    );
  }
}

String _$goalDatasDataSourceHash() =>
    r'6f4ee3215c60cc67c92e507b3078db6829dd52c4';

@ProviderFor(authDataSource)
const authDataSourceProvider = AuthDataSourceProvider._();

final class AuthDataSourceProvider
    extends $FunctionalProvider<AuthDataSource, AuthDataSource, AuthDataSource>
    with $Provider<AuthDataSource> {
  const AuthDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthDataSource create(Ref ref) {
    return authDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthDataSource>(value),
    );
  }
}

String _$authDataSourceHash() => r'44d7483bd3e3f976234c8799cbd2cba79c3b851b';

/// 🤍 Repository

@ProviderFor(profilesRepository)
const profilesRepositoryProvider = ProfilesRepositoryProvider._();

/// 🤍 Repository

final class ProfilesRepositoryProvider
    extends
        $FunctionalProvider<
          ProfilesRepository,
          ProfilesRepository,
          ProfilesRepository
        >
    with $Provider<ProfilesRepository> {
  /// 🤍 Repository
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

@ProviderFor(userGoalsRepository)
const userGoalsRepositoryProvider = UserGoalsRepositoryProvider._();

final class UserGoalsRepositoryProvider
    extends
        $FunctionalProvider<
          UserGoalsRepository,
          UserGoalsRepository,
          UserGoalsRepository
        >
    with $Provider<UserGoalsRepository> {
  const UserGoalsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userGoalsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userGoalsRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserGoalsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserGoalsRepository create(Ref ref) {
    return userGoalsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserGoalsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserGoalsRepository>(value),
    );
  }
}

String _$userGoalsRepositoryHash() =>
    r'a2913ec16db4df22c02ffc28ff52c84d4a0fca90';

@ProviderFor(goalDatasRepository)
const goalDatasRepositoryProvider = GoalDatasRepositoryProvider._();

final class GoalDatasRepositoryProvider
    extends
        $FunctionalProvider<
          GoalDatasRepository,
          GoalDatasRepository,
          GoalDatasRepository
        >
    with $Provider<GoalDatasRepository> {
  const GoalDatasRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalDatasRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalDatasRepositoryHash();

  @$internal
  @override
  $ProviderElement<GoalDatasRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoalDatasRepository create(Ref ref) {
    return goalDatasRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalDatasRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalDatasRepository>(value),
    );
  }
}

String _$goalDatasRepositoryHash() =>
    r'd12c5429e9dd7c9232be3e18e6cef69ec918336c';

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'ec654f5fa69e7facde94d755bb72d46efdc77a1b';

@ProviderFor(userRepository)
const userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider
    extends $FunctionalProvider<UserRepository, UserRepository, UserRepository>
    with $Provider<UserRepository> {
  const UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'8b0605fafd52b9cfc60166961f45fe91fa4e80fa';

/// UseCase

@ProviderFor(loginUseCase)
const loginUseCaseProvider = LoginUseCaseProvider._();

/// UseCase

final class LoginUseCaseProvider
    extends $FunctionalProvider<LoginUseCase, LoginUseCase, LoginUseCase>
    with $Provider<LoginUseCase> {
  /// UseCase
  const LoginUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginUseCaseHash();

  @$internal
  @override
  $ProviderElement<LoginUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LoginUseCase create(Ref ref) {
    return loginUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginUseCase>(value),
    );
  }
}

String _$loginUseCaseHash() => r'e082833fd1fc26be8c5fac08d612713cb2c18a17';

@ProviderFor(logoutUseCase)
const logoutUseCaseProvider = LogoutUseCaseProvider._();

final class LogoutUseCaseProvider
    extends $FunctionalProvider<LogoutUseCase, LogoutUseCase, LogoutUseCase>
    with $Provider<LogoutUseCase> {
  const LogoutUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoutUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoutUseCaseHash();

  @$internal
  @override
  $ProviderElement<LogoutUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LogoutUseCase create(Ref ref) {
    return logoutUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogoutUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogoutUseCase>(value),
    );
  }
}

String _$logoutUseCaseHash() => r'2b963e9e0eff2155f687d45b1b5c652ddb695d62';
