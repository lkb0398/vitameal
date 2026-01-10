import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/constants/analysis_policy.dart';

class AiAnalysisCard extends HookConsumerWidget {
  // AI 식단분석 결과 카드 위젯
  const AiAnalysisCard({
    super.key,
    required this.mealDayId,
    required this.needsAiRefresh,
    this.latestAiSummary,
    required this.todayCount,
    required this.isCountLoading,
    required this.hasEntries,
    required this.onAnalyze,
    required this.onOpenDetail,
    this.title = 'AI 분석 결과',
  });

  final String mealDayId;
  final bool needsAiRefresh; // 분석하기 버튼 활성화 여부
  final String? latestAiSummary; // 마지막 분석 (로컬의 meal_day)
  final int todayCount; // 오늘 사용한 분석 횟수
  final bool isCountLoading; // 오늘 사용한 분석횟수를 서버에서 가져오는중
  final bool hasEntries; // Entry가 있는지 여부. 없을때 버튼 예외처리용
  final Future<void> Function() onAnalyze; // 분석하기
  final Future<void> Function() onOpenDetail; // 자세히보기
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnalyzing = useState(false); // 분석 트랜잭션 플래그

    /// 네트워크 체크
    Future<bool> isOnline() async {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    }

    /// AI 분석 요청
    Future<void> handleAnalyze() async {
      if (isAnalyzing.value) return;

      // 오프라인 체크
      final online = await isOnline();
      if (!online) {
        if (context.mounted) {
          // TODO : 지금 동작안하고 그냥 에러 메세지 출력됨
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('네트워크 연결을 확인해주세요'), duration: Duration(seconds: 2)));
        }
        return;
      }

      // 온라인일 경우만 분석 수행
      isAnalyzing.value = true;
      try {
        if (!context.mounted) return;
        await onAnalyze();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('분석 실패: $e')));
        }
      } finally {
        isAnalyzing.value = false;
      }
    }

    /// 자세히 보기
    Future<void> handleOpenDetail() async {
      // 오프라인 환경에서 명시적 예외처리
      final online = await isOnline();
      if (!online) {
        if (context.mounted) {
          // TODO : 현재 동작 안함, 에러 메세지 그냥 출력됨
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

      if (!context.mounted) return;
      await onOpenDetail();
    }

    // 기존 요약 있는지 여부
    final hasSummary = (latestAiSummary ?? '').trim().isNotEmpty;
    // 분석 가능 여부
    final canAnalyze = !isCountLoading && todayCount < AnalysisPolicy.maxDailyAnalysisCount;
    // 분석 버튼이 보일때
    final showAnalyzeButton = hasEntries && (!hasSummary || needsAiRefresh);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: fxc(context).primary400!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(title: title),
          const SizedBox(height: 8),
          // 요약이 있으면 요약 보여주고 자세히 보기 제공
          if (hasSummary) ...[
            _ResultTextWithDetail(text: latestAiSummary!, onDetailTap: () => handleOpenDetail()),

            // 식단 변경으로 재분석이 필요하면 분석 버튼 활성화
            if (needsAiRefresh) ...[
              const SizedBox(height: 10),
              // 애니메이션으로 최대한 부드럽게 연결
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: hasEntries
                    ? _AnalyzeButton(
                        key: const ValueKey('analyze_button'),
                        // TODO : vm 쪽에서 label 결정하도록 리팩토링 하기
                        label: isAnalyzing.value || isCountLoading
                            ? '분석 중...'
                            : canAnalyze
                            ? '다시 분석하기 ($todayCount/${AnalysisPolicy.maxDailyAnalysisCount})'
                            : '오늘 분석 횟수를 모두 사용했어요 ($todayCount/${AnalysisPolicy.maxDailyAnalysisCount})',
                        enabled: !isAnalyzing.value && canAnalyze,
                        onTap: handleAnalyze,
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
            ],
          ] else
            // 요약이 없을 때: 식단이 있으면 분석 버튼, 없으면 메세지 표시
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _AnalyzeButton(
                key: const ValueKey('analyze_button'),
                label: isAnalyzing.value || isCountLoading
                    ? '분석 중...'
                    : canAnalyze
                    ? '분석하기 $todayCount/${AnalysisPolicy.maxDailyAnalysisCount}'
                    : '오늘 분석 횟수를 모두 사용했어요 $todayCount/${AnalysisPolicy.maxDailyAnalysisCount}',
                enabled: !isAnalyzing.value && canAnalyze,
                onTap: handleAnalyze,
              ),
            ),
          if (showAnalyzeButton) ...[
            const SizedBox(height: 6),
            Text(' 분석은 매일 12시 갱신되며, 하루 3회까지 가능합니다', style: TextStyle(fontSize: 12, color: vrc(context).border)),
          ],
        ],
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
        Icon(PhosphorIcons.sparkle(), size: 20, color: fxc(context).primary400),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: fxc(context).primary400),
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
    return SizedBox(
      height: 48,
      child: enabled
          ? DecoratedBox(
              decoration: BoxDecoration(
                // 활성화 상태일경우 그라데이션
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // border 그라데이션
                  colors: [Color(0xFFD2F291), Color(0xFF89CC00)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                // border 처럼 보이도록
                padding: const EdgeInsets.all(1),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      // 그라데이션 방향
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      // 내부 채우기 그라데이션
                      colors: [Color(0xFFCFFF6E), Color(0xFF89CC00), Color(0xFF6F9F0B)],
                      // 그라데이션 비율
                      stops: [0.0, 0.6, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(8 - 1),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      // 활성화 상태에서만 onTap
                      onTap: enabled ? onTap : null,
                      borderRadius: BorderRadius.circular(8 - 1),
                      child: Center(
                        child: Text(
                          label,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : DecoratedBox(
              decoration: BoxDecoration(color: vrc(context).imagePlusIcon, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
    );
  }
}

class _ResultTextWithDetail extends StatelessWidget {
  /// 분석 결과 요약 + 자세히 보기 버튼
  const _ResultTextWithDetail({required this.text, required this.onDetailTap});
  final String text;
  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, height: 1.35, color: vrc(context).text),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onDetailTap,
          child: Text(
            '자세히보기',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fxc(context).primary400,
              decoration: TextDecoration.underline,
              decorationColor: fxc(context).primary400,
            ),
          ),
        ),
      ],
    );
  }
}
