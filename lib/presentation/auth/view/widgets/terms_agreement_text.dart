import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
    final Color mainTextColor = vrc(context).text!;
    final Color subTextColor = fxc(context).textcolor400!;

    final TextStyle linkStyle = TextStyle(
      color: mainTextColor,
      fontWeight: FontWeight.bold, // 두께 강조
      decoration: TextDecoration.underline, // 밑줄
      decorationColor: mainTextColor,
      fontSize: 12,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: subTextColor,
          fontSize: 12,
          fontFamily: 'pretendard',
        ),
        children: [
          // 이용 약관
          TextSpan(
            text: '이용 약관',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchURL(_policyUrl),
          ),
          const TextSpan(text: ' 및 '),
          // 개인정보처리방침
          TextSpan(
            text: '개인정보처리방침',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchURL(_policyUrl),
          ),
          const TextSpan(text: '에 동의합니다.'),
        ],
      ),
    );
  }
}
