import 'package:flutter/widgets.dart';

/// RichText 입력 간소화 util (ex. 'normal {bold} normal')
Text boldRichText(String text) {
  final regex = RegExp(r'\{(.*?)\}');
  final spans = <TextSpan>[];
  int start = 0;

  final baseStyle = TextStyle(fontSize: 14);
  for (final match in regex.allMatches(text)) {
    // normal 텍스트
    if (match.start > start) {
      spans.add(
        TextSpan(text: text.substring(start, match.start), style: baseStyle),
      );
    }
    // bold 텍스트
    spans.add(
      TextSpan(
        text: match.group(1),
        style: (baseStyle.copyWith(fontWeight: FontWeight.bold)),
      ),
    );
    start = match.end;
  }
  // 마지막 텍스트
  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start), style: baseStyle));
  }

  return Text.rich(TextSpan(children: spans), textAlign: TextAlign.center);
}
