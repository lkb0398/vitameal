import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class AuthDataSource {
  final SupabaseClient _client;

  AuthDataSource(this._client);

  Future<void> signInWithOAuth(OAuthProvider provider) async {
    final res = await _client.auth.getOAuthSignInUrl(
      provider: provider,
      redirectTo: 'io.supabase.vitameal://login-callback',
    );

    final url = res.url;
    if (url == null) throw '인증 URL을 생성할 수 없습니다.';

    final result = await FlutterWebAuth2.authenticate(
      url: url,
      callbackUrlScheme: 'io.supabase.vitameal',
      options: const FlutterWebAuth2Options(preferEphemeral: false),
    );

    final uri = Uri.parse(result);
    final code = uri.queryParameters['code'];

    if (code != null) {
      await _client.auth.exchangeCodeForSession(code);
      print("✅ PKCE 로그인 성공: 세션이 활성화되었습니다.");
    } else {
      String? accessToken;
      if (uri.fragment.contains('access_token=')) {
        accessToken = Uri.splitQueryString(uri.fragment)['access_token'];
      } else {
        accessToken = uri.queryParameters['access_token'];
      }

      if (accessToken != null) {
        await _client.auth.setSession(accessToken);
        print("✅ Implicit 로그인 성공: 세션이 설정되었습니다.");
      } else {
        print("❌ 인증 정보 추출 실패. 결과 URL: $result");
        throw "인증 정보를 찾을 수 없습니다.";
      }
    }
  }

  Future<void> signOut() async => await _client.auth.signOut();

  Future<void> withdraw() async {
    try {
      await _client.rpc('delete_user_account');
      await signOut();
    } catch (e) {
      rethrow;
    }
  }

  Stream<Session?> get sessionStream =>
      _client.auth.onAuthStateChange.map((event) => event.session);
  Session? get currentSession => _client.auth.currentSession;
}
