import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<void> signInWithOAuth(OAuthProvider provider, {LaunchMode launchMode});
  Future<void> signOut();
  Future<void> withdraw();
  Stream<Session?> get sessionStream;
  Session? get currentSession;
}
