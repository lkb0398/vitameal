import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class CalendarHeader extends StatelessWidget {
  /// 캘린더 헤더
  const CalendarHeader({super.key, required this.focused, this.onTapYearMonth});

  final DateTime focused;
  final VoidCallback? onTapYearMonth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        // 년.월
        GestureDetector(
          onTap: onTapYearMonth,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 44,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${focused.year}.${focused.month.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: vrc(context).text,
                ),
              ),
            ),
          ),
        ),

        // 요일 (TableCalendar와 동일한 간격으로 7등분)
        SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: const ['월', '화', '수', '목', '금', '토', '일']
                  .map(
                    (day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 12,
                            color: vrc(context).content,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
