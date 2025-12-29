import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/auth_repository.dart';
import '../../data/repository_impl/auth_repository_impl.dart';

part 'logout_usecase.g.dart';

@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}

class LogoutUseCase {
  final AuthRepository _repository;
  LogoutUseCase(this._repository);

  Future<void> execute() async => await _repository.signOut();
}
