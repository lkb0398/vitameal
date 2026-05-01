import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/info/view_model/main_goal_view_model.dart';
import 'package:vitameal/presentation/ui_provider/formatted_date_provider.dart';

class Graph extends HookConsumerWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = fxc(context);
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    final datas = ref.watch(mainGoalViewModelProvider).latest5Datas ?? [];

    // 데이터 없을 때 화면
    if (datas.isEmpty) {
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

    // data_value 리스트 추출
    final sortedDatas = [...datas]
      ..sort((a, b) => a.dataDate.compareTo(b.dataDate));
    final values = sortedDatas.map((e) => e.dataValue).toList();

    final maxValue = values.reduce(max);
    final minValue = values.reduce(min);
    final gap = maxValue - minValue;
    final interval = (gap / 4).toInt();

    return Container(
      padding: EdgeInsets.all(10),
      height: 180,
      child: LineChart(
        LineChartData(
          minY: minValue,
          maxY: maxValue,

          /// ===== Grid =====
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            horizontalInterval: interval == 0 ? 1 : interval.toDouble(),
            getDrawingHorizontalLine: (value) =>
                FlLine(color: vrc(context).greyBackground, strokeWidth: 1),
            drawVerticalLine: true,
            verticalInterval: 1,
            getDrawingVerticalLine: (value) =>
                FlLine(color: vrc(context).greyBackground, strokeWidth: 1),
          ),

          /// ===== Titles =====
          titlesData: FlTitlesData(
            // 좌측 (data_value)
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: interval == 0 ? 1 : interval.toDouble(),
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final isMin = (value - minValue).abs() < interval / 10;
                  final isMax = (value - maxValue).abs() < interval / 10;
                  if (isMin || isMax) {
                    return const SizedBox.shrink(); // min / max 표시 X
                  }
                  return Text(
                    value % 1 == 0
                        ? value.toInt().toString()
                        : value.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: f.textcolor300,
                    ),
                  );
                },
              ),
            ),
            // 하단 (data_date)
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  if (index < 0 || index >= sortedDatas.length) {
                    return const SizedBox.shrink();
                  }
                  final date = sortedDatas[index].dataDate;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      ref.watch(formattedDateProvider(date, showYear: false)),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: f.textcolor300,
                      ),
                    ),
                  );
                },
              ),
            ),

            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),

          /// ===== Line =====
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                sortedDatas.length,
                (index) =>
                    FlSpot(index.toDouble(), sortedDatas[index].dataValue),
              ),
              isCurved: false,
              color: f.secondary400,
              barWidth: 1,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 3,
                    color: vrc(context).infoContainer!,
                    strokeWidth: 1,
                    strokeColor: f.secondary400!,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [f.secondary400!, v.background!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],

          /// ===== Touch =====
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (LineBarSpot spot) {
                return f.secondary400!; // 배경색
              },
              tooltipBorderRadius: BorderRadius.circular(8),
              tooltipPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              tooltipMargin: 8,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    spot.y % 1 == 0
                        ? spot.y.toInt().toString()
                        : spot.y.toStringAsFixed(1),
                    TextStyle(
                      color: Colors.white, // 텍스트 색
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
