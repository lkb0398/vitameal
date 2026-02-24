import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/meal_analysis_entity.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/dialog/widget/info_link.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/dialog/widget/point_card.dart';

class GeneralFeedbackPage extends StatelessWidget {
  /// 일반적인 영양피드백 페이지
  const GeneralFeedbackPage({super.key, required this.analysis});

  final MealAnalysisEntity analysis;

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!;
    final nf = analysis.nutritionFeedback;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 컬러 라벨
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF7ED321).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              l.meal_analysis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7ED321),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 요약
          Text(
            analysis.overallSummary,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: vrc(context).content,
            ),
          ),
          const SizedBox(height: 20),

          // 주요 포인트
          if (nf.goodPoints.isNotEmpty || nf.improvePoints.isNotEmpty) ...[
            Text(
              l.key_points,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: vrc(context).text,
              ),
            ),
            const SizedBox(height: 8),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch, // 높이 꽉 채우기
                children: [
                  Expanded(
                    child: PointCard(
                      title: l.good_thing,
                      icon: PhosphorIcons.checkCircle(),
                      points: nf.goodPoints,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PointCard(
                      title: l.bad_thing,
                      icon: PhosphorIcons.warningCircle(),
                      points: nf.improvePoints,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],

          // 개선 제안
          if (nf.nextActions.isNotEmpty) ...[
            Text(
              l.next_step,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: vrc(context).text,
              ),
            ),
            const SizedBox(height: 8),
            ...nf.nextActions.map(
              (a) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: vrc(context).dlgSurface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: vrc(context).dlgBorder ?? Colors.black12,
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: vrc(context).text,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        a.detail,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: vrc(context).content,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

          // 출처 및 건강 정보 안내
          SizedBox(height: 20),
          InfoLink(),
        ],
      ),
    );
  }
}
