import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/presentation/ui_provider/set_provider.dart';
import 'core/config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    // 배포시 .env로 관리
    url: 'https://ykqdcgrimdsvuincvmtu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlrcWRjZ3JpbWRzdnVpbmN2bXR1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU5MzM0OTcsImV4cCI6MjA4MTUwOTQ5N30.QJnEx7gDulSj8-8PayKYxyu5Aze8IBk7jJU-N-VRHCw',
  );

  /// 온보딩 완료여부 동기화
  final container = ProviderContainer();
  try {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      final completed = await container.read(
        onboardingCompletedProvider.future,
      );
      container.read(onboardingStateProvider.notifier).set(completed);
    }
  } catch (e) {
    debugPrint('초기 데이터 로딩 중 오류 발생: $e');
  }

  runApp(
    UncontrolledProviderScope(container: container, child: const VitamealApp()),
  );
}

class VitamealApp extends HookConsumerWidget {
  const VitamealApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // routerProvider를 Stream으로 실시간 경로 변경
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Vitameal',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
