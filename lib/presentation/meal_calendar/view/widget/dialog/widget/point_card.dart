import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class PointCard extends StatelessWidget {
  /// 포인트 카드 (condition에서도 재사용할수있도록 리팩토링 하기)
  const PointCard({
    super.key,
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
