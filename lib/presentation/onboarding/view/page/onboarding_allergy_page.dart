import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/onboarding/view/util/primary_rich_text.dart';
import 'package:vitameal/presentation/onboarding/view/widget/progress_text.dart';
import 'package:vitameal/presentation/onboarding/view/widget/select_box.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/onboarding_page_view_model.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/user_allergies_view_model.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/presentation/widget/button/done_button.dart';

class OnboardingAllergyPage extends HookConsumerWidget {
  const OnboardingAllergyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎
    final locale =
        ref.read(localeViewModelProvider) ?? Localizations.localeOf(context);

    final isEditMode = ref.watch(isEditFlowProvider);
    final allAllergiesAsync = ref.watch(allergiesListProvider);

    final allergyVM = ref.read(userAllergiesViewModelProvider.notifier);

    final state = ref.watch(onboardingPageViewModelProvider);
    final vm = ref.watch(onboardingPageViewModelProvider.notifier);

    // 모바일 가로모드 이상 반응형 UI 적용
    final bool isWide = MediaQuery.sizeOf(context).width >= 480;

    return Scaffold(
      /// 앱바
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.arrow_back_ios, color: f.textcolor200),
        ),
        actions: [if (!isEditMode) ProgressText(page: "4")],
        actionsPadding: const EdgeInsets.only(right: 26),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            /// 설명
            primaryRichText(
              context,
              isEditMode ? l.edit_allergy : l.onboarding_allergy,
            ),

            /// 알레르기 선택
            Expanded(
              child: allAllergiesAsync.when(
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
                      final isSelected = state.allergyIds.contains(allergy.id);
                      return SelectBox(
                        onTap: () {
                          final current = [...state.allergyIds];
                          if (isSelected) {
                            current.remove(allergy.id); // 선택된 것 누르면 제거
                          } else {
                            current.add(allergy.id); // 선택안된 것 누르면 추가
                          }
                          vm.selectAllergy(current);
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

      /// 완료 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: () async {
          // [알레르기 목록 갱신]
          await allergyVM.saveAllergies(state.allergyIds);

          if (!context.mounted) return;
          isEditMode
              ? context.go(AppRoutePath.home)
              : context.push(AppRoutePath.onboardingDone);
          // 📝
          for (final a in state.allergyIds) {
            AnalyticsService.event('profile_saved', p: {'allergy': a});
          }
        },
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DoneButton(
              onTap: onTap,
              backgroundColor: f.primary400!,
              text: isEditMode ? l.edit_complete : l.next,
              textColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
