import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  /// 페이지 인디케이터
  const PageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
    this.onPrev,
    this.onNext,
  });

  final int pageCount;
  final int currentPage;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  static const _green = Color(0xFF7ED321);

  @override
  Widget build(BuildContext context) {
    final hasPrev = currentPage > 0;
    final hasNext = currentPage < pageCount - 1;

    final dots = List.generate(
      pageCount,
      (index) => AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: index == currentPage ? 22 : 7,
        height: 7,
        decoration: BoxDecoration(
          color: index == currentPage ? _green : Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _ArrowButton(
          icon: Icons.arrow_back_ios_new_rounded,
          visible: hasPrev,
          filled: false,
          onTap: hasPrev ? onPrev : null,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dots,
            ),
          ),
        ),
        _ArrowButton(
          icon: Icons.arrow_forward_ios_rounded,
          visible: hasNext,
          filled: true,
          onTap: hasNext ? onNext : null,
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.visible,
    required this.filled,
    this.onTap,
  });

  final IconData icon;
  final bool visible;
  final bool filled;
  final VoidCallback? onTap;

  static const _green = Color(0xFF7ED321);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 180),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled
                ? _green.withValues(alpha: 0.15)
                : Colors.grey.withValues(alpha: 0.12),
          ),
          child: Icon(
            icon,
            size: 14,
            color: filled ? _green : Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
