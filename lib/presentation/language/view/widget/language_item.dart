import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.selected,
    required this.title,
    required this.onTap,
  });

  final String selected;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: selected == title ? fxc(context).textcolor200 : null,
          border: Border(bottom: BorderSide(color: fxc(context).textcolor300!)),
        ),
        height: 56,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: selected == title
                    ? fxc(context).textcolor700
                    : vrc(context).text,
              ),
            ),
            selected == title
                ? Icon(Icons.check, size: 18, color: fxc(context).textcolor700)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
