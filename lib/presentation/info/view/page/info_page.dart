import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/info/view/widget/bordered_container.dart';
import 'package:vitameal/presentation/info/view/widget/graph.dart';
import 'package:vitameal/presentation/info/view/widget/guage.dart';
import 'package:vitameal/presentation/info/view/widget/view_physical.dart';
import 'package:vitameal/presentation/info/view/widget/view_profile.dart';
import 'package:vitameal/presentation/info/view_model/main_goal_view_model.dart';
import 'package:vitameal/presentation/ui_provider/formatted_date_provider.dart';

class InfoPage extends ConsumerWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    return Scaffold(
      /// 앱바
      appBar: AppBar(
        actionsPadding: const EdgeInsets.only(right: 10),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutePath.setting),
            icon: PhosphorIcon(PhosphorIcons.gearSix(), color: v.text),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            children: [
              /// 프로필 영역
              const ViewProfile(),

              /// 내 정보 영역
              const ViewPhysical(),

              Consumer(
                builder: (context, ref, _) {
                  final mainGoal = ref
                      .watch(mainGoalViewModelProvider)
                      .mainGoal;

                  return Column(
                    spacing: 20,
                    children: [
                      /// 건강 목표 영역
                      BorderedContainer(
                        title: l.health_goals,
                        subtitle: mainGoal != null
                            ? '${mainGoal.goalTitle}  ${ref.watch(formattedDateProvider(mainGoal.goalDate))}'
                            : null,
                        onTap: () => context.push(AppRoutePath.goal),
                        child: mainGoal != null
                            ? const Guage()
                            : _noGoalText(context, l.no_representative_goal),
                      ),

                      /// 최근 그래프 영역
                      BorderedContainer(
                        title: l.recent_graph,
                        subtitle: mainGoal != null
                            ? '${mainGoal.goalTitle}  ${mainGoal.goalUnit}'
                            : null,
                        onTap: () {
                          if (mainGoal != null) {
                            context.push(AppRoutePath.data, extra: mainGoal);
                          }
                        },
                        child: mainGoal != null
                            ? const Graph()
                            : _noGoalText(context, l.add_data_hint),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noGoalText(BuildContext context, String text) {
    final f = fxc(context);

    return Center(
      child: Text(
        "$text :(",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: f.textcolor100,
        ),
      ),
    );
  }
}
