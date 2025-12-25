import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';
import 'package:vitameal/presentation/set/viewmodel/set_provider.dart';

part 'set_view_model.g.dart';

/// 액션 전용 ViewModel
@Riverpod(keepAlive: true)
class SetViewModel extends _$SetViewModel {
  @override
  void build() {}

  Future<String> uploadProfileImage(File file) async {
    final userId = ref.read(currentUserIdProvider);
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
    GenderType? gender,
    int? birthYear,
    double? heightCm,
    double? weightKg,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    await ref
        .read(profilesRepositoryProvider)
        .updateProfile(
          ProfilesEntity(
            userId: userId,
            nickname: nickname,
            photoUrl: photoUrl,
            gender: gender,
            birthYear: birthYear,
            heightCm: heightCm,
            weightKg: weightKg,
          ),
        );
    ref.invalidate(myProfileProvider);
  }

  Future<void> saveDiseases(List<String> selectedNames) async {
    final userId = ref.read(currentUserIdProvider);
    final diseaseIds = await ref
        .read(diseasesRepositoryProvider)
        .findDiseaseIdsByNames(selectedNames);
    await ref
        .read(userDiseasesRepositoryProvider)
        .saveUserDiseases(userId: userId, diseaseIds: diseaseIds);
  }

  Future<void> saveAllergies(List<String> selectedNames) async {
    final userId = ref.read(currentUserIdProvider);
    final allergyIds = await ref
        .read(allergiesRepositoryProvider)
        .findAllergyIdsByNames(selectedNames);
    await ref
        .read(userAllergiesRepositoryProvider)
        .saveUserAllergies(userId: userId, allergyIds: allergyIds);
  }
}
