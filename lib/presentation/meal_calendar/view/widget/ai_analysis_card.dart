import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/domain/entity/meal_analysis_entity.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/ai_analysis_detail_dialog.dart';
import 'package:vitameal/presentation/meal_calendar/view_model/meal_analysis_viewmodel.dart';
import 'package:vitameal/presentation/ui_provider/meal_provider.dart';

class AiAnalysisCard extends HookConsumerWidget {
  // AI 식단분석 결과 카드 위젯
  const AiAnalysisCard({super.key, required this.mealDayId, this.title = 'AI 분석 결과'});

  final String mealDayId;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(latestMealAnalysisProvider(mealDayId));
    final isAnalyzing = useState(false);

    // 오프라인 체크
    Future<bool> isOnline() async {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    }

    // AI 분석 요청
    Future<void> analyze() async {
      if (isAnalyzing.value) return;

      // 오프라인 체크
      final online = await isOnline();
      if (!online) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('네트워크 연결을 확인해주세요'), duration: Duration(seconds: 2)));
        }
        return; // 버튼 상태 유지
      }

      isAnalyzing.value = true;
      try {
        // Provider(vm)가 dispose 되는 문제 해결
        // disposed 체크
        if (!context.mounted) {
          return;
        }
        // viewModel을 build 시점이 아닌 사용 시점에 읽기!
        final viewModel = ref.read(mealAnalysisViewModelProvider.notifier);
        await viewModel.requestAnalysis(mealDayId);

        // 분석 완료 후 Provider 갱신
        if (context.mounted) {
          ref.invalidate(latestMealAnalysisProvider(mealDayId));
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('분석 실패: $e')));
        }
      } finally {
        isAnalyzing.value = false;
      }
    }

    // 자세히 보기 대화상자 출력
    Future<void> showDetailDialog(MealAnalysisEntity analysis) async {
      // 오프라인 체크
      final online = await isOnline();
      if (!online) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('네트워크 연결 필요'),
              content: const Text('자세한 분석 결과를 보려면 인터넷 연결이 필요합니다.'),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('확인'))],
            ),
          );
        }
        return;
      }

      // 온라인일 때만 상세 대화상자 표시
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AiAnalysisDetailDialog(analysis: analysis),
        );
      }
    }

    return analysisAsync.when(
      data: (analysis) {
        final hasAnalysis = analysis != null;

        return Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE9E9E9)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(title: title),
              const SizedBox(height: 10),
              // AnimatedSwitcher 사용하기 위해 위젯에 키 추가
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: hasAnalysis
                    ? _ResultTextWithDetail(
                        key: const ValueKey('result'),
                        text: analysis.overallSummary,
                        onDetailTap: () => showDetailDialog(analysis),
                      )
                    : _AnalyzeButton(
                        key: const ValueKey('button'),
                        label: isAnalyzing.value ? '분석 중...' : '분석하기',
                        enabled: !isAnalyzing.value,
                        onTap: analyze,
                      ),
              ),
            ],
          ),
        );
      },
      loading: () => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE9E9E9)),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE9E9E9)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(title: title),
            const SizedBox(height: 10),
            _AnalyzeButton(
              label: isAnalyzing.value ? '분석 중...' : '분석하기',
              enabled: !isAnalyzing.value,
              onTap: analyze,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  // 카드 헤더
  const _Header({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.auto_awesome, size: 16, color: Colors.black87),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
      ],
    );
  }
}

class _AnalyzeButton extends StatelessWidget {
  /// 분석하기 버튼
  const _AnalyzeButton({super.key, required this.label, required this.onTap, required this.enabled});

  final String label;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.7,
        child: Container(
          height: 48,
          decoration: BoxDecoration(color: const Color(0xFF7ED321), borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}

class _ResultTextWithDetail extends StatelessWidget {
  /// 결과 텍스트 + 자세히 보기 버튼
  const _ResultTextWithDetail({super.key, required this.text, required this.onDetailTap});
  final String text;
  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12.5, height: 1.35, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onDetailTap,
          child: const Text(
            '자세히보기',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7ED321),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
