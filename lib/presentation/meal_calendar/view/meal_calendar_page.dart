import 'dart:math' as math;
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/meal_day_entity.dart';
import 'package:vitameal/presentation/auth/view_model/auth_view_model.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/ai_analysis_card.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/dialog/ai_analysis_detail_dialog.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/calendar_header.dart';
import 'package:vitameal/presentation/meal_calendar/view/util/calendar_utils.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/adherence_picker.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/meal_card.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/meal_calendar.dart';
import 'package:vitameal/presentation/meal_calendar/view/util/adherence_color_utils.dart';
import 'package:vitameal/core/util/date_time_utils.dart';
import 'package:vitameal/presentation/meal_calendar/view_model/meal_analysis_viewmodel.dart';
import 'package:vitameal/presentation/meal_calendar/view_model/meal_calendar_viewmodel.dart';
import 'package:vitameal/presentation/ui_provider/meal_provider.dart';

class MealCalendarPage extends HookConsumerWidget {
  const MealCalendarPage({super.key});

  static const double _headerHeight = 84; // 년.월 라벨 + 요일 고정 영역
  static const double _weekCalendarHeight = 44; // Week 모드 높이 (화면 내렸을 때)
  static const int _rowCount = 6; // Month 모드 행 개수 = 6주
  static const double _monthCalendarRatio =
      1.0; // 헤더 제외 공간 중 월 캘린더가 차지할 비율 (1.0 = 꽉차게)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    // ----- 인증 정보 -----

