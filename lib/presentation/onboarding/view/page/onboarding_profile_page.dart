import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/data/data_source/profiles_data_source.dart';
import 'package:vitameal/presentation/onboarding/view/util/primary_rich_text.dart';
import 'package:vitameal/presentation/onboarding/view/widget/progress_text.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/onboarding_page_view_model.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/profiles_view_model.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class OnboardingProfilePage extends HookConsumerWidget {
  const OnboardingProfilePage({super.key, required this.isEditMode});

  final bool isEditMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    final profileVM = ref.read(profilesViewModelProvider.notifier);

    final state = ref.watch(onboardingPageViewModelProvider(isEditMode));
    final vm = ref.read(onboardingPageViewModelProvider(isEditMode).notifier);

    // (프로필 사진) 사용자 갤러리에서 사진 가져오기
    Future<void> pickFromGallery() async {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null) return;
      final file = File(image.path);
      vm.switchUploading(true);

      try {
        // [프로필 사진 업로드]
        final url = await profileVM.uploadProfileImage(file);
        vm.updateUrl(url);
      } finally {
        vm.switchUploading(false);
      }
    }

    // (닉네임) 입력값 검증 메시지
    String? validateNickname(String? value) {
      if (value == null || value.trim().isEmpty) {
        return l.enter_nickname; // 입력값 없을 때
      }
      final nickname = value.trim();
      if (nickname.length > 10) {
        return l.nickname_max_length; // 길이 제한 (1~10)
      }
      if (state.nicknameError != null) {
        return state.nicknameError; // 서버 닉네임 중복 에러
      }
      return null; // 통과
    }

    // 버튼 활성화 여부
    final bool enabled =
        validateNickname(state.name) == null && state.nicknameError == null;

    // 입력값 바뀌면 서버 에러 제거
    ref.listen(onboardingPageViewModelProvider(isEditMode), (prev, next) {
      if (prev?.name != next.name) {
        if (next.nicknameError != null) {
          vm.updateNicknameError(null);
        }
      }
    });

    // initValue 타이밍 문제 해결을 위한 controller 및 state 동기화
    final nicknameController = useTextEditingController();
    useEffect(() {
      if (nicknameController.text != state.name) {
        nicknameController.text = state.name ?? '';
      }
      return null;
    }, [state.name]);

    return Scaffold(
      resizeToAvoidBottomInset: true,

      /// 앱바
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.arrow_back_ios, color: f.textcolor200),
        ),
        actions: [if (!isEditMode) ProgressText(page: "1")],
        actionsPadding: EdgeInsets.only(right: 26),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 40,
            children: [
              /// 설명
              primaryRichText(
                context,
                isEditMode ? l.edit_profile : l.onboarding_profile,
              ),

              /// 프로필 이미지
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: state.uploading ? null : () => pickFromGallery(),
                  child: state.uploading
                      ? SizedBox.square(
                          dimension: 148,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: f.primary400,
                            ),
                          ),
                        )
                      : state.url == null
                      ? Image.asset(
                          'assets/images/profile_image_l.webp',
                          height: 148,
                          width: 148,
                          fit: BoxFit.cover,
                        )
                      : Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: Image.network(
                                height: 148,
                                width: 148,
                                state.url!,
                                fit: BoxFit.cover,
                              ),
                            ),

                            /// 삭제 버튼
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: () async {
                                  vm.updateUrl(null);

                                  // [프로필 수정]
                                  await profileVM.updateProfile(photoUrl: null);
                                },
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: v.border!,
                                      width: 2,
                                    ),
                                    color: f.textcolor200,
                                  ),
                                  child: Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: f.textcolor400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              /// 닉네임 입력창
              ValidateTextformfield(
                label: l.nickname,
                readOnly: false,
                hintText: l.nickname_example,
                validator: validateNickname,
                helperText: l.nickname_max_length,
                errorText: state.nicknameError,
                controller: nicknameController,
                onChanged: (v) => vm.updateName(v),
              ),
            ],
          ),
        ),
      ),

      /// 완료 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: () async {
          if (!enabled) return;

          try {
            // 화면 깜빡임 (페이지 상태 초기화) 방지 위해 페이지 이동 먼저
            isEditMode
                ? context.go(AppRoutePath.home)
                : context.push(AppRoutePath.physical, extra: false);

            // [프로필 수정]
            await profileVM.updateProfile(
              nickname: state.name,
              photoUrl: state.url,
            );

            // 닉네임 중복 시
          } on DuplicateNicknameException {
            vm.updateNicknameError(l.duplicate_nickname);
          }
        },
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return SafeArea(
            top: false,
            child: DoneButton(
              onTap: onTap,
              backgroundColor: enabled ? f.primary400! : f.textcolor300!,
              text: isEditMode ? l.edit_complete : l.next,
              textColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
