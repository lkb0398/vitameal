// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supabaseClient)
const supabaseClientProvider = SupabaseClientProvider._();

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
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

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'6db5c6e8abbcbc1700e5d6d9989b84206be84f9b';

@ProviderFor(profilesDataSource)
const profilesDataSourceProvider = ProfilesDataSourceProvider._();

final class ProfilesDataSourceProvider
    extends
        $FunctionalProvider<
          ProfilesDataSource,
          ProfilesDataSource,
          ProfilesDataSource
        >
    with $Provider<ProfilesDataSource> {
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

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 5f0aade (feat: UI를 제외한 기능구현 및 리팩토링 완료!)
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

<<<<<<< HEAD
String _$authDataSourceHash() => r'44d7483bd3e3f976234c8799cbd2cba79c3b851b';

@ProviderFor(mealLocalDataSource)
const mealLocalDataSourceProvider = MealLocalDataSourceProvider._();

final class MealLocalDataSourceProvider
    extends
        $FunctionalProvider<
          MealLocalDataSource,
          MealLocalDataSource,
          MealLocalDataSource
        >
    with $Provider<MealLocalDataSource> {
  const MealLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<MealLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MealLocalDataSource create(Ref ref) {
    return mealLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealLocalDataSource>(value),
    );
  }
}

String _$mealLocalDataSourceHash() =>
    r'b5e2271407d292f23956b77752831cf208e885c5';

@ProviderFor(mealRemoteDataSource)
const mealRemoteDataSourceProvider = MealRemoteDataSourceProvider._();

final class MealRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          MealRemoteDataSource,
          MealRemoteDataSource,
          MealRemoteDataSource
        >
    with $Provider<MealRemoteDataSource> {
  const MealRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<MealRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MealRemoteDataSource create(Ref ref) {
    return mealRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealRemoteDataSource>(value),
    );
  }
}

String _$mealRemoteDataSourceHash() =>
    r'8cd0af67fbf469ce0ab6e9ed9527abb49a60c050';

@ProviderFor(storageDataSource)
const storageDataSourceProvider = StorageDataSourceProvider._();

final class StorageDataSourceProvider
    extends
        $FunctionalProvider<
          StorageDataSource,
          StorageDataSource,
          StorageDataSource
        >
    with $Provider<StorageDataSource> {
  const StorageDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageDataSourceHash();

  @$internal
  @override
  $ProviderElement<StorageDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StorageDataSource create(Ref ref) {
    return storageDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StorageDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StorageDataSource>(value),
    );
  }
}

String _$storageDataSourceHash() => r'c8e30e822b695967f22912d6d5d8b40811101ddd';
=======
/// 🤍 Repository
=======
String _$authDataSourceHash() => r'44d7483bd3e3f976234c8799cbd2cba79c3b851b';

/// Repository
>>>>>>> 3f1cbb3 (feat: UI를 제외한 기능구현 및 리팩토링 완료)
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)
=======
String _$authDataSourceHash() => r'44d7483bd3e3f976234c8799cbd2cba79c3b851b';

/// 🤍 Repository
>>>>>>> 5f0aade (feat: UI를 제외한 기능구현 및 리팩토링 완료!)


@ProviderFor(mealAnalysisDataSource)
const mealAnalysisDataSourceProvider = MealAnalysisDataSourceProvider._();

final class MealAnalysisDataSourceProvider
    extends
        $FunctionalProvider<
          MealAnalysisDataSource,
          MealAnalysisDataSource,
          MealAnalysisDataSource
        >
    with $Provider<MealAnalysisDataSource> {
  const MealAnalysisDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealAnalysisDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

@ProviderFor(notificationsDataSource)
const notificationsDataSourceProvider = NotificationsDataSourceProvider._();

final class NotificationsDataSourceProvider
    extends
        $FunctionalProvider<
          NotificationDataSource,
          NotificationDataSource,
          NotificationDataSource
        >
    with $Provider<NotificationDataSource> {
  const NotificationsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealAnalysisDataSourceHash();

  @$internal
  @override
  $ProviderElement<MealAnalysisDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);
  
  @override
  String debugGetCreateSourceHash() => _$notificationsDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MealAnalysisDataSource create(Ref ref) {
    return mealAnalysisDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealAnalysisDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealAnalysisDataSource>(value),
    );
  }
}

String _$mealAnalysisDataSourceHash() =>
    r'2092cd13a6c9b92cf68eca467a096e826666d107';
            
  @override
  NotificationDataSource create(Ref ref) {
    return notificationsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationDataSource>(value),
    );
  }
}

String _$notificationsDataSourceHash() =>
    r'bd148e9a7785ffd9230502200f08ba8de50c20f9';

