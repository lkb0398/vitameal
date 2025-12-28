import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  const Graph({super.key, required this.recentDatas});

  final List<double> recentDatas;

  @override
  Widget build(BuildContext context) {
    final maxValue = recentDatas.reduce(max);
    final minValue = recentDatas.reduce(min);
    final interval = (maxValue - minValue) / 5;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: LineChart(
        LineChartData(
          minY: minValue,
          maxY: maxValue,
          gridData: FlGridData(
            show: true,
            // 가로 그리드 선
            drawHorizontalLine: true,
            horizontalInterval: 25, // 5개
            getDrawingHorizontalLine: (value) =>
                FlLine(color: Colors.grey[200], strokeWidth: 1),
            // 세로 그리드 선
            drawVerticalLine: true,
            verticalInterval: 1, // 5개
            getDrawingVerticalLine: (value) =>
                FlLine(color: Colors.grey[200], strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            // 좌측 타이틀
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: interval, // 5개
                getTitlesWidget: (value, _) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            // 하단 타이틀
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1, // 1칸마다 1개 (5개)
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  if (index < 0 || index >= recentDatas.length) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      '$value', // 데이터 날짜+시간 바꾸기
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),

            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                recentDatas.length,
                (index) => FlSpot(index.toDouble(), recentDatas[index]),
              ),
              isCurved: false,
              color: Colors.redAccent,
              barWidth: 2,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.redAccent[100]!, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
