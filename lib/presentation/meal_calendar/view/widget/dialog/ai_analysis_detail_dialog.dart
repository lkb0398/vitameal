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
    final hasConditionPages = conditionFeedbacks.isNotEmpty;
    // 기저질환 피드백 페이지 + 마지막에 영양분석 페이지 1개
    final totalPages = conditionFeedbacks.length + 1;
    final isLastPage = currentPage.value == totalPages - 1;

    final headerTitle = hasConditionPages
        ? (isLastPage ? l.meal_analysis : l.feedback)
        : l.meal_feedback;

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
                  Text(
                    headerTitle,
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
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: totalPages,
                itemBuilder: (context, index) {
                  if (!hasConditionPages || index == totalPages - 1) {
                    // 마지막 페이지 일반 영양피드백
                    return GeneralFeedbackPage(analysis: analysis);
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: ConditionFeedbackPage(
                      // 기저질환피드백
                      feedback: conditionFeedbacks[index],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // 페이지 인디케이터
            if (hasConditionPages) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: PageIndicator(
                  pageCount: totalPages,
                  currentPage: currentPage.value,
                  onPrev: () => pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  onNext: () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
            ] else
              const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
