import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    // 배포시 .env로 관리
    url: 'https://ykqdcgrimdsvuincvmtu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlrcWRjZ3JpbWRzdnVpbmN2bXR1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU5MzM0OTcsImV4cCI6MjA4MTUwOTQ5N30.QJnEx7gDulSj8-8PayKYxyu5Aze8IBk7jJU-N-VRHCw',
  );

  runApp(const ProviderScope(child: VitamealApp()));
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

// url: 'https://ykqdcgrimdsvuincvmtu.supabase.co'
// anonKey:
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlrcWRjZ3JpbWRzdnVpbmN2bXR1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU5MzM0OTcsImV4cCI6MjA4MTUwOTQ5N30.QJnEx7gDulSj8-8PayKYxyu5Aze8IBk7jJU-N-VRHCw'
