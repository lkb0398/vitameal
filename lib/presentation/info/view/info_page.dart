import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/presentation/set/viewmodel/set_provider.dart';

class InfoPage extends HookConsumerWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 프로필 + 내 정보 불러오기
    final profileAsync = ref.watch(myProfileProvider);
    print(profileAsync);

    // 질병 정보 불러오기
    final diseasesAsync = ref.watch(userSelectedDiseasesProvider);

    // 알레르기 정보 불러오기
    final allergiesAsync = ref.watch(userSelectedAllergiesProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // TODO : 페이지 연결
              // context.push('/setting');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            /// 프로필 이미지 + 닉네임
            InkWell(
              onTap: () {
                ref.read(isEditingProvider.notifier).startEditing(); // 수정모드 on
                context.go('/set-profile');
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 50,
                    width: 50,
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("내 정보"),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(isEditingProvider.notifier)
                              .startEditing(); // 수정모드 on
                          context.go('/set-physical');
                        },
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                  profileAsync.when(
                    data: (profile) => Text.rich(
                      TextSpan(
                        children: [
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
                    spacing: 5,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text("질환", style: TextStyle(color: Colors.red)),
                      ),
                      diseasesAsync.when(
                        data: (diseases) {
                          return Text(
                            diseases.isEmpty ? "없음" : diseases.join(', '),
                          );
                        },
                        loading: () => const Text("정보를 불러오는 중.."),
                        error: (_, __) => const Text("정보를 불러오는 데 실패했습니다"),
                      ),
                    ],
                  ),

                  /// 알레르기
                  Row(
                    spacing: 5,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          "알레르기",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      allergiesAsync.when(
                        data: (allergies) {
                          return Text(
                            allergies.isEmpty ? "없음" : allergies.join(', '),
                          );
                        },
                        loading: () => const Text("정보를 불러오는 중.."),
                        error: (_, __) => const Text("정보를 불러오는 데 실패했습니다"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
