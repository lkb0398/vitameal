import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<void> signInWithOAuth(OAuthProvider provider) async =>
      await _dataSource.signInWithOAuth(provider);

  @override
  Future<void> signOut() async => await _dataSource.signOut();

  @override
  Stream<Session?> get sessionStream => _dataSource.sessionStream;

  @override
  Session? get currentSession => _dataSource.currentSession;
}

// 의존성 주입 = Client => DataSource => Repository 순으로 주입
final authDataSourceProvider = Provider(
  (ref) => AuthDataSource(Supabase.instance.client),
);
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authDataSourceProvider)),
);
