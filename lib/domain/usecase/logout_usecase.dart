<<<<<<< HEAD
import 'package:vitameal/domain/repository/auth_repository.dart';
=======
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:vitameal/domain/repository/auth_repository.dart';
=======
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/auth_repository.dart';
import '../../data/repository_impl/auth_repository_impl.dart';

part 'logout_usecase.g.dart';

@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}
>>>>>>> 005c1d3 (feat: 로그인 리팩토링 & 주석 추가 및 수정)
=======
import 'package:vitameal/domain/repository/auth_repository.dart';
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)
>>>>>>> d24068e (feat: UI를 제외한 기능구현 및 리팩토링 완료)

class LogoutUseCase {
  final AuthRepository _repository;
  LogoutUseCase(this._repository);

  Future<void> execute() async => await _repository.signOut();
}
