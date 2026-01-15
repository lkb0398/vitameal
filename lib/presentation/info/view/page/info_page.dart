import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/info/view/widget/bordered_container.dart';
import 'package:vitameal/presentation/info/view/widget/graph.dart';
import 'package:vitameal/presentation/info/view/widget/guage.dart';
import 'package:vitameal/presentation/info/view/widget/tag_chip.dart';
import 'package:vitameal/presentation/ui_provider/goals_provider.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

class InfoPage extends HookConsumerWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('my userId : 🩷 ${Supabase.instance.client.auth.currentUser!.id}');

    // 사용자 정보 불러오기
    final profileAsync = ref.watch(myProfileProvider);
    final diseasesAsync = ref.watch(userSelectedDiseasesProvider);
    final allergiesAsync = ref.watch(userSelectedAllergiesProvider);

    // 목표 정보 불러오기
    final mainGoal = ref.watch(getMainGoalProvider);
    final startData = ref.watch(oldestMainGoalDataProvider);
    final currentData = ref.watch(latestMainGoalDataProvider);
    final current5Datas = ref.watch(latest5MainGoalDatasProvider);

    // 소수점 0 일 때 제거
    String formatNumber(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 10),
        actions: [
          IconButton(
            onPressed: () => context.push('/setting'),
            icon: Icon(
              PhosphorIcons.gearSix(),
              size: 24,
              color: vrc(context).text,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            spacing: 20,
            children: [
              Column(
                spacing: 20,
                children: [
                  /// 프로필 이미지 + 닉네임
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        context.push('/edit/profile');
                      },
                      child: Row(
                        spacing: 14,
                        children: [
                          profileAsync.when(
                            data: (profile) {
                              return profile!.photoUrl == null
                                  ? Image.asset(
                                      'assets/images/profile_image_s.webp',
                                      height: 48,
                                      width: 48,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: SizedBox(
                                        height: 48,
                                        width: 48,
                                        child: CachedNetworkImage(
                                          imageUrl: profile.photoUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                            },
                            loading: () {
                              return Image.asset(
                                'assets/images/profile_image_s.webp',
                                height: 48,
                                width: 48,
                              );
                            },
                            error: (_, __) {
                              return Image.asset(
                                'assets/images/profile_image_s.webp',
                                height: 48,
                                width: 48,
                              );
                            },
                          ),

                          profileAsync.when(
                            data: (profile) => Text(
                              "${profile?.nickname}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            loading: () => const Text(""),
                            error: (_, _) =>
                                Center(child: Text('정보를 불러오지 못했습니다')),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 내 정보 영역
                  BorderedContainer(
                    title: "내 정보",
                    onTap: () => context.push('/edit/physical'),
                    child: Column(
                      spacing: 10,
                      children: [
                        /// 기본 정보
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: profileAsync.when(
                            data: (profile) {
                              if (profile == null) {
                                return null;
                              }
                              if (profile.gender == null &&
                                  profile.age == null &&
                                  profile.heightCm == null &&
                                  profile.weightKg == null) {
                                return null;
                              }
                              return Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: profile.gender != null
                                          ? "${profile.gender}  "
                                          : null,
                                    ),
                                    TextSpan(
                                      text: profile.age != null
                                          ? "${profile.age}"
                                          : null,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: profile.age != null ? " 세  " : null,
                                    ),
                                    TextSpan(
                                      text: profile.heightCm != null
                                          ? formatNumber(profile.heightCm!)
                                          : null,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: profile.heightCm != null
                                          ? " cm  "
                                          : null,
                                    ),
                                    TextSpan(
                                      text: profile.weightKg != null
                                          ? formatNumber(profile.weightKg!)
                                          : null,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: profile.weightKg != null
                                          ? " kg"
                                          : null,
                                    ),
                                  ],
                                ),
                              );
                            },

                            loading: () => const Text(""),
                            error: (_, _) =>
                                Center(child: Text('정보를 불러오지 못했습니다')),
                          ),
                        ),

                        /// 질환 + 알레르기
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: diseasesAsync.when(
                            data: (diseases) {
                              return allergiesAsync.when(
                                data: (allergies) {
                                  final tags = [
                                    ...diseases.map(
                                      (e) => UserTag(
                                        label: e,
                                        type: TagType.disease,
                                      ),
                                    ),
                                    ...allergies.map(
                                      (e) => UserTag(
                                        label: e,
                                        type: TagType.allergy,
                                      ),
                                    ),
                                  ];

                                  return Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: tags
                                        .map((e) => TagChip(e))
                                        .toList(),
                                  );
                                },
                                loading: () => SizedBox.shrink(),
                                error: (_, _) =>
                                    Center(child: Text('정보를 불러오지 못했습니다')),
                              );
                            },
                            loading: () => SizedBox.shrink(),
                            error: (_, _) =>
                                Center(child: Text('정보를 불러오지 못했습니다')),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 건강 목표
                  BorderedContainer(
                    title: "건강 목표",
                    subtitle: mainGoal != null
                        ? '${mainGoal.goalTitle}  ${mainGoal.goalDate.year}.${mainGoal.goalDate.month.toString().padLeft(2, '0')}.${mainGoal.goalDate.day.toString().padLeft(2, '0')}'
                        : null,
                    onTap: () => context.push('/goal'),
                    child: mainGoal != null
                        ? Guage(
                            startData: startData,
                            currentData: currentData,
                            targetValue: mainGoal.goalValue,
                          )
                        : Center(
                            child: Text(
                              "대표 설정한 목표가 없어요 :(",
                              style: TextStyle(
                                fontSize: 16,
                                color: fxc(context).textcolor100,
                              ),
                            ),
                          ),
                  ),

                  /// 최근 그래프
                  BorderedContainer(
                    title: "최근 그래프",
                    subtitle: mainGoal != null
                        ? '${mainGoal.goalTitle}  ${mainGoal.goalUnit}'
                        : null,
                    onTap: () {
                      mainGoal != null
                          ? context.push('/data', extra: mainGoal.goalId)
                          : null;
                    },
                    child: mainGoal != null
                        ? Graph(datas: current5Datas ?? [])
                        : Center(
                            child: Text(
                              "데이터를 추가해 주세요.",
                              style: TextStyle(
                                fontSize: 16,
                                color: fxc(context).textcolor100,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
