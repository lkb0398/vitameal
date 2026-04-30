import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/profiles_view_model.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/user_allergies_view_model.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/user_diseases_view_model.dart';

part 'onboarding_page_view_model.freezed.dart';
part 'onboarding_page_view_model.g.dart';

// ==================== State ====================

@freezed
abstract class OnboardingPageState with _$OnboardingPageState {
  // State
  const factory OnboardingPageState({
    String? url, // 프로필 사진 선택값
    @Default('') String? name, // 닉네임 입력값
    @Default(GenderType.unknown) GenderType? gender, // 성별 선택값
    @Default('') String? birth, // 출생년도 입력값
    @Default('') String? height, // 키 입력값
    @Default('') String? weight, // 몸무게 입력값
    @Default([]) List<int> diseaseIds, // 질병 id 선택값 목록
    @Default([]) List<int> allergyIds, // 알레르기 id 선택값 목록

    @Default(false) bool uploading, // 이미지 업로드 중 여부
    String? nicknameError, // 닉네임 서버 오류 (닉네임 중복 시)
  }) = _OnboardingPageState;
}

// ==================== ViewModel ====================

@riverpod
class OnboardingPageViewModel extends _$OnboardingPageViewModel {
  @override
  OnboardingPageState build(bool isEditMode) {
    if (!isEditMode) {
      return OnboardingPageState(); // 항상 초기화
    }
    if (isEditMode) {
      Future.microtask(() async {
        await _initProfile();
        await _initDiseases();
        await _initAllergies();
      });
    }
    return OnboardingPageState();
  }

  // [수정모드 시 상태 초기값 세팅]
  Future<void> _initProfile() async {
    final profile = await ref.watch(profilesViewModelProvider.future);
    if (profile == null) return;

    state = state.copyWith(
      url: profile.photoUrl,
      name: profile.nickname,
      gender: profile.genderType ?? GenderType.unknown,
      birth: '${profile.birthYear ?? ''}',
      height: '${profile.heightCm ?? ''}',
      weight: '${profile.weightKg ?? ''}',
    );
  }

  Future<void> _initDiseases() async {
    final ids = await ref.watch(userDiseasesViewModelProvider.future);
    state = state.copyWith(diseaseIds: ids);
  }

  Future<void> _initAllergies() async {
    final ids = await ref.watch(userAllergiesViewModelProvider.future);
    state = state.copyWith(allergyIds: ids);
  }

  // [프로필 사진 선택값 변경]
  void updateUrl(String? v) => state = state.copyWith(url: v);

  // [닉네임 입력값 변경]
  void updateName(String? v) => state = state.copyWith(name: v);

  // [성별 선택값 변경]
  void updateGender(GenderType? v) => state = state.copyWith(gender: v);

  // [출생년도 입력값 변경]
  void updateBirth(String? v) => state = state.copyWith(birth: v);

  // [키 입력값 변경]
  void updateHeight(String? v) => state = state.copyWith(height: v);

  // [몸무게 입력값 변경]
  void updateWeight(String? v) => state = state.copyWith(weight: v);

  // [질병 id 선택값 목록 변경]
  void selectDisease(List<int> v) => state = state.copyWith(diseaseIds: v);

  // [알레르기 id 선택값 목록 변경]
  void selectAllergy(List<int> v) => state = state.copyWith(allergyIds: v);

  // [프로필 사진 업로드중 여부 변경]
  void switchUploading(bool v) => state = state.copyWith(uploading: v);

  // [닉네임 서버 오류 변경]
  void updateNicknameError(String? v) =>
      state = state.copyWith(nicknameError: v);
}
