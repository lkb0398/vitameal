import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/allergies_entity.dart';
import 'package:vitameal/domain/entity/diseases_entity.dart';

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
      .readMyProfile(userId);
  return profile?.onboardingCompleted ?? false;
}

// 질병 전체 목록
@riverpod
Future<List<DiseasesEntity>> diseasesList(Ref ref) {
  return ref.read(diseasesRepositoryProvider).readAllDiseases();
}

// 알레르기 전체 목록
@riverpod
Future<List<AllergiesEntity>> allergiesList(Ref ref) {
  return ref.read(allergiesRepositoryProvider).readAllAllergies();
}
