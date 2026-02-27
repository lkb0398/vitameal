import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/meal_calendar/view/widget/tutorial/swipe_down_hint.dart';

class MealTutorial {
  static const _initAnimMs = 500; // spotlight 애니메이션 시간
  static TutorialCoachMark? _current; // 현재 표시중인 튜토리얼
  static OverlayEntry? _swipeHintEntry; // 스크롤 힌트 오버레이 엔트리
  static OverlayEntry? _skipEntry; // 건너뛰기 버튼 오버레이 엔트리
  static OverlayState? _overlay; // 오버레이 레이어 (엔트리를 삽입)
  static VoidCallback? _onDone; // 튜토리얼 끝나면 호출할 콜백

  // 오버레이 엔트리 제거
  static void _removeOverlays() {
    _swipeHintEntry?.remove();
    _swipeHintEntry = null;
    _skipEntry?.remove();
    _skipEntry = null;
  }

  // 튜토리얼 완료 후 정리
  static void _dismiss() {
    _removeOverlays();
    _current = null;
    _onDone?.call();
    _onDone = null;
  }

  /// 스포트라이트로 Target 비추기
  static void show({
    required BuildContext context,
    required GlobalKey calendarKey,
    required GlobalKey fabKey,
    required GlobalKey contentAreaKey,
    required VoidCallback onDone,
    required String stepOne,
    required String stepTwo,
    required String stepThree,
  }) {
    _onDone = onDone;
    _overlay = Overlay.of(context);

    /// step 전환 함수
    void onStepChange(TargetFocus target) {
      _skipEntry?.remove();
      _skipEntry = null;
      // calendar step 이면 스크롤 힌트 제거
      if (target.identify == 'calendar') {
        _swipeHintEntry?.remove();
        _swipeHintEntry = null;
      }
    }

    // TutorialCoachMark 생성 후 show
    _current = TutorialCoachMark(
      targets: _buildTargets(
        calendarKey,
        fabKey,
        contentAreaKey,
        stepOne,
        stepTwo,
        stepThree,
      ),
      colorShadow: Colors.black,
      opacityShadow: 0.75,
      hideSkip: true,
      onClickOverlay: onStepChange,
      onClickTarget: onStepChange,
      onFinish: () => _dismiss(),
      onSkip: () {
        _dismiss();
        return true;
      },
    )..show(context: context);

    // 최초 스탭 (calendar) 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      Future.delayed(const Duration(milliseconds: _initAnimMs), () {
        if (_current == null || !context.mounted) return;

        // RenderBox 얻어서 전역 좌표/크기 계산
        final box =
            calendarKey.currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero); // 최상단 좌표
          final size = box.size; // 사이즈

          // SwipeDownHint를 원하는 좌표에 출력
          _swipeHintEntry = OverlayEntry(
            builder: (_) => Positioned(
              top: pos.dy + 84 + 4,
              // 목요일(4번째)과 금요일(5번째) 사이
              // 4.0 * (size.width - 12.0) / 7.0 = 4칸의 셀 너비
              left: pos.dx + 6.0 + 4.0 * (size.width - 12.0) / 7.0 - 16.0,
              child: const IgnorePointer(child: SwipeDownHint()),
            ),
          );
          _overlay!.insert(_swipeHintEntry!);
        }
      });
    });
  }

  /// 튜토리얼 Target 정의
  static List<TargetFocus> _buildTargets(
    GlobalKey calendarKey,
    GlobalKey fabKey,
    GlobalKey contentAreaKey,
    String stepOne,
    String stepTwo,
    String stepThree,
  ) {
    return [
      // Step 1: 주 캘린더 스와이프
      TargetFocus(
        identify: 'calendar',
        keyTarget: calendarKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        paddingFocus: 6,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: _TipCard(text: stepOne),
          ),
        ],
      ),

      // Step 2: 식단 기록 fab 버튼
      TargetFocus(
        identify: 'fab',
        keyTarget: fabKey,
        shape: ShapeLightFocus.Circle,
        paddingFocus: 14,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: _TipCard(text: stepTwo),
          ),
        ],
      ),

      // Step 3: 컨텐츠 영역
      TargetFocus(
        identify: 'content',
        keyTarget: contentAreaKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        paddingFocus: 4,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(top: 50),
            child: _TipCard(text: stepThree),
          ),
        ],
      ),
    ];
  }
}

class _TipCard extends StatelessWidget {
  /// Tip 카드 위젯
  const _TipCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: vrc(context).background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: vrc(context).text,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
