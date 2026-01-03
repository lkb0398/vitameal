import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/data_source/allergies_data_source.dart';
import 'package:vitameal/data/data_source/diseases_data_source.dart';
import 'package:vitameal/data/data_source/profiles_data_source.dart';
import 'package:vitameal/data/data_source/user_allergies_data_source.dart';
import 'package:vitameal/data/data_source/user_diseases_data_source.dart';
import 'package:vitameal/data/data_source/goal_datas_data_source.dart';
import 'package:vitameal/domain/repository/goal_datas_repository.dart';
import 'package:vitameal/data/repository_impl/goal_datas_repository_impl.dart';
import 'package:vitameal/data/data_source/user_goals_data_source.dart';
import 'package:vitameal/data/repository_impl/allergies_repository_impl.dart';
import 'package:vitameal/data/repository_impl/diseases_repository_impl.dart';
import 'package:vitameal/data/repository_impl/profiles_repository_impl.dart';
import 'package:vitameal/data/repository_impl/user_allergies_repository_impl.dart';
import 'package:vitameal/data/repository_impl/user_diseases_repository_impl.dart';
import 'package:vitameal/domain/repository/allergies_repository.dart';
import 'package:vitameal/domain/repository/diseases_repository.dart';
import 'package:vitameal/domain/repository/profiles_repository.dart';
import 'package:vitameal/domain/repository/user_allergies_repository.dart';
import 'package:vitameal/domain/repository/user_diseases_repository.dart';
import 'package:vitameal/domain/repository/user_goals_repository.dart';
import 'package:vitameal/data/repository_impl/user_goals_repository_impl.dart';

import 'package:vitameal/data/data_source/auth_data_source.dart';
import 'package:vitameal/data/repository_impl/auth_repository_impl.dart';
import 'package:vitameal/domain/repository/auth_repository.dart';
import 'package:vitameal/domain/usecase/login_usecase.dart';
import 'package:vitameal/domain/usecase/logout_usecase.dart';

import 'package:vitameal/domain/repository/user_repository.dart';
import 'package:vitameal/data/repository_impl/user_repository_impl.dart';

part 'provider.g.dart';

/// 🤍 Supabase Client
@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

/// 🤍 DataSource
@riverpod
ProfilesDataSource profilesDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return ProfilesDataSourceImpl(client);
}

@riverpod
UserDiseasesDataSource userDiseasesDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return UserDiseasesDataSourceImpl(client);
}

@riverpod
DiseasesDataSource diseasesDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return DiseasesDataSourceImpl(client);
}

@riverpod
UserAllergiesDataSource userAllergiesDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return UserAllergiesDataSourceImpl(client);
}

@riverpod
AllergiesDataSource allergiesDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return AllergiesDataSourceImpl(client);
}

@riverpod
UserGoalsDataSource userGoalsDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return UserGoalsDataSourceImpl(client);
}

@riverpod
GoalDatasDataSource goalDatasDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return GoalDatasDataSourceImpl(client);
}

@riverpod
AuthDataSource authDataSource(Ref ref) {
  final client = ref.watch(supabaseClientProvider);
  return AuthDataSource(client);
}

/// 🤍 Repository
@riverpod
ProfilesRepository profilesRepository(Ref ref) {
  final dataSource = ref.read(profilesDataSourceProvider);
  return ProfilesRepositoryImpl(dataSource);
}

@riverpod
UserDiseasesRepository userDiseasesRepository(Ref ref) {
  final userDiseasesDS = ref.read(userDiseasesDataSourceProvider);
  final diseasesDS = ref.read(diseasesDataSourceProvider);
  return UserDiseasesRepositoryImpl(userDiseasesDS, diseasesDS);
}

@riverpod
DiseasesRepository diseasesRepository(Ref ref) {
  final dataSource = ref.read(diseasesDataSourceProvider);
  return DiseasesRepositoryImpl(dataSource);
}

@riverpod
UserAllergiesRepository userAllergiesRepository(Ref ref) {
  final userAllergiesDS = ref.read(userAllergiesDataSourceProvider);
  final allergiesDS = ref.read(allergiesDataSourceProvider);
  return UserAllergiesRepositoryImpl(userAllergiesDS, allergiesDS);
}

@riverpod
AllergiesRepository allergiesRepository(Ref ref) {
  final dataSource = ref.read(allergiesDataSourceProvider);
  return AllergiesRepositoryImpl(dataSource);
}

@riverpod
UserGoalsRepository userGoalsRepository(Ref ref) {
  final dataSource = ref.read(userGoalsDataSourceProvider);
  return UserGoalsRepositoryImpl(dataSource);
}

@riverpod
GoalDatasRepository goalDatasRepository(Ref ref) {
  final dataSource = ref.read(goalDatasDataSourceProvider);
  return GoalDatasRepositoryImpl(dataSource);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

@riverpod
UserRepository userRepository(Ref ref) {
  final client = ref.watch(supabaseClientProvider);
  return UserRepositoryImpl(client);
}

/// UseCase
@riverpod
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}
