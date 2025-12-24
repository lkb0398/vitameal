import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../../domain/usecase/logout_usecase.dart';
import '../../../data/repository_impl/auth_repository_impl.dart';

class AuthViewModel extends Notifier<Session?> {
  // 로딩 상태 관리(탭 디바운싱 대신 사용)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // GoRouter 리다이렉트 하려고 스트림 컨트롤러 설정함
  final StreamController<Session?> _streamController =
      StreamController<Session?>.broadcast();

  Stream<Session?> get stream => _streamController.stream;

  @override
  Session? build() {
    final repository = ref.watch(authRepositoryProvider);

    // 인증 상태 변화 감시
    final subscription = repository.sessionStream.listen((session) {
      state = session;

      // 상태가 변경될 때마다 GoRouter에 알림
      if (!_streamController.isClosed) {
        _streamController.add(session);
      }
    });

    // Notifier 파괴될 때 dispose함
    ref.onDispose(() {
      subscription.cancel();
      _streamController.close();
    });

    return repository.currentSession;
  }

  // 소셜 로그인
  Future<void> login(OAuthProvider provider, {VoidCallback? onError}) async {
    if (_isLoading) return;
    _isLoading = true;
    ref.notifyListeners(); // isLoading 상태가 바뀌면 UI에 알림
    try {
      final loginUseCase = ref.read(loginUseCaseProvider);
      await loginUseCase.execute(provider);
    } catch (e) {
      debugPrint('로그인 에러: $e');
      if (onError != null) onError();
    } finally {
      _isLoading = false;
      ref.notifyListeners(); // 로딩 종료를 UI에 알림
    }
  }

  // 로그아웃 실행
  Future<void> logout() async {
    try {
      final logoutUseCase = ref.read(logoutUseCaseProvider);
      await logoutUseCase.execute();
    } catch (e) {
      debugPrint('로그아웃 에러: $e');
    }
  }
}

// 프로바이더
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

// NotifierProvider 설정
final authViewModelProvider = NotifierProvider<AuthViewModel, Session?>(() {
  return AuthViewModel();
});
