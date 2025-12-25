import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/data_source/allergies_data_source.dart';
import 'package:vitameal/data/data_source/diseases_data_source.dart';
import 'package:vitameal/data/data_source/profiles_data_source.dart';
import 'package:vitameal/data/data_source/profiles_storage_data_source.dart';
import 'package:vitameal/data/data_source/user_allergies_data_source.dart';
import 'package:vitameal/data/data_source/user_diseases_data_source.dart';
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

part 'provider.g.dart';

/// Supabase Client
@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

/// DataSource
@riverpod
ProfilesDataSource profilesDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return ProfilesDataSourceImpl(client);
}

@riverpod
ProfilesStorageDataSource profilesStorageDataSource(Ref ref) {
  final client = ref.read(supabaseClientProvider);
  return ProfilesStorageDataSourceImpl(client);
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

/// Repository
@riverpod
ProfilesRepository profilesRepository(Ref ref) {
  final dataSource = ref.read(profilesDataSourceProvider);
  final storageDataSource = ref.read(profilesStorageDataSourceProvider);
  return ProfilesRepositoryImpl(dataSource, storageDataSource);
}

@riverpod
UserDiseasesRepository userDiseasesRepository(Ref ref) {
  final dataSource = ref.read(userDiseasesDataSourceProvider);
  return UserDiseasesRepositoryImpl(dataSource);
}

@riverpod
DiseasesRepository diseasesRepository(Ref ref) {
  final dataSource = ref.read(diseasesDataSourceProvider);
  return DiseasesRepositoryImpl(dataSource);
}

@riverpod
UserAllergiesRepository userAllergiesRepository(Ref ref) {
  final dataSource = ref.read(userAllergiesDataSourceProvider);
  return UserAllergiesRepositoryImpl(dataSource);
}

@riverpod
AllergiesRepository allergiesRepository(Ref ref) {
  final dataSource = ref.read(allergiesDataSourceProvider);
  return AllergiesRepositoryImpl(dataSource);
}
