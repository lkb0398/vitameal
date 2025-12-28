import 'dart:math' as math;

import 'package:flutter/material.dart';

class Guage extends StatelessWidget {
  const Guage({
    super.key,
    required this.startValue,
    required this.currentValue,
    required this.targetValue,
  });

  final double startValue;
  final double currentValue;
  final double targetValue;

  @override
  Widget build(BuildContext context) {
    double percent =
        (currentValue - startValue).abs() / (targetValue - startValue).abs();
    if (percent > 1) percent = 1;

    return Column(
      spacing: 20,
      children: [
        /// 게이지
        SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(230, 120), // width (반원 크기 조절), height
                painter: GaugePainter(percent),
              ),
              Positioned(
                top: 60,
                child: Text(
                  '${(percent * 100).round()}%',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        /// 수치
        SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('초기 : $startValue'),
              Text('현재 : $currentValue'),
              Text('목표 : $targetValue'),
            ],
          ),
        ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  GaugePainter(this.percent);

  final double percent;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height); // 원의 중심
    final radius = size.width / 2; // 반지름

    // 전체 게이지
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = Colors.red[100]!
        ..strokeWidth = 18
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // 달성도 게이지
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * percent,
      false,
      Paint()
        ..color = Colors.redAccent
        ..strokeWidth = 18
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
