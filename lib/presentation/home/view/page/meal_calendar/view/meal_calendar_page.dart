import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vitameal/presentation/home/view/page/meal_calendar/view/widget/ai_analysis_card.dart';
import 'package:vitameal/presentation/home/view/page/meal_calendar/view/widget/calendar_header.dart';
import 'package:vitameal/presentation/home/view/page/meal_calendar/view/util/calendar_utils.dart';
import 'package:vitameal/presentation/home/view/page/meal_calendar/view/widget/dot_picker.dart';
import 'package:vitameal/presentation/home/view/page/meal_calendar/view/widget/meal_card.dart';
import 'package:vitameal/presentation/home/view/page/meal_calendar/view/widget/meal_calendar.dart';
import 'package:vitameal/presentation/util/date_time_utils.dart';

class MealCalendarPage extends HookWidget {
  const MealCalendarPage({super.key});

  // 년.월 라벨 + 요일 고정 영역 (40 + 40)
  static const double _headerHeight = 80;
  // Week 모드 높이 (화면 내렸을 때 표시되는 주 캘린더)
  static const double _weekCalendarHeight = 44;
  // Month 모드 행 개수 = 6주
  static const int _rowCount = 6;
  // 헤더 제외 공간 중 월 캘린더가 차지할 비율 (1.0 = 꽉차게)
  static const double _monthCalendarRatio = 1.0;

