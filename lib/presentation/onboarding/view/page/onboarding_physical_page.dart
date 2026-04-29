import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/enum/gender_type_enum.dart';
import 'package:vitameal/presentation/onboarding/view/util/primary_rich_text.dart';
import 'package:vitameal/presentation/onboarding/view/widget/progress_text.dart';
import 'package:vitameal/presentation/onboarding/view/widget/select_box.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/onboarding_page_view_model.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/profiles_view_model.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';
import 'package:vitameal/presentation/widget/validate_textformfield.dart';

class OnboardingPhysicalPage extends HookConsumerWidget {
  const OnboardingPhysicalPage({super.key, required this.isEditMode});

  final bool isEditMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎

    final profileVM = ref.read(profilesViewModelProvider.notifier);

    final state = ref.watch(onboardingPageViewModelProvider(isEditMode));
    final vm = ref.read(onboardingPageViewModelProvider(isEditMode).notifier);

    // (출생년도) 입력값 검증 메시지
    String? validateBirthYear(String? value) {
      if (value == null || value.isEmpty) {
        return null; // 입력값 없을 때 (통과)
      }
      if (value.length != 4 || int.tryParse(value) == null) {
        return l.birth_year_invalid; // 입력 형식 제한
      }
      final year = int.tryParse(value);
      if (year == null) {
        return l.birth_year_invalid; // 숫자가 아닐 때
      }
      if (year < 1900 || year > DateTime.now().year) {
        return l.birth_year_wrong; // 입력 범위 제한 (1900~현재년도)
      }
      return null; // 통과
    }

    // (키, 몸무게) 입력값 검증 메시지
    String? validatePhysical(String? value) {
      if (value == null || value.isEmpty) {
        return null; // 입력값 없을 때 (통과)
      }
      final height = double.tryParse(value);
      if (height == null) {
        return l.invalid_number; // 숫자가 아닐 때
      }
      if (height < 0 || height > 300) {
        return l.invalid_number; // 입력 범위 제한 (0~300)
      }
      return null; // 통과
    }

    // 버튼 활성화 여부
    final bool enabled =
        validateBirthYear(state.birth) == null &&
        validatePhysical(state.height) == null &&
        validatePhysical(state.weight) == null;

    // initValue 타이밍 문제 해결을 위한 controller 및 state 동기화
    final birthController = useTextEditingController();
    final heightController = useTextEditingController();
    final weightController = useTextEditingController();
    useEffect(() {
      if (birthController.text != state.birth) {
        birthController.text = state.birth ?? '';
      }
      if (heightController.text != state.height) {
        heightController.text = state.height ?? '';
      }
      if (weightController.text != state.weight) {
        weightController.text = state.weight ?? '';
      }
      return null;
    }, [state.birth, state.height, state.weight]);

    return Scaffold(
      /// 앱바
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.arrow_back_ios, color: f.textcolor200),
        ),
        actions: [if (!isEditMode) ProgressText(page: "2")],
        actionsPadding: EdgeInsets.only(right: 26),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 설명
              primaryRichText(
                context,
                isEditMode
                    ? l.edit_physical(state.name ?? l.member)
                    : l.onboarding_physical(state.name ?? l.member),
              ),
              const SizedBox(height: 20),

              /// 성별 선택
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 10),
                child: Text(
                  l.gender,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    flex: 1,
                    child: SelectBox(
                      onTap: () async => state.gender == GenderType.male
                          ? vm.updateGender(GenderType.unknown)
                          : vm.updateGender(GenderType.male),
                      isSelected: state.gender == GenderType.male,
                      text: l.male,
                      height: 50,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SelectBox(
                      onTap: () async => state.gender == GenderType.female
                          ? vm.updateGender(GenderType.unknown)
                          : vm.updateGender(GenderType.female),
                      isSelected: state.gender == GenderType.female,
                      text: l.female,
                      height: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// 출생년도 입력창
              ValidateTextformfield(
                label: l.birth_year,
                readOnly: false,
                hintText: "1988",
                validator: validateBirthYear,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // 숫자만
                  LengthLimitingTextInputFormatter(4), // 정수 4자리만
                ],
                controller: birthController,
                onChanged: (v) => vm.updateBirth(v),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  /// 키 입력창
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 120,
                      child: ValidateTextformfield(
                        label: l.height,
                        readOnly: false,
                        hintText: "180.0",
                        validator: validatePhysical,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            // 정수 3자리 + 소수점 1자리 까지
                            RegExp(r'^\d{0,3}\.?\d{0,1}$'),
                          ),
                        ],
                        controller: heightController,
                        onChanged: (v) => vm.updateHeight(v),
                        unit: "cm",
                      ),
                    ),
                  ),

                  /// 몸무게 입력창
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 120,
                      child: ValidateTextformfield(
                        label: l.weight,
                        readOnly: false,
                        hintText: "80.0",
                        validator: validatePhysical,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            // 정수 3자리 + 소수점 1자리
                            RegExp(r'^\d{0,3}\.?\d{0,1}$'),
                          ),
                        ],
                        controller: weightController,
                        onChanged: (v) => vm.updateWeight(v),
                        unit: "kg",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      /// 완료 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: () async {
          if (!enabled) {
            return;
          }
          // 화면 깜빡임 (페이지 상태 초기화) 방지 위해 페이지 이동 먼저
          context.push(AppRoutePath.disease, extra: isEditMode);

          // 프로필 업데이트
          await profileVM.updatePhysical(
            gender: state.gender,
            birthYear: int.tryParse(state.birth!),
            heightCm: double.tryParse(state.height!),
            weightKg: double.tryParse(state.weight!),
          );

          // 📝
          AnalyticsService.event(
            'profile_saved',
            p: {
              'gender': state.gender.toString(),
              'birth_year': double.tryParse(state.birth ?? "") ?? "",
            },
          );
        },
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return SafeArea(
            top: false,
            child: DoneButton(
              onTap: onTap,
              backgroundColor: f.primary400!,
              text: l.next,
              textColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
