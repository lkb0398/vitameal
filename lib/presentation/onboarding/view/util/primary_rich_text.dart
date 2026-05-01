import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:vitameal/core/theme/app_theme.dart';

/// RichText 입력 간소화 util (ex. 'normal `bold` [primary] normal')
AutoSizeText primaryRichText(BuildContext context, String text) {
  final f = fxc(context);
  final v = vrc(context);

  final spans = <TextSpan>[];

  final defaultBase = TextStyle(fontSize: 22, color: v.text);
  final defaultBold = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  final defaultPrimary = TextStyle(
    fontSize: 22,
    color: f.primary400,
    fontWeight: FontWeight.w600,
  );

  final regex = RegExp(r'(\<.*?\>|\[.*?\])');

  int start = 0;

  for (final match in regex.allMatches(text)) {
    // 일반 텍스트
    if (match.start > start) {
      spans.add(
        TextSpan(text: text.substring(start, match.start), style: defaultBase),
      );
    }

    final matchedText = match.group(0)!;

    // < >  bold
    if (matchedText.startsWith('<')) {
      spans.add(
        TextSpan(
          text: matchedText.substring(1, matchedText.length - 1),
          style: defaultBold,
        ),
      );
    }
    // [ ]  primary
    else if (matchedText.startsWith('[')) {
      spans.add(
        TextSpan(
          text: matchedText.substring(1, matchedText.length - 1),
          style: defaultPrimary,
        ),
      );
    }

    start = match.end;
  }

  // 마지막 일반 텍스트
  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start), style: defaultBase));
  }

  return AutoSizeText.rich(TextSpan(children: spans));
}