/// 🤍 Repository

@ProviderFor(profilesRepository)
const profilesRepositoryProvider = ProfilesRepositoryProvider._();

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

<<<<<<< HEAD
<<<<<<< HEAD
String _$goalDatasRepositoryHash() =>
    r'd12c5429e9dd7c9232be3e18e6cef69ec918336c';
<<<<<<< HEAD

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

@ProviderFor(mealRepository)
const mealRepositoryProvider = MealRepositoryProvider._();

final class MealRepositoryProvider
    extends $FunctionalProvider<MealRepository, MealRepository, MealRepository>
    with $Provider<MealRepository> {
  const MealRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealRepositoryHash();

  @$internal
  @override
  $ProviderElement<MealRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MealRepository create(Ref ref) {
    return mealRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealRepository>(value),
    );
  }
}

String _$mealRepositoryHash() => r'ef94b99643776ad238458b9d12e19b09258ec0d9';

@ProviderFor(storageRepository)
const storageRepositoryProvider = StorageRepositoryProvider._();

final class StorageRepositoryProvider
    extends
        $FunctionalProvider<
          StorageRepository,
          StorageRepository,
          StorageRepository
        >
    with $Provider<StorageRepository> {
  const StorageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageRepositoryHash();

  @$internal
  @override
  $ProviderElement<StorageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StorageRepository create(Ref ref) {
    return storageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StorageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StorageRepository>(value),
    );
  }
}

String _$storageRepositoryHash() => r'af0a6a7425b8b6d146cd46a5193fdce6fd82ed50';
=======
=======
=======
>>>>>>> 5f0aade (feat: UI를 제외한 기능구현 및 리팩토링 완료!)
String _$userRepositoryHash() => r'8b0605fafd52b9cfc60166961f45fe91fa4e80fa';

/// UseCase
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)

@ProviderFor(mealAnalysisRepository)
const mealAnalysisRepositoryProvider = MealAnalysisRepositoryProvider._();

final class MealAnalysisRepositoryProvider
    extends
        $FunctionalProvider<
          MealAnalysisRepository,
          MealAnalysisRepository,
          MealAnalysisRepository
        >
    with $Provider<MealAnalysisRepository> {
  const MealAnalysisRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealAnalysisRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );
    
    
@ProviderFor(notificationsRepository)
const notificationsRepositoryProvider = NotificationsRepositoryProvider._();

final class NotificationsRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationsRepository,
          NotificationsRepository,
          NotificationsRepository
        >
    with $Provider<NotificationsRepository> {
  const NotificationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealAnalysisRepositoryHash();

  @$internal
  @override
  $ProviderElement<MealAnalysisRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);
   
  @override
  String debugGetCreateSourceHash() => _$notificationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MealAnalysisRepository create(Ref ref) {
    return mealAnalysisRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealAnalysisRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealAnalysisRepository>(value),
    );
  }
}

String _$mealAnalysisRepositoryHash() =>
    r'b938add69d51a245e8ce7274f5e0c5edcf09d5a4';

  @override
  NotificationsRepository create(Ref ref) {
    return notificationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsRepository>(value),
    );
  }
}

String _$notificationsRepositoryHash() =>
    r'abcdb3c01c132670aca5801f847fc2b6fc9667cf';

@ProviderFor(loginUseCase)
const loginUseCaseProvider = LoginUseCaseProvider._();

<<<<<<< HEAD
final class LoginUseCaseProvider
    extends $FunctionalProvider<LoginUseCase, LoginUseCase, LoginUseCase>
    with $Provider<LoginUseCase> {
=======
/// UseCase

final class LoginUseCaseProvider
    extends $FunctionalProvider<LoginUseCase, LoginUseCase, LoginUseCase>
    with $Provider<LoginUseCase> {
  /// UseCase
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)
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
<<<<<<< HEAD
<<<<<<< HEAD

@ProviderFor(syncService)
const syncServiceProvider = SyncServiceProvider._();

final class SyncServiceProvider
    extends $FunctionalProvider<SyncService, SyncService, SyncService>
    with $Provider<SyncService> {
  const SyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncServiceHash();

  @$internal
  @override
  $ProviderElement<SyncService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncService create(Ref ref) {
    return syncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncService>(value),
    );
  }
}

String _$syncServiceHash() => r'a83bb640ca676ea37986ffbc494b2154740efdd7';
=======
>>>>>>> 3f1cbb3 (feat: UI를 제외한 기능구현 및 리팩토링 완료)
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)
=======
>>>>>>> 5f0aade (feat: UI를 제외한 기능구현 및 리팩토링 완료!)
