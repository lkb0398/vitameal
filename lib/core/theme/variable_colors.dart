import 'package:flutter/material.dart';

/// < 테마 변경시 바뀌는 색들 : vrc(context).text 로 사용 >
@immutable
class VariableColors extends ThemeExtension<VariableColors> {
  const VariableColors({
    required this.background,
    required this.border,
    required this.hint,
    required this.content,
    required this.subTitle,
    required this.text,
    // =====
    required this.dropdown,
    required this.infoContainer,
    required this.greyBackground,
    required this.emptyText,
    required this.infoShadow,
    required this.bottomNavShadow,
    required this.imagePlusIcon,
    required this.selectedItem,
    required this.calendarCell,
  });

  // (light mode > dark mode)
  final Color? background; // 배경 (textcolor 0 > 700)
  final Color? border; // 테두리 (textcolor 200 > 500)
  final Color? hint; // 힌트&비활성 (textcolor 300 > 400)
  final Color? content; // 본문 (textcolor 500 > 200)
  final Color? subTitle; // 서브 타이틀 (textcolor 600 > 50)
  final Color? text; // 텍스트 (textcolor 700 > 0)
  // =====
  final Color? dropdown; // 드롭다운 내부 배경 (textcolor 0 > textcolor 600)
  final Color? infoContainer; // 내정보 페이지 컨테이너 (textcolor 0 > 800)
  final Color? greyBackground; // 이미지 추가 영역 배경, 드롭다운 배경 (textcolor 50 > 600)
  final Color? emptyText; // 리스트 비어있을 때 아이콘,텍스트 (textcolor 100 > 600)
  final Color? infoShadow; // 내정보 페이지 컨테이너 그림자 (textcolor 100 > 700)
  final Color? bottomNavShadow; // 바텀 네비게이션 그림자 (textcolor 100 > 800)
  final Color? imagePlusIcon; // 이미지 추가 영역 아이콘 (textcolor 300 > 700)
  final Color? selectedItem; // 바텀 네비게이션 활성화 색상 (textcolor 700 > primary 400)
  final Color? calendarCell; // 캘린더 셀 선택 (black 12 > #404040)

  /// 라이트 모드
  static const VariableColors light = VariableColors(
    background: Color(0xFFFFFFFF),
    border: Color(0xFFD9D9D9),
    hint: Color(0xFFBDBDBD),
    content: Color(0xFF737373),
    subTitle: Color(0xFF595959),
    text: Color(0xFF333333),
    // =====
    dropdown: Color(0xFFFFFFFF),
    infoContainer: Color(0xFFFFFFFF),
    greyBackground: Color(0xFFF2F2F2),
    emptyText: Color(0xFFE6E6E6),
    infoShadow: Color(0xFFE6E6E6),
    bottomNavShadow: Color(0xFFE6E6E6),
    imagePlusIcon: Color(0xFFBDBDBD),
    selectedItem: Color(0xFF333333),
    calendarCell: Color(0x1F000000),
  );

  /// 다크모드
  static const VariableColors dark = VariableColors(
    background: Color(0xFF333333),
    border: Color(0xFF737373),
    hint: Color(0xFF8D8D8D),
    content: Color(0xFFD9D9D9),
    subTitle: Color(0xFFF2F2F2),
    text: Color(0xFFFFFFFF),
    // =====
    dropdown: Color(0xFF595959),
    infoContainer: Color(0xFF262626),
    greyBackground: Color(0xFF595959),
    emptyText: Color(0xFF595959),
    infoShadow: Color(0xFF333333),
    bottomNavShadow: Color(0xFF262626),
    imagePlusIcon: Color(0xFF333333),
    selectedItem: Color(0xFF89CC00),
    calendarCell: Color(0xFF404040),
  );

  @override
  VariableColors copyWith({
    Color? background,
    Color? border,
    Color? hint,
    Color? content,
    Color? subTitle,
    Color? text,
    // =====
    Color? dropdown,
    Color? infoContainer,
    Color? greyBackground,
    Color? emptyText,
    Color? infoShadow,
    Color? bottomNavShadow,
    Color? imagePlusIcon,
    Color? selectedItem,
    Color? calendarCell,
  }) => VariableColors(
    background: background ?? this.background,
    border: border ?? this.border,
    hint: hint ?? this.hint,
    content: content ?? this.content,
    subTitle: subTitle ?? this.subTitle,
    text: text ?? this.text,
    // =====
    dropdown: dropdown ?? this.dropdown,
    infoContainer: infoContainer ?? this.infoContainer,
    greyBackground: greyBackground ?? this.greyBackground,
    emptyText: emptyText ?? this.emptyText,
    infoShadow: infoShadow ?? this.infoShadow,
    bottomNavShadow: bottomNavShadow ?? this.bottomNavShadow,
    imagePlusIcon: imagePlusIcon ?? this.imagePlusIcon,
    selectedItem: selectedItem ?? this.selectedItem,
    calendarCell: calendarCell ?? this.calendarCell,
  );

  @override
  VariableColors lerp(ThemeExtension<VariableColors>? other, double t) {
    if (other is! VariableColors) return this;
    return VariableColors(
      background: Color.lerp(background, other.background, t),
      border: Color.lerp(border, other.border, t),
      hint: Color.lerp(hint, other.hint, t),
      content: Color.lerp(content, other.content, t),
      subTitle: Color.lerp(subTitle, other.subTitle, t),
      text: Color.lerp(text, other.text, t),
      // =====
      dropdown: Color.lerp(dropdown, other.dropdown, t),
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t),
      greyBackground: Color.lerp(greyBackground, other.greyBackground, t),
      emptyText: Color.lerp(emptyText, other.emptyText, t),
      infoShadow: Color.lerp(infoShadow, other.infoShadow, t),
      bottomNavShadow: Color.lerp(bottomNavShadow, other.bottomNavShadow, t),
      imagePlusIcon: Color.lerp(imagePlusIcon, other.imagePlusIcon, t),
      selectedItem: Color.lerp(selectedItem, other.selectedItem, t),
      calendarCell: Color.lerp(calendarCell, other.calendarCell, t),
    );
  }
}
