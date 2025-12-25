import 'package:riverpod_annotation/riverpod_annotation.dart';
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
  // TODO : userId 더미데이터 지우기 > Supabase.instance.client.auth.currentUser!.id 로 교체
  return '4598a25e-d03a-41eb-891e-b9fda4b1fa73';
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
  final client = ref.read(supabaseClientProvider);
  final user = client.auth.currentUser;
  if (user == null) return [];
  final diseaseIds = await ref
      .read(userDiseasesRepositoryProvider)
      .getUserDiseaseIds(user.id);
  return ref.read(diseasesRepositoryProvider).findDiseaseNamesByIds(diseaseIds);
}

@riverpod
Future<List<AllergiesEntity>> allergiesList(Ref ref) {
  return ref.read(allergiesRepositoryProvider).getAllAllergies();
}

@riverpod
Future<List<String>> userSelectedAllergies(Ref ref) async {
  final client = ref.read(supabaseClientProvider);
  final user = client.auth.currentUser;
  if (user == null) return [];
  final allergyIds = await ref
      .read(userAllergiesRepositoryProvider)
      .getUserAllergyIds(user.id);
  return ref
      .read(allergiesRepositoryProvider)
      .findAllergyNamesByIds(allergyIds);
}