  @override
  Widget build(BuildContext context) {
    // UI 상태 값들
    final contentScrollController = useScrollController();
    final focusedDay = useState(DateTime.now()); // 현재 캘린더 페이지의 렌더링 기준이 되는 날
    final selectedDay = useState(DateTime.now().dateOnly); // 선택된 날짜
    final lastTappedDay = useState<DateTime?>(null); // 마지막으로 선택된 날짜
    final colorOfDay = useState<Map<DateTime, Color>>({}); // 성취도 평가 색상 바
    final dragStartY = useState<double?>(null); // 세로 드래그
    final dragEndY = useState<double?>(null); // 세로 드래그

    // 애니메이션 컨트롤러
    final collapseCtrl = useAnimationController(duration: const Duration(milliseconds: 360));

    /// 날짜 탭 인터렉션
    void onDayTapped(DateTime day) {
      final tapped = day.dateOnly;

      // 1회 탭했을 경우 선택만
      if (!CalendarUtils.isSameDay(tapped, selectedDay.value)) {
        selectedDay.value = tapped;
        focusedDay.value = tapped;
        lastTappedDay.value = tapped;

        // 애니메이션 중간에 다른 날짜 선택 시 Month 모드로 복귀
        if (collapseCtrl.value > 0 && collapseCtrl.value < 0.9) {
          collapseCtrl.animateTo(0.0, curve: Curves.easeOutCubic);
        }
        return;
      }

      // 선택된 상태에서 같은 날짜를 한 번 더 탭했을 경우 모드 전환
      final last = lastTappedDay.value;
      lastTappedDay.value = tapped;

      if (last != null && CalendarUtils.isSameDay(last, tapped)) {
        // Week 모드면 Month 모드로, Month 모드면 Week 모드로 전환
        if (collapseCtrl.value >= 0.9) {
          collapseCtrl.animateTo(0.0, curve: Curves.easeOutCubic);
        } else {
          collapseCtrl.animateTo(1.0, curve: Curves.easeOutCubic);
        }
      }
    }

    /// 페이지 변경 콜백. 좌우 스크롤 시 호출
    void onPageChanged(DateTime newFocused) {
      focusedDay.value = newFocused;
      // Week 모드에서만 selectedDay 업데이트 (Month 모드에서는 년.월만 업데이트)
      if (collapseCtrl.value >= 0.9) {
        selectedDay.value = newFocused.dateOnly;
        lastTappedDay.value = selectedDay.value;
      }
    }

    // 성취도 평가 색상 바
    void setColorBar(Color c) {
      colorOfDay.value = {...colorOfDay.value, selectedDay.value: c};
    }

    // 애니메이션 진행도 (0.0: Month 모드, 1.0: Week 모드)
    final t = useAnimation(collapseCtrl); // collapseCtrl.value 상태 구독

    // Week 모드 여부
    final isWeekMode = t >= 0.9;

    return Scaffold(
      body: SafeArea(
        top: true,
        // LayoutBuilder로 위젯 높이 기반 행높이 계산
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;

            // 월 캘린더 높이 (헤더 제외 영역)
            final monthCalendarHeight = (availableHeight - _headerHeight) * _monthCalendarRatio;
            // 행 높이 계산
            final rowHeightMonth = monthCalendarHeight / _rowCount;

            // 선택된 날짜가 속한 주
            final weekIndex = CalendarUtils.weekIndexInMonthGrid(
              focusedDay.value,
              selectedDay.value,
              rowCount: _rowCount,
            );
            // 행 높이를 애니메이션 진행에 따라 보간 (Month 모드 - Week 모드)
            final rowHeight = lerpDouble(rowHeightMonth, _weekCalendarHeight, t)!;
            // 애니메이션 진행에 따라 선택된 날짜가 속한 주를 맨 위로 올리기 위한 이동량
            final translateY = isWeekMode ? 0.0 : -weekIndex * rowHeight * t;

            // DayCell의 여백 높이 계산 (41 = DayCell의 날짜 부분 높이)
            final barAreaHeightMonth = math.max(0.0, rowHeightMonth - 41);
            // 애니메이션에 따라 없어질 때 보간
            final barArea = lerpDouble(barAreaHeightMonth, 0.0, t)!;

            // 애니메이션에 따른 TableCalendar 높이 계산
            final calendarHeight = lerpDouble(monthCalendarHeight, _weekCalendarHeight, t)!;

            return Column(
              children: [
                // 상단 고정 영역 (년.월 + 월화수목금토일)
                SizedBox(
                  height: _headerHeight,
                  child: CalendarHeader(focused: focusedDay.value),
                ),

                SizedBox(
                  // ClipRect와 calendarHeight를 통해 실제 보이는 부분 제어
                  height: calendarHeight,
                  child: ClipRect(
                    child: Stack(
                      children: [
                        // 스크롤 진행도에 따라 위로 translate 해서 선택 주가 맨 위에 오게
                        Transform.translate(
                          offset: Offset(0, translateY),
                          child: OverflowBox(
                            minHeight: monthCalendarHeight, // 오버플로우 방지, 항상 월 캘린더 높이로
                            maxHeight: monthCalendarHeight, // 오버플로우 방지, 항상 월 캘린더 높이로
                            alignment: Alignment.topCenter,
                            child: MonthCalendar(
                              focusedDay: focusedDay.value,
                              selectedDay: selectedDay.value,
                              rowHeight: rowHeight,
                              barAreaHeight: barArea,
                              barColorByDay: colorOfDay.value,
                              onDayTap: onDayTapped,
                              calendarFormat: isWeekMode ? CalendarFormat.week : CalendarFormat.month,
                              onPageChanged: onPageChanged,
                            ),
                          ),
                        ),

                        // 수직 드래그 감지
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            // 드래그 시작 위치 저장
                            onVerticalDragStart: (details) {
                              dragStartY.value = details.globalPosition.dy;
                              dragEndY.value = details.globalPosition.dy;
                            },
                            // 드래그 중 현재 위치 업데이트
                            onVerticalDragUpdate: (details) {
                              dragEndY.value = details.globalPosition.dy;
                            },
                            onVerticalDragEnd: (details) {
                              if (dragStartY.value == null || dragEndY.value == null) return;
                              // 드래그 방향 체크
                              final dragDistance = dragEndY.value! - dragStartY.value!;
                              dragStartY.value = null;
                              dragEndY.value = null;
                              // 최소 50px 드래그
                              if (dragDistance.abs() < 50) return;
                              // 위로 드래그 (Month -> Week)
                              if (dragDistance < 0) {
                                if (!isWeekMode) {
                                  collapseCtrl.animateTo(1.0, curve: Curves.easeOutCubic);
                                }
                              }
                              // 아래로 드래그 (Week -> Month)
                              else {
                                if (isWeekMode) {
                                  collapseCtrl.animateTo(0.0, curve: Curves.easeOutCubic);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 식단 내용 영역
                Expanded(
                  child: SingleChildScrollView(
                    controller: contentScrollController,
                    child: Column(
                      children: [
                        // 성취도 평가 위젯
                        DotPicker(
                          selectedDay: selectedDay.value,
                          rating: colorOfDay.value[selectedDay.value],
                          onPick: setColorBar,
                        ),
                        // 분석 카드
                        AiAnalysisCard(),
                        // 식단 카드 리스트
                        ...List.generate(12, (idx) => MealCard(index: idx)),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 식단 추가 기능 구현
        },
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
