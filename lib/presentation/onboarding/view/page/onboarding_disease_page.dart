import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/presentation/onboarding/view/widget/select_box.dart';
import 'package:vitameal/presentation/ui_provider/onboarding_provider.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/onboarding_view_model.dart';

class OnboardingDiseasePage extends HookConsumerWidget {
  const OnboardingDiseasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 질병 목록
    final diseasesAsync = ref.watch(diseasesListProvider);

    // 사용자 선택값
    final selectedDiseases = useState<List<String>>([]);

    // 수정모드 여부
    final isEditing = ref.watch(isEditFlowProvider);

    // 수정모드 시 기존값 불러오기
    final selectedAsync = ref.watch(userSelectedDiseasesProvider);
    final didInit = useRef(false);
    useEffect(() {
      if (!isEditing) return null;
      if (didInit.value) return null;
      final values = selectedAsync.value;
      if (values == null) return null;
      didInit.value = true;
      selectedDiseases.value = values;
      return null;
    }, [isEditing, selectedAsync]);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          /// 설명
          Text(isEditing ? "내 정보 수정" : "관리가 필요한 질환을 알려주세요."),

          /// 질병 선택
          Expanded(
            child: diseasesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const Center(child: Text('질병 목록을 불러오지 못했어요')),
              data: (diseases) {
                return GridView.builder(
                  itemCount: diseases.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final disease = diseases[index];
                    final isSelected = selectedDiseases.value.contains(
                      disease.name,
                    );
                    return SelectBox(
                      onTap: () {
                        final current = [...selectedDiseases.value];
                        if (isSelected) {
                          current.remove(disease.name); // 선택된 것 누르면 제거
                        } else {
                          current.add(disease.name); // 선택안된 것 누르면 추가
                        }
                        selectedDiseases.value = current;
                      },
                      changeThisColor: isSelected,
                      text: disease.name,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      /// 하단 버튼
      bottomNavigationBar: TapDebouncer(
        onTap: () async {
          // 질병 정보 업데이트
          await ref
              .read(onboardingViewModelProvider.notifier)
              .saveDiseases(selectedDiseases.value);

          // mounted 체크
          if (!context.mounted) return;

          // 페이지 이동
          isEditing
              ? context.push('/edit/allergy')
              : context.push('/onboarding/allergy');
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
              child: Text("다음"),
            ),
          );
        },
      ),
    );
  }
}
