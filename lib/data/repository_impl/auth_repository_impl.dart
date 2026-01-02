import 'package:supabase_flutter/supabase_flutter.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:vitameal/domain/repository/auth_repository.dart';
import 'package:vitameal/data/data_source/auth_data_source.dart';
=======
import '../../domain/repository/auth_repository.dart';
import 'package:vitameal/data/data_source/auth_data_source.dart';
import 'package:vitameal/core/supabase/supabase_client.dart';

part 'auth_repository_impl.g.dart';

// DataSource 프로바이더
@riverpod
AuthDataSource authDataSource(Ref ref) {
  // supabaseClientProvider 사용
  final client = ref.watch(supabaseClientProvider);
  return AuthDataSource(client);
}

// Repository 프로바이더
@riverpod
AuthRepository authRepository(Ref ref) {
  // 위에 authDataSourceProvider 주입
  final dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}
>>>>>>> 005c1d3 (feat: 로그인 리팩토링 & 주석 추가 및 수정)
=======
import 'package:vitameal/domain/repository/auth_repository.dart';
import 'package:vitameal/data/data_source/auth_data_source.dart';
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<void> signInWithOAuth(OAuthProvider provider) async =>
      await _dataSource.signInWithOAuth(provider);

  @override
  Future<void> signOut() async => await _dataSource.signOut();

  @override
  Future<void> withdraw() async => await _dataSource.withdraw();

  @override
  Stream<Session?> get sessionStream => _dataSource.sessionStream;

  @override
  Session? get currentSession => _dataSource.currentSession;
}
