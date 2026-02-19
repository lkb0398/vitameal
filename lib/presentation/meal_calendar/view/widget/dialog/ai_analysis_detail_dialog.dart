import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/meal_analysis_entity.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/dialog/page/condition_feedback_page.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/dialog/page/general_feedback_page.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/dialog/widget/page_indicator.dart';

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
                      child: ConditionFeedbackPage(feedback: feedback),
                    );
                  },
                ),
              )
            else
              Expanded(child: GeneralFeedbackPage(analysis: analysis)),

            const SizedBox(height: 16),

            // 페이지 인디케이터
            if (pageCount > 1) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: PageIndicator(
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
