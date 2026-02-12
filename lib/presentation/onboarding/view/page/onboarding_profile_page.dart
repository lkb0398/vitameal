import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/data/data_source/profiles_data_source.dart';
import 'package:vitameal/presentation/onboarding/view/widget/progress_text.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/onboarding_view_model.dart';

class OnboardingProfilePage extends HookConsumerWidget {
  const OnboardingProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('my userId : 🩷 ${ref.read(userIdProvider)}');

    final l = L10n.of(context)!; // 🌎

    // 프로필 사진 : 사용자 갤러리에서 사진 가져오기
    final selectedImage = useState<File?>(null);
    final imageUrl = useState<String?>(null);
    final isUploadingImage = useState(false);
    Future<void> pickFromGallery() async {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null) return;
      final file = File(image.path);
      selectedImage.value = file;
      isUploadingImage.value = true; // 업로드 시작
      try {
        final url = await ref
            .read(onboardingViewModelProvider.notifier)
            .uploadProfileImage(file);
        imageUrl.value = url;
      } finally {
        isUploadingImage.value = false; // 업로드 종료
      }
    }

    // 버튼 활성화 여부
    final isButtonEnabled = useState(false);

    // 닉네임 : 사용자 입력값 받기 + 검증 메시지
    final nicknameController = useTextEditingController();
    final nicknameError = useState<String?>(null); // 서버 중복 체크 용
    String? validateNickname(String? value) {
      if (value == null || value.trim().isEmpty) {
        return l.enter_nickname; // 입력값 없을 때
      }
      final nickname = value.trim();
      if (nickname.length > 10) {
        return l.nickname_max_length; // 길이 제한 (1~10)
      }
      if (nicknameError.value != null) {
        return nicknameError.value; // 서버 닉네임 중복 에러
      }

      return null; // 통과
    }

    useEffect(() {
      void listener() {
        // 입력값 바뀌면 서버 에러 제거
        if (nicknameError.value != null) {
          nicknameError.value = null;
        }

        final nickname = nicknameController.text.trim();
        final isValid =
            validateNickname(nickname) == null && nicknameError.value == null;
        isButtonEnabled.value = isValid;
      }

      nicknameController.addListener(listener);
      return () => nicknameController.removeListener(listener);
    }, []);

    // 수정모드 여부
    final isEditing = ref.watch(isEditFlowProvider);

    // 수정모드 시 기존값 불러오기
    final profileAsync = ref.watch(myProfileProvider);
    final didInit = useRef(false);
    useEffect(() {
      if (!isEditing) return null;
      profileAsync.whenData((profile) {
        if (profile == null) return;
        if (didInit.value) return;
        didInit.value = true;
        if (profile.photoUrl != null && profile.photoUrl!.isNotEmpty) {
          imageUrl.value = profile.photoUrl;
        }
        if (profile.nickname != null) {
          nicknameController.text = profile.nickname!;
          isButtonEnabled.value = true;
        }
      });
      return null;
    }, [isEditing, profileAsync]);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.arrow_back_ios, color: fxc(context).textcolor200),
        ),

        /// 단계 표시
        actions: [isEditing ? SizedBox.shrink() : ProgressText(page: "1")],
        actionsPadding: EdgeInsets.only(right: 26),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              /// 설명
              AutoSizeText.rich(
                TextSpan(
                  style: TextStyle(fontSize: 22, color: vrc(context).text),
                  children: [
                    TextSpan(
                      text: l.profileTitleAppName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: fxc(context).primary400,
                      ),
                    ),
                    TextSpan(text: l.profileTitleSuffix),
                    TextSpan(
                      text: l.profileTitleProfile,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: l.profileTitleObject),
                    TextSpan(
                      text: isEditing ? l.profileTitleEdit : l.profileTitleSet,
                    ),
                    TextSpan(text: l.profileTitleEnd),
                  ],
                ),
              ),

              SizedBox(height: 30),

              /// 프로필 이미지
              Center(
                child: InkWell(
                  onTap: isUploadingImage.value
                      ? null
                      : () => pickFromGallery(),
                  child: isUploadingImage.value
                      ? SizedBox(
                          height: 148,
                          width: 148,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: fxc(context).primary400,
                            ),
                          ),
                        )
                      : imageUrl.value == null
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
                              child: SizedBox(
                                height: 148,
                                width: 148,
                                child: Image.network(
                                  imageUrl.value!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            /// 삭제 버튼
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: () async {
                                  await ref
                                      .read(
                                        onboardingViewModelProvider.notifier,
                                      )
                                      .updateProfile(photoUrl: null);
                                  imageUrl.value = null;
                                },
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: vrc(context).border!,
                                      width: 2,
                                    ),
                                    color: fxc(context).textcolor200,
                                  ),
                                  child: Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: fxc(context).textcolor400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              /// 닉네임 입력창
              Text(l.nickname),
              ValidateTextformfield(
                readOnly: false,
                hintText: l.nickname_example,
                validator: validateNickname,
                controller: nicknameController,
                helperText: l.nickname_max_length,
                errorText: nicknameError.value,
              ),
            ],
          ),
        ),
      ),

      /// 하단 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: isButtonEnabled.value
            ? () async {
                final nickname = nicknameController.text.trim();
                nicknameError.value = null;
                try {
                  // 프로필 업데이트
                  await ref
                      .read(onboardingViewModelProvider.notifier)
                      .updateProfile(
                        nickname: nickname,
                        photoUrl: imageUrl.value,
                      );
                  // mounted 체크
                  if (!context.mounted) return;
                  // 페이지 이동
                  isEditing
                      ? context.go('/')
                      : context.push('/onboarding/physical');
                  // 닉네임 중복 시
                } on DuplicateNicknameException {
                  nicknameError.value = l.duplicate_nickname;
                  nicknameController.value = nicknameController.value;
                }
              }
            : null,
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DoneButton(
              onTap: onTap,
              backgroundColor: isButtonEnabled.value
                  ? fxc(context).primary400!
                  : fxc(context).textcolor300!,
              text: isEditing ? l.edit_complete : l.next,
              textColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
