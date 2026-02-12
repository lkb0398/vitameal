import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/info/view/widget/bordered_container.dart';
import 'package:vitameal/presentation/info/view/widget/graph.dart';
import 'package:vitameal/presentation/info/view/widget/guage.dart';
import 'package:vitameal/presentation/info/view/widget/tag_chip.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/ui_provider/goals_provider.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

class InfoPage extends HookConsumerWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('my userId : 🩷 ${Supabase.instance.client.auth.currentUser!.id}');

    final l = L10n.of(context)!; // 🌎
    final locale = ref.read(localeViewModelProvider);

    // 사용자 정보 불러오기
    final profileAsync = ref.watch(myProfileProvider);
    final diseasesAsync = ref.watch(userDiseaseLabelsProvider);
    final allergiesAsync = ref.watch(userAllergyLabelsProvider);

    // 목표 정보 불러오기
    final mainGoal = ref.watch(getMainGoalProvider);
    final startData = ref.watch(oldestMainGoalDataProvider);
    final currentData = ref.watch(latestMainGoalDataProvider);
    final current5Datas = ref.watch(latest5MainGoalDatasProvider);

    // 소수점 0 일 때 제거
    String formatNumber(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    // 기본 프로필 이미지
    Image defaultImg = Image.asset(
      'assets/images/profile_image_s.webp',
      height: 48,
      width: 48,
    );

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
                                  ? defaultImg
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
                            loading: () => defaultImg,
                            error: (_, __) => defaultImg,
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
                            error: (_, _) => const Text(""),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 내 정보 영역
                  BorderedContainer(
                    title: l.my_info,
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
                              if (profile.gender(locale!) == null &&
                                  profile.age == null &&
                                  profile.heightCm == null &&
                                  profile.weightKg == null) {
                                return null;
                              }
                              return Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: profile.gender(locale) != null
                                          ? "${profile.gender(locale)}   "
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
                                      text: profile.age != null
                                          ? l.year_old
                                          : null,
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
                                          ? "cm   "
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
                                          ? "kg"
                                          : null,
                                    ),
                                  ],
                                ),
                              );
                            },

                            loading: () => const Text(""),
                            error: (_, _) => Text(l.failed_loading_info),
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
                                error: (_, _) => Text(l.failed_loading_info),
                              );
                            },
                            loading: () => SizedBox.shrink(),
                            error: (_, _) => Text(l.failed_loading_info),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 건강 목표
                  BorderedContainer(
                    title: l.health_goals,
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
                              "${l.no_representative_goal} :(",
                              style: TextStyle(
                                fontSize: 16,
                                color: fxc(context).textcolor100,
                              ),
                            ),
                          ),
                  ),

                  /// 최근 그래프
                  BorderedContainer(
                    title: l.recent_graph,
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
                              l.add_data_hint,
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
