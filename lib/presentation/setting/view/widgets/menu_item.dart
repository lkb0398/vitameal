import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showArrow;

  const MenuItem({
    super.key,
    required this.title,
    required this.onTap,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeVrc = vrc(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: themeVrc.border!, width: 1.5),
          ),
        ),
        height: 60,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                color: themeVrc.text,
              ),
            ),
            if (showArrow)
              Icon(Icons.arrow_forward_ios, size: 16, color: themeVrc.text),
          ],
        ),
      ),
    );
  }
}
