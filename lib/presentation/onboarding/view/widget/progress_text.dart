import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class ProgressText extends StatelessWidget {
  const ProgressText({super.key, required this.page});

  final String page;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 16, color: vrc(context).text),
        children: [
          TextSpan(
            text: page,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: fxc(context).primary400,
            ),
          ),
          TextSpan(text: ' / 4'),
        ],
      ),
    );
  }
}
