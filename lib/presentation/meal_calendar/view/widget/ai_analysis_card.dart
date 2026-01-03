import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AiAnalysisCard extends HookWidget {
  // AI 식단분석 결과 카드 위젯
  const AiAnalysisCard({super.key, this.title = 'AI 분석 결과', this.initialResultText, this.onAnalyze});

  final String title;
  // 초기부터 결과를 보여줄때 사용 (새 식단 추가 안됌 + 이미 분석결과가 있음)
  final String? initialResultText;
  final Future<String> Function()? onAnalyze;

  @override
  Widget build(BuildContext context) {
    final resultText = useState<String?>(initialResultText);
    final isLoading = useState(false);

    final hasResult = (resultText.value ?? '').trim().isNotEmpty;

    // 더미 로직, 데이터 연결 할때 vm으로 옮기기
    Future<void> handleAnalyze() async {
      if (isLoading.value) return;

      isLoading.value = true;

      try {
        if (onAnalyze != null) {
          final text = await onAnalyze!();
          resultText.value = text;
        } else {
          await Future.delayed(const Duration(milliseconds: 450)); // 로딩 상태 테스트용 딜레이
          resultText.value = '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용';
        }
      } finally {
        isLoading.value = false;
      }
    }

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
            child: hasResult
                ? _ResultText(key: const ValueKey('result'), text: resultText.value!)
                : _AnalyzeButton(
                    key: const ValueKey('button'),
                    label: isLoading.value ? '분석 중...' : '분석하기',
                    enabled: !isLoading.value,
                    onTap: handleAnalyze,
                  ),
          ),
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

class _ResultText extends StatelessWidget {
  /// 결과 텍스트
  const _ResultText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 12.5, height: 1.35, color: Colors.black87),
    );
  }
}
