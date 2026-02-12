import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class TermsAgreementText extends StatelessWidget {
  const TermsAgreementText({super.key});

  // 노션 URL
  static const String _policyUrl =
      'https://dandy-asterisk-a77.notion.site/VitaMeal-2e55f7d0d202804fb31ce846d8970e19';

  // URL 실행 함수
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!; // 🌎

    final Color mainTextColor = vrc(context).text!;
    final Color subTextColor = fxc(context).textcolor400!;

    final TextStyle linkStyle = TextStyle(
      color: mainTextColor,
      fontWeight: FontWeight.bold, // 두께 강조
      decoration: TextDecoration.underline, // 밑줄
      decorationColor: mainTextColor,
      fontSize: 12,
    );

    final TextStyle normalStyle = TextStyle(color: subTextColor, fontSize: 12);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: normalStyle,
        children: [..._localizedSpans(l, linkStyle)],
      ),
    );
  }

  // 26.02.11 [line 37, 49~77] 로컬라이제이션 위해 TextSpan 변경
  List<InlineSpan> _localizedSpans(L10n l, TextStyle linkStyle) {
    final termsSpan = TextSpan(
      text: l.terms, // 이용 약관
      style: linkStyle,
      recognizer: TapGestureRecognizer()..onTap = () => _launchURL(_policyUrl),
    );

    final policySpan = TextSpan(
      text: l.policy, // 개인정보처리방침
      style: linkStyle,
      recognizer: TapGestureRecognizer()..onTap = () => _launchURL(_policyUrl),
    );

    final text = l.agree_terms_privacy(
      // 전체 텍스트
      '\u0000', // terms
      '\u0001', // privacy
    );

    final parts = text.split(RegExp('[\u0000\u0001]'));
    final spans = <InlineSpan>[];
    spans.add(TextSpan(text: parts[0]));
    spans.add(termsSpan);
    spans.add(TextSpan(text: parts[1]));
    spans.add(policySpan);
    spans.add(TextSpan(text: parts[2]));

    return spans;
  }
}
