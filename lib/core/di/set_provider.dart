import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/allergies_entity.dart';
import 'package:vitameal/domain/entity/diseases_entity.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';

part 'set_provider.g.dart';

/// UI 상태 (수정모드) Provider
@riverpod
class IsEditing extends _$IsEditing {
  @override
  bool build() => false;
  void startEditing() => state = true;
  void stopEditing() => state = false;
}

/// 인증/세션 (userId) Provider
@riverpod
String currentUserId(Ref ref) {
  return Supabase.instance.client.auth.currentUser!.id;
}

/// 읽기 전용 Provider
@riverpod
Future<ProfilesEntity?> myProfile(Ref ref) async {
  final userId = ref.read(currentUserIdProvider);
  return ref.read(profilesRepositoryProvider).getMyProfile(userId);
}

@riverpod
Future<List<DiseasesEntity>> diseasesList(Ref ref) {
  return ref.read(diseasesRepositoryProvider).getAllDiseases();
}

@riverpod
Future<List<String>> userSelectedDiseases(Ref ref) async {
  final userId = ref.read(currentUserIdProvider);
  return ref.read(userDiseasesRepositoryProvider).getUserDiseaseNames(userId);
}

@riverpod
Future<List<AllergiesEntity>> allergiesList(Ref ref) {
  return ref.read(allergiesRepositoryProvider).getAllAllergies();
}

@riverpod
Future<List<String>> userSelectedAllergies(Ref ref) async {
  final userId = ref.read(currentUserIdProvider);
  return ref.read(userAllergiesRepositoryProvider).getUserAllergyNames(userId);
}
