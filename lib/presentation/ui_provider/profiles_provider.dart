import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/allergies_entity.dart';
import 'package:vitameal/domain/entity/diseases_entity.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';

part 'profiles_provider.g.dart';

/// 현재 로그인된 userId 가져오기 Provider
@riverpod
String userId(Ref ref) {
  return Supabase.instance.client.auth.currentUser!.id;
}

/// 현재 router location 얻기 Provider
@riverpod
String routerLocation(Ref ref) {
  final router = ref.watch(routerProvider);
  final configuration = router.routerDelegate.currentConfiguration;
  if (configuration.routes.isEmpty) {
    return '/';
  }
  return configuration.last.matchedLocation;
}

/// 수정모드 여부 Provider
@riverpod
bool isEditFlow(Ref ref) {
  final location = ref.watch(routerLocationProvider);
  return location.startsWith('/edit');
}

/// 온보딩 완료여부 Provider
@riverpod
class OnboardingState extends _$OnboardingState {
  @override
  bool build() => false;
  void set(bool value) => state = value;
}

@riverpod
Future<bool> onboardingCompleted(Ref ref) async {
  final userId = ref.read(userIdProvider);
  final profile = await ref
      .read(profilesRepositoryProvider)
      .getMyProfile(userId);
  return profile?.onboardingCompleted ?? false;
}

/// 사용자 정보 읽기 전용 Provider
@riverpod
Future<ProfilesEntity?> myProfile(Ref ref) async {
  final userId = ref.read(userIdProvider);
  return ref.read(profilesRepositoryProvider).getMyProfile(userId);
}

// 질병 전체 목록
@riverpod
Future<List<DiseasesEntity>> diseasesList(Ref ref) {
  return ref.read(diseasesRepositoryProvider).getAllDiseases();
}

// 사용자 질병 id 목록
@riverpod
Future<List<int>> userDiseaseIds(Ref ref) async {
  final userId = ref.read(userIdProvider);
  return ref.read(diseasesRepositoryProvider).getUserDiseases(userId);
}

// 사용자 질병 entity 목록
@riverpod
Future<List<DiseasesEntity>> userDiseaseEntities(Ref ref) async {
  final selectedIds = await ref.watch(userDiseaseIdsProvider.future);
  final allDiseases = await ref.watch(diseasesListProvider.future);
  // 조회용 Map 생성
  final diseaseMap = {for (final d in allDiseases) d.id: d};
  // id > entity 매핑
  return selectedIds
      .map((id) => diseaseMap[id])
      .whereType<DiseasesEntity>()
      .toList();
}

// 알레르기 전체 목록
@riverpod
Future<List<AllergiesEntity>> allergiesList(Ref ref) {
  return ref.read(allergiesRepositoryProvider).getAllAllergies();
}

// 사용자 알레르기 id 목록
@riverpod
Future<List<int>> userAllergyIds(Ref ref) async {
  final userId = ref.read(userIdProvider);
  return ref.read(allergiesRepositoryProvider).getUserAllergies(userId);
}

// 사용자 알레르기 entity 목록
@riverpod
Future<List<AllergiesEntity>> userAllergyEntities(Ref ref) async {
  final selectedIds = await ref.watch(userAllergyIdsProvider.future);
  final allAllergies = await ref.watch(allergiesListProvider.future);
  // 조회용 Map 생성
  final allergyMap = {for (final a in allAllergies) a.id: a};
  // id > entity 매핑
  return selectedIds
      .map((id) => allergyMap[id])
      .whereType<AllergiesEntity>()
      .toList();
}
