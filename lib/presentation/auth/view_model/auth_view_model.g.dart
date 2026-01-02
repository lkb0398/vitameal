// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthViewModel)
const authViewModelProvider = AuthViewModelProvider._();

final class AuthViewModelProvider
    extends $NotifierProvider<AuthViewModel, Session?> {
  const AuthViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authViewModelHash();

  @$internal
  @override
  AuthViewModel create() => AuthViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Session? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Session?>(value),
    );
  }
}

<<<<<<< HEAD
<<<<<<< HEAD
String _$authViewModelHash() => r'204e3d6f5355565eaee33613bae598736c2ae07c';
=======
String _$authViewModelHash() => r'a966d80cf04197d1b8f84cfa5d123425fae6946e';
>>>>>>> 005c1d3 (feat: 로그인 리팩토링 & 주석 추가 및 수정)
=======
String _$authViewModelHash() => r'204e3d6f5355565eaee33613bae598736c2ae07c';
>>>>>>> 33dc0ef (feat: UI를 제외한 기능구현 및 리팩토링 완료)

abstract class _$AuthViewModel extends $Notifier<Session?> {
  Session? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Session?, Session?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Session?, Session?>,
              Session?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
