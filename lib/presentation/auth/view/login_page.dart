import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../view_model/auth_view_model.dart';
import 'widgets/social_login_button.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authViewModelProvider);
    final vm = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: session != null
              ? _buildLoggedInState(session, vm)
              : _buildLoginState(vm),
        ),
      ),
    );
  }

  Widget _buildLoggedInState(Session session, AuthViewModel vm) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('로그인 되었습니다.', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: vm.logout, child: const Text('로그아웃')),
        ],
      ),
    );
  }

  Widget _buildLoginState(AuthViewModel vm) {
    return Column(
      children: [
        const Spacer(flex: 2),

        Image.asset('assets/images/logo.png', height: 180, fit: BoxFit.contain),

        const Spacer(flex: 1),

        SocialLoginButton(
          label: 'Apple로 시작하기(미구현)',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          onPressed: () => vm.login(OAuthProvider.apple),
        ),
        const SizedBox(height: 16),

        SocialLoginButton(
          label: 'Google로 시작하기(미구현)',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          onPressed: () => vm.login(OAuthProvider.google),
        ),
        const SizedBox(height: 16),

        SocialLoginButton(
          label: '카카오로 시작하기',
          backgroundColor: const Color(0xfffee500),
          textColor: Colors.black,
          onPressed: () => vm.login(OAuthProvider.kakao),
        ),

        const Spacer(flex: 1),
      ],
    );
  }
}
