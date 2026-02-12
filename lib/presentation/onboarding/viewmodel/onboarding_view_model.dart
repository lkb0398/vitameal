import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'onboarding_view_model.g.dart';

/// 액션 전용 ViewModel
@Riverpod(keepAlive: true)
class OnboardingViewModel extends _$OnboardingViewModel {
  @override
  void build() {}

  Future<String> uploadProfileImage(File file) async {
    final userId = ref.read(userIdProvider);
    return ref
        .read(profilesRepositoryProvider)
        .uploadProfileImage(userId: userId, file: file);
  }

  Future<bool> checkNickname(String nickname) {
    return ref.read(profilesRepositoryProvider).isNicknameDuplicated(nickname);
  }

  Future<void> updateProfile({
    String? nickname,
    String? photoUrl,
    bool? onboardingCompleted,
  }) async {
    final userId = ref.read(userIdProvider);
    await ref
        .read(profilesRepositoryProvider)
        .updateProfile(
          ProfilesEntity(
            userId: userId,
            nickname: nickname,
            photoUrl: photoUrl,
            onboardingCompleted: onboardingCompleted,
          ),
        );
    ref.invalidate(myProfileProvider);
  }

  Future<void> updatePhysical({
    GenderType? gender,
    int? birthYear,
    double? heightCm,
    double? weightKg,
  }) async {
    final userId = ref.read(userIdProvider);
    await ref
        .read(profilesRepositoryProvider)
        .updatePhysical(
          ProfilesEntity(
            userId: userId,
            genderType: gender,
            birthYear: birthYear,
            heightCm: heightCm,
            weightKg: weightKg,
          ),
        );
    ref.invalidate(myProfileProvider);
  }

  Future<void> saveDiseases(List<int> selectedIds) async {
    final userId = ref.read(userIdProvider);
    await ref
        .read(diseasesRepositoryProvider)
        .saveUserDiseases(userId: userId, diseaseIds: selectedIds);
    ref.invalidate(userSelectedDiseasesProvider);
  }

  Future<void> saveAllergies(List<int> selectedIds) async {
    final userId = ref.read(userIdProvider);
    await ref
        .read(allergiesRepositoryProvider)
        .saveUserAllergies(userId: userId, allergyIds: selectedIds);
    ref.invalidate(userSelectedAllergiesProvider);
  }
}
