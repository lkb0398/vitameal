import 'package:url_launcher/url_launcher.dart';

class LinkLauncher {
  static const _notionUrls = {
    'ko':
        'https://coordinated-steam-6ac.notion.site/2e9273f2cb2380f3b562d6c7f830387d',
    'en':
        'https://coordinated-steam-6ac.notion.site/Sources-Health-Information-Notice-311273f2cb23808d86c1ef7abfc04f53',
  };

  static Future<void> openNotion(String languageCode) async {
    final url = _notionUrls[languageCode] ?? _notionUrls['en']!;
    final uri = Uri.parse(url);

    await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        enableDomStorage: true,
      ),
    );
  }
}