    final session = ref.watch(authViewModelProvider);
    final userId = session?.user.id;
    if (userId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // ----- UI 상태 관련 -----

    final focusedDay = useState(DateTime.now()); // 현재 캘린더 페이지의 렌더링 기준이 되는 날
    final selectedDay = useState(DateTime.now().dateOnly); // 선택된 날짜
    final lastTappedDay = useState<DateTime?>(null); // 마지막으로 선택된 날짜

    // 애니메이션 컨트롤러 (0.0: Month 모드, 1.0: Week 모드)
    final collapseCtrl = useAnimationController(
      duration: const Duration(milliseconds: 360),
      initialValue: 1.0, // 초기 Week
    );
    // 애니메이션 현재 진행도, collapseCtrl.value 상태 구독
    final t = useAnimation(collapseCtrl);

    final isWeekMode = t >= 0.9; // Week 모드 여부
    final dragStartY = useState<double?>(null); // 세로 드래그 상태
    final dragEndY = useState<double?>(null); // 세로 드래그 상태

    final contentScrollController = useScrollController();
    final showFabBubble = useState(false); // 말풍선 표시 상태

    // ----- 데이터 조회 관련 -----

    final startOfMonth = DateTime(
      focusedDay.value.year,
      focusedDay.value.month,
      1,
    ); // 1일 부터

    final endOfMonth = DateTime(
      focusedDay.value.year,
      focusedDay.value.month + 1,
      0,
    ); // 말일 까지

    // 이번달 식단 데이터 vm
    final calendarViewModel = ref.watch(
      mealCalendarViewModelProvider(userId, startOfMonth, endOfMonth),
    );

    // 이번달 Adherence Map
    final mealDays = calendarViewModel.maybeWhen(
      data: (v) => v,
      orElse: () => <MealDayEntity>[],
    );
    final colorOfDay = AdherenceUtils.buildColorMap(mealDays);

    // focusedDay의 MealDay
    final selectedMealDay = mealDays.firstWhereOrNull(
      (day) => CalendarUtils.isSameDay(day.mealDate, selectedDay.value),
    );

    // focusedDay의 mealEntries 목록
    final mealEntriesAsync = selectedMealDay != null
        ? ref.watch(mealEntriesProvider(selectedMealDay.id))
        : null;

    // ----- AI 분석 카드 관련 -----

    final todayCountAsync = ref.watch(
      todayAnalysisCountProvider(userId),
    ); // 오늘 사용한 분석 횟수 provider

    final todayCount = todayCountAsync.maybeWhen(
      data: (count) => count,
      orElse: () => 0,
    );

    final isCountLoading = todayCountAsync.isLoading;

    final hasEntries =
        mealEntriesAsync?.maybeWhen(
          data: (entries) => entries.isNotEmpty,
          orElse: () => false,
        ) ??
        false;

    final isEntriesEmpty = mealEntriesAsync == null
        ? true // MealDay 자체가 없으면, 식단도 없음
        : mealEntriesAsync.maybeWhen(
            data: (entries) => entries.isEmpty,
            orElse: () => false, // 로딩 중
          );

    // ----- ✋ (핸들러) -----

    /// ✋ 날짜 탭 인터렉션
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

    /// ✋ 페이지 변경 콜백, 좌우 스크롤 시 호출
    void onPageChanged(DateTime newFocused) {
      focusedDay.value = newFocused;
      // Week 모드에서만 selectedDay 업데이트 (Month 모드에서는 년.월만 업데이트)
      if (collapseCtrl.value >= 0.9) {
        selectedDay.value = newFocused.dateOnly;
        lastTappedDay.value = selectedDay.value;
      }
    }

    /// ✋ 성취도 평가 업데이트
    Future<void> setColorBar(Color color) async {
      final adherence = AdherenceUtils.colorToAdherence(color);

      try {
        String mealDayId;

        // MealDay가 없으면 먼저 생성 (식단 추가와 동일한 로직)
        if (selectedMealDay == null) {
          final mealDay = await ref
              .read(mealRepositoryProvider)
              .getOrCreateMealDay(userId: userId, date: selectedDay.value);
          mealDayId = mealDay.id;
        } else {
          mealDayId = selectedMealDay.id;
        }

        // Adherence 업데이트 (UI 즉시 반영)
        await ref
            .read(
              mealCalendarViewModelProvider(
                userId,
                startOfMonth,
                endOfMonth,
              ).notifier,
            )
            .updateAdherence(mealDayId: mealDayId, adherence: adherence);

        // 📝
        AnalyticsService.event('meal_action', p: {'action': 'adherence'});
      } catch (e) {
        debugPrint('성취도 업데이트 실패: $e');
      }
    }

    /// ✋ AI 분석 수행
    Future<void> handleAnalyze() async {
      if (selectedMealDay == null) return;

      // 분석 수행 후 결과 받기
      final viewModel = ref.read(mealAnalysisViewModelProvider.notifier);
      final analysisResult = await viewModel.requestAnalysis(
        selectedMealDay.id,
      );

      // 로컬 DB 업데이트 (summary, needs_ai_refresh=false)
      await ref
          .read(mealRepositoryProvider)
          .updateMealDayAfterAnalysis(
            mealDayId: selectedMealDay.id,
            summary: analysisResult.overallSummary,
          );

      ref
          .read(todayAnalysisCountProvider(userId).notifier)
          .refresh(); // 사용한 분석 횟수

      // 📝
      AnalyticsService.event('meal_action', p: {'action': 'ai_analyze'});
    }

    /// ✋ 기저질환 피드백 대화상자 출력
    Future<void> handleOpenDetail() async {
      if (selectedMealDay == null) return;

      // 분석 결과 받아오기 (remote)
      final notifier = ref.read(mealAnalysisViewModelProvider.notifier);
      final analysis = await notifier.getLatestAnalysis(selectedMealDay.id);

      if (analysis == null) {
        throw Exception('분석 결과가 없습니다.');
      }

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AiAnalysisDetailDialog(analysis: analysis),
        );
      }
    }

    // FAB 말풍선 표시 여부 판단
    useEffect(
      () {
        showFabBubble.value = false; // 기본적으로 안뜸
        if (!isEntriesEmpty) return null; // 식단 있을때 안뜸
        if (!isWeekMode) return null; // Month 모드 일때 안뜸
        showFabBubble.value = true;
        return null;
      },
      [
        isEntriesEmpty, // 해당 날짜에 식단 없어지면 다시 판단
        isWeekMode, // Month - Week 모드 바뀌면 다시 판단
        selectedDay.value, // 날짜 바뀌면 다시 판단
      ],
    );

    return Scaffold(
      body: SafeArea(
        top: true,
        // LayoutBuilder로 위젯 높이 기반의 행높이 계산
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;

            // 월 캘린더 높이 (헤더 제외 영역)
            final monthCalendarHeight =
                (availableHeight - _headerHeight) * _monthCalendarRatio;
            // 행 높이 계산
            final rowHeightMonth = monthCalendarHeight / _rowCount;

            // 선택된 날짜가 속한 주
            final weekIndex = CalendarUtils.weekIndexInMonthGrid(
              focusedDay.value,
              selectedDay.value,
              rowCount: _rowCount,
            );
            // 행 높이를 애니메이션 진행에 따라 보간 (Month 모드 - Week 모드)
            final rowHeight = lerpDouble(
              rowHeightMonth,
              _weekCalendarHeight,
              t,
            )!;
            // 애니메이션 진행에 따라 선택된 날짜가 속한 주를 맨 위로 올리기 위한 이동량
            final translateY = isWeekMode ? 0.0 : -weekIndex * rowHeight * t;

            // DayCell의 여백 높이 계산 (41 = DayCell의 날짜 부분 높이)
            final barAreaHeightMonth = math.max(0.0, rowHeightMonth - 41);
            // 애니메이션에 따라 없어질 때 보간
            final barArea = lerpDouble(barAreaHeightMonth, 0.0, t)!;

            // 애니메이션에 따른 TableCalendar 높이 계산
            final calendarHeight = lerpDouble(
              monthCalendarHeight,
              _weekCalendarHeight,
              t,
            )!;

            return Column(
              children: [
                // ----- 상단 고정 영역 -----
                SizedBox(
                  height: _headerHeight,
                  child: CalendarHeader(
                    focused: focusedDay.value,
                    onTapYearMonth: () {
                      final target = DateTime.now().dateOnly;
                      focusedDay.value = target;
                      selectedDay.value = target.dateOnly;
                      lastTappedDay.value = selectedDay.value;

                      if (collapseCtrl.value >= 0.9) {
                        collapseCtrl.animateTo(0.0, curve: Curves.easeOutCubic);
                      } else {
                        collapseCtrl.animateTo(1.0, curve: Curves.easeOutCubic);
                      }
                    },
                  ),
                ),

                // ----- 캘린더 영역 -----
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
                            minHeight:
                                monthCalendarHeight, // 오버플로우 방지, 항상 월 캘린더 높이로
                            maxHeight:
                                monthCalendarHeight, // 오버플로우 방지, 항상 월 캘린더 높이로
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: MonthCalendar(
                                focusedDay: focusedDay.value,
                                selectedDay: selectedDay.value,
                                rowHeight: rowHeight,
                                barAreaHeight: barArea,
                                barColorByDay: colorOfDay,
                                onDayTap: onDayTapped,
                                calendarFormat: isWeekMode
                                    ? CalendarFormat.week
                                    : CalendarFormat.month,
                                onPageChanged: onPageChanged,
                              ),
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
                              if (dragStartY.value == null ||
                                  dragEndY.value == null)
                                return;
                              // 드래그 방향 체크
                              final dragDistance =
                                  dragEndY.value! - dragStartY.value!;
                              dragStartY.value = null;
                              dragEndY.value = null;
                              // 최소 50px 드래그
                              if (dragDistance.abs() < 50) return;
                              // 위로 드래그 (Month -> Week)
                              if (dragDistance < 0) {
                                if (!isWeekMode) {
                                  collapseCtrl.animateTo(
                                    1.0,
                                    curve: Curves.easeOutCubic,
                                  );
                                }
                              }
                              // 아래로 드래그 (Week -> Month)
                              else {
                                if (isWeekMode) {
                                  collapseCtrl.animateTo(
                                    0.0,
                                    curve: Curves.easeOutCubic,
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ----- 식단내용 영역 -----
                Expanded(
                  child: Builder(
                    builder: (context) {
                      // MealDay가 없을 경우
                      if (mealEntriesAsync == null) {
                        return _EmptyMealView(
                          scrollController: contentScrollController,
                        );
                      }
                      return mealEntriesAsync.when(
                        data: (entries) {
                          if (entries.isEmpty) {
                            return _EmptyMealView(
                              scrollController: contentScrollController,
                            );
                          }
                          final sortedEntries = entries.toList()
                            ..sort((a, b) {
                              final aTime = a.eatenAt ?? DateTime(2000);
                              final bTime = b.eatenAt ?? DateTime(2000);
                              return aTime.compareTo(bTime);
                            });

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomScrollView(
                              controller: contentScrollController,
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      AdherencePicker(
                                        selectedDay: selectedDay.value,
                                        adherence:
                                            colorOfDay[selectedDay.value],
                                        onPick: setColorBar,
                                      ),
                                      if (selectedMealDay != null)
                                        AiAnalysisCard(
                                          mealDayId: selectedMealDay.id,
                                          needsAiRefresh:
                                              selectedMealDay.needsAiRefresh,
                                          latestAiSummary:
                                              selectedMealDay.latestAiSummary,
                                          todayCount: todayCount,
                                          isCountLoading: isCountLoading,
                                          hasEntries: hasEntries,
                                          onAnalyze: handleAnalyze,
                                          onOpenDetail: handleOpenDetail,
                                          title: l.ai_result,
                                        ),
                                    ],
                                  ),
                                ),

                                SliverList.separated(
                                  itemCount: sortedEntries.length,
                                  itemBuilder: (context, index) {
                                    final entry = sortedEntries[index];
                                    return MealCard(
                                      entryId: entry.id,
                                      category: entry.category,
                                      content: entry.content,
                                      photoUrl: entry.photoUrl,
                                      eatenAt: entry.eatenAt,
                                      onTap: () async {
                                        await context.push(
                                          AppRoutePath.mealEditor,
                                          extra: {
                                            'mealEntryId': entry.id,
                                            'mealDayId': selectedMealDay!.id,
                                            'date': selectedDay.value,
                                          },
                                        );
                                        ref.invalidate(
                                          mealEntriesProvider(
                                            selectedMealDay.id,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder: (_, __) =>
                                      Divider(color: vrc(context).border),
                                ),
                                SliverToBoxAdapter(child: SizedBox(height: 9)),
                              ],
                            ),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(
                          child: Text(
                            'error: $e',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),

      // ----- FAB 영역 -----
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: showFabBubble.value ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            builder: (context, v, child) {
              return Opacity(
                opacity: v,
                child: Transform.translate(
                  offset: Offset(0, (1 - v) * 10), // 아래에서 위로 10px
                  child: Transform.scale(
                    scale: 0.96 + (v * 0.04), // 0.96 -> 1.0
                    alignment: Alignment.bottomRight,
                    child: child,
                  ),
                ),
              );
            },
            child: IgnorePointer(
              ignoring: !showFabBubble.value,
              child: _FabBubble(
                text: '${l.record_today_meal}!',
                onTap: () async {},
              ),
            ),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              await context.push(
                AppRoutePath.mealEditor,
                extra: {
                  'mealDayId': selectedMealDay?.id,
                  'date': selectedDay.value,
                },
              );
              // TODO: vm에서 state 클래스로 같이 관리하도록 리팩토링 하기
              // Provider로 따로 뺀거라 돌아온 후 갱신 해줘야함
              if (selectedMealDay != null) {
                ref.invalidate(mealEntriesProvider(selectedMealDay.id));
              }
            },
            elevation: 0,
            shape: const CircleBorder(),
            backgroundColor: fxc(context).primary400,
            child: Icon(
              PhosphorIcons.pencilSimple(),
              size: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyMealView extends StatelessWidget {
  const _EmptyMealView({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!; // 🌎

    // Expanded 영역의 높이를 받아서 가운데 정렬
    // 스크롤로 overflow 방지
    return LayoutBuilder(
      builder: (context, c) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: c.maxHeight),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIcons.bowlFood(),
                    size: 100,
                    color: vrc(context).emptyText,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${l.no_meal_record} :(',
                    style: TextStyle(
                      color: vrc(context).border,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FabBubble extends StatelessWidget {
  const _FabBubble({required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 말풍선
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: fxc(context).primary400!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: fxc(context).primary400,
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
