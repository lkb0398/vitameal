import 'package:supabase_flutter/supabase_flutter.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<void> execute(OAuthProvider provider) async {
    try {
      await _repository.signInWithOAuth(provider);
    } on AuthException catch (e) {
      throw e.message; // supabase 인증 관련 에러
    } catch (e) {
      throw '로그인 중 알 수 없는 에러가 발생했습니다.'; // 기타 에러
    }
  }
}
