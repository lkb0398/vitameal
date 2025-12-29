import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
<<<<<<< HEAD
import 'package:vitameal/domain/repository/auth_repository.dart';
=======
import '../repository/auth_repository.dart';
import '../../data/repository_impl/auth_repository_impl.dart';

part 'login_usecase.g.dart';

@riverpod
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}
>>>>>>> 005c1d3 (feat: 로그인 리팩토링 & 주석 추가 및 수정)

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<void> execute(OAuthProvider provider) async {
    try {
      await _repository.signInWithOAuth(provider);
    } on AuthException catch (e) {
      throw e.message;
    } catch (e) {
      throw '로그인 중 알 수 없는 에러가 발생했습니다.';
    }
  }
}
