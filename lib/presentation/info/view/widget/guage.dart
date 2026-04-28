import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/info/view_model/main_goal_view_model.dart';
import 'package:vitameal/presentation/util/remove_decimals.dart';

class Guage extends ConsumerWidget {
  const Guage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final l = L10n.of(context)!; // 🌎

    final state = ref.watch(mainGoalViewModelProvider);
    final mainGoal = state.mainGoal;
    final startData = state.oldestData;
    final currentData = state.latestData;

    // 데이터 없을 때 화면
    if (startData == null || currentData == null) {
      return Center(
        child: Text(
          l.add_data_hint,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: f.textcolor100,
          ),
        ),
      );
    }

    final startValue = startData.dataValue;
    final currentValue = currentData.dataValue;
    final targetValue = mainGoal!.goalValue;

    // 퍼센티지 계산
    double computePercent({
      required double start,
      required double current,
      required double target,
    }) {
      final total = (target - start);
      if (total == 0) return 1.0;
      final progress = (current - start);
      final raw = progress / total;
      return raw.clamp(0.0, 1.0);
    }

    final percent = computePercent(
      start: startValue,
      current: currentValue,
      target: targetValue,
    );

    return Column(
      spacing: 20,
      children: [
        /// 게이지
        SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(220, 130), // width (반원 크기 조절), height
                painter: GaugePainter(context, percent),
              ),
              Positioned(
                top: 80,
                child: Text(
                  '${(percent * 100).round()}%',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),

        /// 수치
        SizedBox(
          width: 260,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _valueText(context, l.initial, startValue),
              _valueText(context, l.current, currentValue),
              _valueText(context, l.target, targetValue),
            ],
          ),
        ),
      ],
    );
  }

  Widget _valueText(BuildContext context, String label, double value) {
    final f = fxc(context);

    return Text(
      '$label: ${removeDecimals(value)}',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: f.textcolor300,
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  GaugePainter(this.context, this.percent);

  final BuildContext context;
  final double percent;

  @override
  void paint(Canvas canvas, Size size) {
    final f = fxc(context);

    final center = Offset(size.width / 2, size.height); // 원의 중심
    final radius = size.width / 2; // 반지름

    // 전체 게이지
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = f.secondary100!
        ..strokeWidth = 22
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
        ..color = f.secondary400!
        ..strokeWidth = 22
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
