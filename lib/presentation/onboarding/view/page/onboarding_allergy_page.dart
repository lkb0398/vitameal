import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/onboarding/view/widget/progress_text.dart';
import 'package:vitameal/presentation/onboarding/view/widget/select_box.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/onboarding_view_model.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';

class OnboardingAllergyPage extends HookConsumerWidget {
  const OnboardingAllergyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎
    final locale = ref.watch(localeViewModelProvider);

    // 모바일 가로모드 이상의 디바이스 크기일 때 반응형 UI 적용 위한 변수
    final bool isWide = MediaQuery.sizeOf(context).width >= 480;

    // 알레르기 목록
    final allergiesAsync = ref.watch(allergiesListProvider);

    // 사용자 선택값
    final selectedAllergies = useState<List<int>>([]);

    // 수정모드 여부
    final isEditing = ref.watch(isEditFlowProvider);

    // 수정모드 시 기존값 불러오기
    final selectedAsync = ref.watch(userSelectedAllergiesProvider);
    final didInit = useRef(false);
    useEffect(() {
      if (!isEditing) return null;
      if (didInit.value) return null;
      final values = selectedAsync.value;
      if (values == null) return null;
      didInit.value = true;
      selectedAllergies.value = values;
      return null;
    }, [isEditing, selectedAsync]);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.arrow_back_ios, color: fxc(context).textcolor200),
        ),

        /// 단계 표시
        actions: [isEditing ? SizedBox.shrink() : ProgressText(page: "4")],
        actionsPadding: EdgeInsets.only(right: 26),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            /// 설명
            AutoSizeText.rich(
              TextSpan(
                style: TextStyle(fontSize: 22, color: vrc(context).text),
                children: [
                  TextSpan(text: l.allergyPrefix),
                  TextSpan(
                    text: l.allergy,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: isEditing ? l.editOptional : l.allSelectOptional,
                  ),
                ],
              ),
            ),

            /// 알레르기 선택
            Expanded(
              child: allergiesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(l.failed_loading_allergy)),
                data: (allergies) {
                  // 알레르기 리스트 복사해서 언어에 따라 정렬
                  final sortedAllergies = [...allergies]
                    ..sort(
                      (a, b) => locale == const Locale('ko')
                          ? a.name.compareTo(b.name)
                          : a.nameEn.compareTo(b.nameEn),
                    );

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWide ? 5 : 3,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: sortedAllergies.length,
                    itemBuilder: (context, index) {
                      final allergy = sortedAllergies[index];
                      final name = locale == Locale('ko')
                          ? allergy.name
                          : allergy.nameEn;
                      final isSelected = selectedAllergies.value.contains(
                        allergy.id,
                      );
                      return SelectBox(
                        onTap: () {
                          final current = [...selectedAllergies.value];
                          if (isSelected) {
                            current.remove(allergy.id); // 선택된 것 누르면 제거
                          } else {
                            current.add(allergy.id); // 선택안된 것 누르면 추가
                          }
                          selectedAllergies.value = current;
                        },
                        isSelected: isSelected,
                        text: name,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      /// 하단 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: () async {
          final allergy = selectedAllergies.value;
          // 알레르기 정보 업데이트
          await ref
              .read(onboardingViewModelProvider.notifier)
              .saveAllergies(allergy);
          // mounted 체크
          if (!context.mounted) return;
          // 페이지 이동
          isEditing ? context.go('/') : context.push('/onboarding/done');
          // 📝
          for (final a in allergy) {
            AnalyticsService.event('profile_saved', p: {'allergy': a});
          }
        },
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DoneButton(
              onTap: onTap,
              backgroundColor: fxc(context).primary400!,
              text: isEditing ? l.edit_complete : l.next,
              textColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
