import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'profiles_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProfilesViewModel extends _$ProfilesViewModel {
  // State : 사용자 프로필 정보 (Async)
  @override
  Future<ProfilesEntity?> build() async {
    return _loadState();
  }

  // [데이터 불러오기]
  Future<ProfilesEntity?> _loadState() async {
    final userId = ref.watch(userIdProvider);
    return ref.read(profilesRepositoryProvider).readMyProfile(userId);
  }

  // [프로필 이미지 업로드]
  Future<String> uploadProfileImage(File file) async {
    final userId = ref.watch(userIdProvider);
    return ref
        .read(profilesRepositoryProvider)
        .uploadProfileImage(userId: userId, file: file);
  }

  // [닉네임 중복 체크]
  Future<bool> checkNickname(String nickname) {
    return ref.watch(profilesRepositoryProvider).isNicknameDuplicated(nickname);
  }

  // [프로필 수정]
  Future<void> updateProfile({
    String? nickname,
    String? photoUrl,
    bool? onboardingCompleted,
  }) async {
    final userId = ref.watch(userIdProvider);

    // 낙관적 업데이트
    final prev = state.value;
    if (prev != null) {
      final updated = prev.copyWith(
        nickname: nickname ?? prev.nickname,
        photoUrl: photoUrl ?? prev.photoUrl,
        onboardingCompleted: onboardingCompleted ?? prev.onboardingCompleted,
      );
      state = AsyncData(updated);
    }

    // 서버 반영
    try {
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
    } catch (e) {
      state = AsyncData(prev); // 롤백
      rethrow;
    }
  }

  // [신체정보 수정]
  Future<void> updatePhysical({
    GenderType? gender,
    int? birthYear,
    double? heightCm,
    double? weightKg,
  }) async {
    final userId = ref.watch(userIdProvider);

    // 낙관적 업데이트
    final prev = state.value;
    if (prev != null) {
      final updated = prev.copyWith(
        genderType: gender ?? prev.genderType,
        birthYear: birthYear ?? prev.birthYear,
        heightCm: heightCm ?? prev.heightCm,
        weightKg: weightKg ?? prev.weightKg,
      );
      state = AsyncData(updated);
    }

    // 서버 반영
    try {
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
    } catch (e) {
      state = AsyncData(prev); // 롤백
      rethrow;
    }
  }
}
