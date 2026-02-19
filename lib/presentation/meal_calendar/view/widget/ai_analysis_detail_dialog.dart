import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/meal_analysis_entity.dart';
import 'package:vitameal/presentation/meal_calendar/view/util/link_launcher.dart';

class AiAnalysisDetailDialog extends HookWidget {
  /// AI 분석 자세히 보기 대화상자.
  /// 기저질환이 없을경우 일반적인 영양피드백 출력. 있을경우 기저질환별 피드백 출력.
  const AiAnalysisDetailDialog({super.key, required this.analysis});

  final MealAnalysisEntity analysis;

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!; // 🌎

    final pageController = usePageController();
    final currentPage = useState(0);

    // 페이지 변경 감지
    useEffect(() {
      void listener() {
        currentPage.value = pageController.page?.round() ?? 0;
      }

      pageController.addListener(listener);
      return () => pageController.removeListener(listener);
    }, [pageController]);

    final conditionFeedbacks = analysis.conditionFeedback;
    final pageCount = conditionFeedbacks.length;
    final hasPages = pageCount > 0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  hasPages
                      ? Text(
                          l.feedback,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: vrc(context).text,
                          ),
                        )
                      : Text(
                          '식단 피드백',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: vrc(context).text,
                          ),
                        ),
                  IconButton(
                    icon: Icon(PhosphorIcons.x()),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 페이지 뷰 (슬라이드)
            if (hasPages)
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: pageCount,
                  itemBuilder: (context, index) {
                    final feedback = conditionFeedbacks[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: _ConditionFeedbackPage(feedback: feedback),
                    );
                  },
                ),
              )
            else
              Expanded(child: _GeneralFeedbackPage(analysis: analysis)),

            const SizedBox(height: 16),

            // 페이지 인디케이터
            if (pageCount > 1) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _PageIndicator(
                  pageCount: pageCount,
                  currentPage: currentPage.value,
                ),
              ),
            ],

            if (!hasPages) const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

class _ConditionFeedbackPage extends StatelessWidget {
  /// 기저질환별 피드백 페이지
  const _ConditionFeedbackPage({required this.feedback});

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
          _InfoLink(),
        ],
      ),
    );
  }
}

class _GeneralFeedbackPage extends StatelessWidget {
  /// 일반적인 영양피드백 페이지
  const _GeneralFeedbackPage({required this.analysis});

  final MealAnalysisEntity analysis;

  @override
  Widget build(BuildContext context) {
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
              '식단 분석',
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
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch, // 높이 꽉 채우기
                children: [
                  Expanded(
                    child: _PointCard(
                      title: '좋아요',
                      icon: PhosphorIcons.checkCircle(),
                      points: nf.goodPoints,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _PointCard(
                      title: '아쉬워요',
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
              '다음 식사에 참고해보세요',
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
          _InfoLink(),
        ],
      ),
    );
  }
}

class _PointCard extends StatelessWidget {
  /// 포인트 카드 (재사용할수있도록 리팩토링 하기)
  const _PointCard({
    required this.title,
    required this.icon,
    required this.points,
  });

  final String title;
  final IconData icon;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: vrc(context).dlgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: vrc(context).dlgBorder ?? Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: vrc(context).text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (points.isEmpty)
            Text(
              '• 충분히 잘하고 있어요.',
              style: TextStyle(fontSize: 12, color: vrc(context).content),
            )
          else
            ...points
                .take(4)
                .map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $p',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.35,
                        color: vrc(context).content,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  /// 페이지 인디케이터
  const _PageIndicator({required this.pageCount, required this.currentPage});

  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == currentPage ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == currentPage
                ? const Color(0xFF7ED321)
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _InfoLink extends StatelessWidget {
  /// 출처 및 건강 정보 안내
  const _InfoLink();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.info_outline, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        TextButton(
          onPressed: LinkLauncher.openNotion,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            l.source_info,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
