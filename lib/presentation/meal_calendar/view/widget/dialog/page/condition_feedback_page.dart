import 'package:flutter/material.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/meal_analysis_entity.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/dialog/widget/info_link.dart';

class ConditionFeedbackPage extends StatelessWidget {
  /// 기저질환별 피드백 페이지
  const ConditionFeedbackPage({super.key, required this.feedback});

  final ConditionFeedback feedback;

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!; // 🌎

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 컬러 라벨 (질환명)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF7ED321).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              feedback.condition,
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
            feedback.summary,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: vrc(context).content,
            ),
          ),
          const SizedBox(height: 20),

          // 주요 포인트
          if (feedback.points.isNotEmpty) ...[
            Text(
              l.key_points,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: vrc(context).text,
              ),
            ),
            const SizedBox(height: 8),
            ...feedback.points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 14,
                        color: vrc(context).content,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: vrc(context).content,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],

          // 개선 제안
          if (feedback.suggestions.isNotEmpty) ...[
            Text(
              l.suggestions,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: vrc(context).text,
              ),
            ),
            const SizedBox(height: 8),
            ...feedback.suggestions.map(
              (suggestion) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: vrc(context).dlgSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: vrc(context).dlgBorder!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: vrc(context).text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      suggestion.detail,
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
          ],

          // 출처 및 건강 정보 안내
          const SizedBox(height: 20),
          InfoLink(),
        ],
      ),
    );
  }
}
