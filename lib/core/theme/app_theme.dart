import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/fixed_colors.dart';
import 'package:vitameal/core/theme/variable_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    fontFamily: 'Pretendard',
    // < 종류별 폰트 적용 방법 >
    // Regular - FontWeight.w400 (= normal, 기본 텍스트)
    // Medium - FontWeight.w500
    // SemiBold - FontWeight.w600
    // Bold - FontWeight.w700 (= bold)
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Color(0xFF89CC00), // primary400
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      scrolledUnderElevation: 0,
    ),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xFFFFFFFF)),
    dialogTheme: DialogThemeData(backgroundColor: Color(0xFFFFFFFF)),
    extensions: const [VariableColors.light, FixedColors.constant],
  );

  static ThemeData dark = ThemeData(
    fontFamily: 'Pretendard',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Color(0xFF89CC00), // primary400
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF333333),
      scrolledUnderElevation: 0,
    ),
    scaffoldBackgroundColor: Color(0xFF333333),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xFF333333)),
    dialogTheme: DialogThemeData(backgroundColor: Color(0xFF333333)),
    extensions: const [VariableColors.dark, FixedColors.constant],
  );
}

VariableColors vrc(BuildContext context) =>
    Theme.of(context).extension<VariableColors>()!;
FixedColors fxc(BuildContext context) =>
    Theme.of(context).extension<FixedColors>()!;
