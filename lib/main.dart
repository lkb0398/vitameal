import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vitameal/core/config/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/core/service/firebase_service.dart';
import 'package:vitameal/core/service/notification_service.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'core/config/routes.dart';
import 'package:timezone/data/latest.dart' as tz;

// 🔔 Background 알림 (main 최상단!)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    // 배포시 .env로 관리
    url: 'https://ykqdcgrimdsvuincvmtu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlrcWRjZ3JpbWRzdnVpbmN2bXR1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU5MzM0OTcsImV4cCI6MjA4MTUwOTQ5N30.QJnEx7gDulSj8-8PayKYxyu5Aze8IBk7jJU-N-VRHCw',
  );

  Future<void> initTimezone() async {
    tz.initializeTimeZones();
  }

  await initTimezone();

  // 온보딩 완료여부 동기화
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

  // 🔔 Firebase 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FCM Background 핸들러 등록 (main 에서)
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // Firebase 관련 설정 (토큰, 권한)
  await FirebaseService.initialize();
  // 알림 리스너 설정
  await NotificationService.initialize();
  // 앱 실행 시 배지 초기화 (iOS), Android 는 푸시 알림 삭제 시 배지 삭제됨
  if (Platform.isIOS) {
    FlutterAppBadger.removeBadge();
  }

  runApp(
    UncontrolledProviderScope(container: container, child: const VitamealApp()),
  );
}

class VitamealApp extends HookConsumerWidget {
  const VitamealApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SyncService 초기화 (앱 시작 시 한 번 동기화)
    ref.read(syncServiceProvider);

    // routerProvider를 Stream으로 실시간 경로 변경
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [Locale('ko', 'KR'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Cupertino 스타일 > 한국어 패치
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Vitameal',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: ThemeMode.system,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
