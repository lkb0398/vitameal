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
String _$authViewModelHash() => r'43fe1c9d5c63e65f983b8373011a16b22623bb9f';
=======
<<<<<<< HEAD
String _$authViewModelHash() => r'204e3d6f5355565eaee33613bae598736c2ae07c';
=======
String _$authViewModelHash() => r'a966d80cf04197d1b8f84cfa5d123425fae6946e';
>>>>>>> 005c1d3 (feat: 로그인 리팩토링 & 주석 추가 및 수정)
>>>>>>> abcc0ce (feat: 로그인 리팩토링 & 주석 추가 및 수정)

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
