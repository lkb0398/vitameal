import 'package:flutter/material.dart';

class IntroControls extends StatelessWidget {
  final int itemsCount;
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const IntroControls({
    super.key,
    required this.itemsCount,
    required this.currentIndex,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentIndex == itemsCount - 1;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // 페이지 인디케이터
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              itemsCount,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: currentIndex == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? const Color(0xFF8BC34A)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // 다음 버튼
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8BC34A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                "다음",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // 건너뛰기 버튼
          Opacity(
            opacity: isLastPage ? 0.0 : 1.0,
            child: TextButton(
              onPressed: isLastPage ? null : onSkip,
              child: const Text(
                "건너뛰기",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
