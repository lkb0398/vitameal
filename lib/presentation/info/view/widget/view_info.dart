import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/presentation/widget/bordered_container.dart';

class ViewInfo extends HookConsumerWidget {
  const ViewInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 사용자 정보 불러오기
    final profileAsync = ref.watch(myProfileProvider);
    final diseasesAsync = ref.watch(userSelectedDiseasesProvider);
    final allergiesAsync = ref.watch(userSelectedAllergiesProvider);

    return Column(
      spacing: 20,
      children: [
        /// 프로필 이미지 + 닉네임
        InkWell(
          onTap: () {
            context.push('/edit/profile');
          },
          child: Row(
            spacing: 5,
            children: [
              profileAsync.when(
                data: (profile) {
                  return profile!.photoUrl == null
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          height: 50,
                          width: 50,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            profile.photoUrl!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        );
                },
                loading: () {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 50,
                    width: 50,
                  );
                },
                error: (_, __) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 50,
                    width: 50,
                  );
                },
              ),

              profileAsync.when(
                data: (profile) => Text("${profile?.nickname}"),
                loading: () => const Text("정보를 불러오는 중.."),
                error: (_, __) => const Text("정보를 불러오는 데 실패했습니다"),
              ),
            ],
          ),
        ),

        /// 내 정보
        BorderedContainer(
          title: "내 정보",
          action: IconButton(
            onPressed: () => context.push('/edit/physical'),
            icon: Icon(Icons.arrow_forward_ios),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              profileAsync.when(
                data: (profile) => Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${profile?.gender ?? ""} ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${profile?.age ?? ""}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "세 "),
                      TextSpan(
                        text: "${profile?.heightCm ?? ""}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "cm "),
                      TextSpan(
                        text: "${profile?.weightKg ?? ""}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "kg "),
                    ],
                  ),
                ),

                loading: () => const Text("정보를 불러오는 중.."),
                error: (_, __) => const Text("정보를 불러오는 데 실패했습니다"),
              ),

              /// 질환
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.red),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                    child: Text("질환", style: TextStyle(color: Colors.red)),
                  ),
                  Expanded(
                    child: diseasesAsync.when(
                      data: (diseases) {
                        return Text(
                          diseases.isEmpty ? "없음" : diseases.join(', '),
                        );
                      },
                      loading: () => const Text("정보를 불러오는 중.."),
                      error: (_, __) => const Text("정보를 불러오는 데 실패했습니다"),
                    ),
                  ),
                ],
              ),

              /// 알레르기
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.red),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                    child: Text("알레르기", style: TextStyle(color: Colors.red)),
                  ),
                  Expanded(
                    child: allergiesAsync.when(
                      data: (allergies) {
                        return Text(
                          allergies.isEmpty ? "없음" : allergies.join(', '),
                        );
                      },
                      loading: () => const Text("정보를 불러오는 중.."),
                      error: (_, __) => const Text("정보를 불러오는 데 실패했습니다"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
