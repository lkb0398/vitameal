import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/allergies_entity.dart';
import 'package:vitameal/domain/entity/diseases_entity.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';

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
Future<List<int>> userSelectedDiseases(Ref ref) async {
  final userId = ref.read(userIdProvider);
  return ref.read(diseasesRepositoryProvider).getUserDiseases(userId);
}

// 사용자 질병 name(locale 포함) 목록
@riverpod
Future<List<String>> userDiseaseLabels(Ref ref) async {
  final locale = ref.watch(localeViewModelProvider);
  final selectedIds = await ref.watch(userSelectedDiseasesProvider.future);
  final allDiseases = await ref.watch(diseasesListProvider.future);
  // id > entity Map
  final diseaseMap = {for (final d in allDiseases) d.id: d};
  // 선택된 entity 추출
  final selected = selectedIds
      .map((id) => diseaseMap[id])
      .whereType<DiseasesEntity>()
      .toList();
  // locale 에 맞는 이름 선택
  final labels = selected.map((e) {
    return locale == Locale('ko') ? e.name : e.nameEn;
  }).toList();
  // 정렬
  labels.sort((a, b) => a.compareTo(b));

  return labels;
}

// 알레르기 전체 목록
@riverpod
Future<List<AllergiesEntity>> allergiesList(Ref ref) {
  return ref.read(allergiesRepositoryProvider).getAllAllergies();
}

// 사용자 알레르기 id 목록
@riverpod
Future<List<int>> userSelectedAllergies(Ref ref) async {
  final userId = ref.read(userIdProvider);
  return ref.read(allergiesRepositoryProvider).getUserAllergies(userId);
}

// 사용자 알레르기 name(locale 포함) 목록
@riverpod
Future<List<String>> userAllergyLabels(Ref ref) async {
  final locale = ref.watch(localeViewModelProvider);
  final selectedIds = await ref.watch(userSelectedAllergiesProvider.future);
  final allAllergies = await ref.watch(allergiesListProvider.future);
  // id > entity Map
  final allergyMap = {for (final a in allAllergies) a.id: a};
  // 선택된 entity 추출
  final selected = selectedIds
      .map((id) => allergyMap[id])
      .whereType<AllergiesEntity>()
      .toList();
  // locale 에 맞는 이름 선택
  final labels = selected.map((e) {
    return locale == Locale('ko') ? e.name : e.nameEn;
  }).toList();
  // 정렬
  labels.sort((a, b) => a.compareTo(b));

  return labels;
}
