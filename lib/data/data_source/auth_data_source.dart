import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSource {
  final SupabaseClient _client;

  AuthDataSource(this._client);

  Future<void> signInWithOAuth(OAuthProvider provider) async {
    await _client.auth.signInWithOAuth(
      provider,
      redirectTo: 'io.supabase.vitameal://login-callback',
      authScreenLaunchMode: LaunchMode.externalApplication,
    );
  }

  Future<void> signOut() async => await _client.auth.signOut();
  Stream<Session?> get sessionStream =>
      _client.auth.onAuthStateChange.map((event) => event.session);
  Session? get currentSession => _client.auth.currentSession;
}
