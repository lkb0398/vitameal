import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';
import 'package:vitameal/presentation/set/view/widget/select_box.dart';
import 'package:vitameal/presentation/set/view/widget/validate_textformfield.dart';
import 'package:vitameal/presentation/set/viewmodel/set_provider.dart';
import 'package:vitameal/presentation/set/viewmodel/set_view_model.dart';

class SetPhysicalPage extends HookConsumerWidget {
  const SetPhysicalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 성별 : 사용자 선택값 (기본값 남성)
    final selectedGender = useState<GenderType>(GenderType.male);

    // 출생년도 : 사용자 입력값 받기 + 검증 메시지
    final birthyearController = useTextEditingController();
    String? validateBirthYear(String? value) {
      if (value == null || value.isEmpty) {
        return '출생년도를 입력해주세요.'; // 입력값 없을 때
      }
      if (value.length != 4) {
        return '출생년도는 4자리 숫자여야 해요.'; // 입력 형식 제한
      }
      final year = int.tryParse(value);
      if (year == null) {
        return '숫자를 입력해주세요.'; // 숫자가 아닐 때
      }
      if (year < 1900 || year > DateTime.now().year) {
        return '올바른 출생년도를 입력해주세요.'; // 입력 범위 제한 (1900~현재년도)
      }
      return null; // 통과
    }

    // 키 : 사용자 입력값 받기 + 검증 메시지
    final heightController = useTextEditingController();
    String? validateHeight(String? value) {
      if (value == null || value.isEmpty) {
        return '키를 입력해주세요.'; // 입력값 없을 때
      }
      final height = double.tryParse(value);
      if (height == null) {
        return '숫자를 입력해주세요.'; // 숫자가 아닐 때
      }
      if (height < 0 || height > 300) {
        return '올바른 키를 입력해주세요.'; // 입력 범위 제한 (0~300)
      }
      return null; // 통과
    }

    // 몸무게 : 사용자 입력값 받기 + 검증 메시지
    final weightController = useTextEditingController();
    String? validateWeight(String? value) {
      if (value == null || value.isEmpty) {
        return '몸무게를 입력해주세요.'; // 입력값 없을 때
      }
      final weight = double.tryParse(value);
      if (weight == null) {
        return '숫자를 입력해주세요.'; // 숫자가 아닐 때
      }
      if (weight < 0 || weight > 300) {
        return '올바른 몸무게를 입력해주세요.'; // 입력 범위 제한 (0~300)
      }
      return null; // 통과
    }

    // 수정모드 여부
    final isEditing = ref.read(isEditingProvider);

    // 수정모드 시 기존값 불러오기
    final profileAsync = ref.watch(myProfileProvider);
    final didInit = useRef(false);
    useEffect(() {
      if (!isEditing) return null;
      profileAsync.whenData((profile) {
        if (profile == null) return;
        if (didInit.value) return;
        didInit.value = true;
        if (profile.gender != null) {
          selectedGender.value = profile.gender!;
        }
        if (profile.birthYear != null) {
          birthyearController.text = profile.birthYear.toString();
        }
        if (profile.heightCm != null) {
          heightController.text = profile.heightCm!.toString();
        }
        if (profile.weightKg != null) {
          weightController.text = profile.weightKg!.toString();
        }
      });
      return null;
    }, [isEditing, profileAsync]);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            profileAsync.when(
              data: (profile) => Text(
                isEditing
                    ? "내 정보 수정"
                    : "반갑습니다, ${profile?.nickname ?? '회원'}님! 기본 정보를 입력해주세요.",
              ),
              loading: () => const Text("반갑습니다! 기본 정보를 입력해주세요."),
              error: (_, __) => const Text("반갑습니다! 기본 정보를 입력해주세요."),
            ),

            /// 성별 선택
            Text("성별"),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 1,
                  child: SelectBox(
                    onTap: () async => selectedGender.value = GenderType.male,
                    changeThisColor: selectedGender.value == GenderType.male,
                    text: "남성",
                    height: 50,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SelectBox(
                    onTap: () async => selectedGender.value = GenderType.female,
                    changeThisColor: selectedGender.value == GenderType.female,
                    text: "여성",
                    height: 50,
                  ),
                ),
              ],
            ),

            /// 출생년도 입력창
            Text("출생년도"),
            ValidateTextformfield(
              hintText: "1988",
              validator: validateBirthYear,
              controller: birthyearController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // 숫자만
                LengthLimitingTextInputFormatter(4), // 정수 4자리만
              ],
            ),
            Row(
              children: [
                /// 키 입력창
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("키"),
                      Row(
                        children: [
                          Expanded(
                            child: ValidateTextformfield(
                              hintText: "180",
                              validator: validateHeight,
                              controller: heightController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  // 정수 3자리 + 소수점 1자리 까지
                                  RegExp(r'^\d{0,3}\.?\d{0,1}$'),
                                ),
                              ],
                            ),
                          ),
                          Text("cm"),
                        ],
                      ),
                    ],
                  ),
                ),

                /// 몸무게 입력창
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("몸무게"),
                      Row(
                        children: [
                          Expanded(
                            child: ValidateTextformfield(
                              hintText: "80",
                              validator: validateWeight,
                              controller: weightController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  // 정수 3자리 + 소수점 1자리
                                  RegExp(r'^\d{0,3}\.?\d{0,1}$'),
                                ),
                              ],
                            ),
                          ),
                          Text("kg"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      /// 하단 버튼
      bottomNavigationBar: InkWell(
        onTap: () async {
          // 사용자 입력값 검증 > 통과 안되면 페이지 이동 막기
          final birthYear = birthyearController.text.trim();
          final heightCm = heightController.text.trim();
          final weightKg = weightController.text.trim();
          if (validateBirthYear(birthYear) != null ||
              validateHeight(heightCm) != null ||
              validateWeight(weightKg) != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('정보를 입력해주세요')));
            return;
          }

          // 프로필 업데이트
          await ref
              .read(setViewModelProvider.notifier)
              .updateProfile(
                gender: selectedGender.value,
                birthYear: int.tryParse(birthYear),
                heightCm: double.tryParse(heightCm),
                weightKg: double.tryParse(weightKg),
              );

          // mounted 체크
          if (!context.mounted) return;

          // 페이지 이동
          context.push('/set-disease');
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          child: Text("다음"),
        ),
      ),
    );
  }
}
