import 'package:url_launcher/url_launcher.dart';

class LinkLauncher {
  static Future<void> openNotion() async {
    final uri = Uri.parse(
      'https://coordinated-steam-6ac.notion.site/2e9273f2cb2380f3b562d6c7f830387d',
    );

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
