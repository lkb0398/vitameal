import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<void> signInWithOAuth(OAuthProvider provider);
  Future<void> signOut();
  Stream<Session?> get sessionStream;
  Session? get currentSession;
}
