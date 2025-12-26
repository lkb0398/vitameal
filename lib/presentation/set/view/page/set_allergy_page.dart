import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:vitameal/presentation/set/view/widget/select_box.dart';
import 'package:vitameal/presentation/ui_provider/set_provider.dart';
import 'package:vitameal/presentation/set/viewmodel/set_view_model.dart';

class SetAllergyPage extends HookConsumerWidget {
  const SetAllergyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 알레르기 목록
    final allergiesAsync = ref.watch(allergiesListProvider);

    // 사용자 선택값
    final selectedAllergies = useState<List<String>>([]);

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
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          /// 설명
          Text(isEditing ? "내 정보 수정" : "겪고 있는 알레르기를 알려주세요."),

          /// 알레르기 선택
          Expanded(
            child: allergiesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const Center(child: Text('알레르기 목록을 불러오지 못했어요')),
              data: (allergies) {
                return GridView.builder(
                  itemCount: allergies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final allergy = allergies[index];
                    final isSelected = selectedAllergies.value.contains(
                      allergy.name,
                    );
                    return SelectBox(
                      onTap: () {
                        final current = [...selectedAllergies.value];
                        if (isSelected) {
                          current.remove(allergy.name); // 선택된 것 누르면 제거
                        } else {
                          current.add(allergy.name); // 선택안된 것 누르면 추가
                        }
                        selectedAllergies.value = current;
                      },
                      changeThisColor: isSelected,
                      text: allergy.name,
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
          // 알레르기 정보 업데이트
          await ref
              .read(setViewModelProvider.notifier)
              .saveAllergies(selectedAllergies.value);

          // mounted 체크
          if (!context.mounted) return;

          // 페이지 이동
          isEditing ? context.go('/') : context.push('/set/done');
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
