import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/data/data_source/profiles_data_source.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/onboarding_view_model.dart';

class OnboardingProfilePage extends HookConsumerWidget {
  const OnboardingProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('my userId : 🩷 ${Supabase.instance.client.auth.currentUser!.id}');

    // 프로필 사진 : 사용자 갤러리에서 사진 가져오기 TODO : image picker 공통 위젯으로 바꾸기
    final selectedImage = useState<File?>(null);
    final imageUrl = useState<String?>(null);
    Future<void> pickFromGallery() async {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null) return;
      final file = File(image.path);
      selectedImage.value = file;
      final url = await ref
          .read(onboardingViewModelProvider.notifier)
          .uploadProfileImage(file);
      imageUrl.value = url;
    }

    // 닉네임 : 사용자 입력값 받기 + 검증 메시지
    final nicknameController = useTextEditingController();
    // 서버 닉네임 중복 체크 용
    final nicknameError = useState<String?>(null);
    useEffect(() {
      void listener() => nicknameError.value = null;
      nicknameController.addListener(listener);
      return () => nicknameController.removeListener(listener);
    }, []);

    String? validateNickname(String? value) {
      if (value == null || value.trim().isEmpty) {
        return '닉네임을 입력해주세요.'; // 입력값 없을 때
      }
      final nickname = value.trim();
      if (nickname.length > 10) {
        return '닉네임은 10글자 이하로 입력해주세요.'; // 길이 제한 (1~10)
      }
      return null; // 통과
    }

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
        }
      });
      return null;
    }, [isEditing, profileAsync]);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 20,
          children: [
            /// 설명
            Text(isEditing ? "프로필 수정" : "VitaMeal 에서 사용할 사진과 닉네임을 설정해주세요."),

            /// 프로필 이미지
            InkWell(
              onTap: () => pickFromGallery(),
              child: imageUrl.value == null
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(300),
                      ),
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      child: Text("프로필 이미지 추가"),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Image.network(
                        imageUrl.value!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),

            /// 닉네임 입력창
            ValidateTextformfield(
              readOnly: false,
              hintText: "닉네임",
              validator: validateNickname,
              controller: nicknameController,
              errorText: nicknameError.value,
            ),
          ],
        ),
      ),

      /// 하단 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: () async {
          // 사용자 입력값 검증 > 통과 안되면 페이지 이동 막기
          final nickname = nicknameController.text.trim();
          if (validateNickname(nickname) != null) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('정보를 입력해주세요'),
                duration: Duration(seconds: 1),
              ),
            );
            return;
          }

          nicknameError.value = null;

          try {
            // 프로필 업데이트
            await ref
                .read(onboardingViewModelProvider.notifier)
                .updateProfile(nickname: nickname, photoUrl: imageUrl.value);

            // mounted 체크
            if (!context.mounted) return;

            // 페이지 이동
            isEditing ? context.go('/') : context.push('/onboarding/physical');

            // 닉네임 중복 시
          } on DuplicateNicknameException {
            nicknameError.value = '이미 사용 중인 닉네임입니다.';
          }
        },

        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(isEditing ? "완료" : "다음"),
            ),
          );
        },
      ),
    );
  }
}
