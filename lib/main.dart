import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vitameal/core/config/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/core/service/firebase_service.dart';
import 'package:vitameal/core/service/notification_service.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'core/config/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

// 🔔 Background 알림 (main 최상단!)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {
    // 초기화 실패시 앱 터지는거 방지
  }
}

/// fcm, supabase등 실패시 앱 터지는거 방지
Future<T?> _safe<T>(
  Future<T> Function() task, {
  String? label,
  T? fallback,
}) async {
  try {
    return await task();
  } catch (e, st) {
    debugPrint('${label ?? 'task'} 실패: $e');
    debugPrint('$st');
    return fallback;
  }
}

Future<void> main() async {
  // 📝 Zone 에러(비동기)
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // 가로모드 막기
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]); // 화면 세로모드 고정

      await dotenv.load(fileName: ".env");
      KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'));
      debugPrint("현재 환경 키 해시: ${await KakaoSdk.origin}");

      await dotenv.load(fileName: ".env");
      KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'));
      debugPrint("현재 환경 키 해시: ${await KakaoSdk.origin}");

      await _safe(
        () => Supabase.initialize(
          url: dotenv.get('SUPABASE_URL'),
          anonKey: dotenv.get('SUPABASE_ANON_KEY'),
        ),
        label: 'Supabase.initialize',
      );

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
      await _safe(
        () => Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        label: 'Firebase.initializeApp',
      );
      // FCM Background 핸들러 등록 (main 에서)
      await _safe(() async {
        FirebaseMessaging.onBackgroundMessage(
          firebaseMessagingBackgroundHandler,
        );
      }, label: 'FCM background handler');
      // Firebase 관련 설정 (토큰, 권한)
      await _safe(
        () => FirebaseService.initialize(),
        label: 'FirebaseService.initialize',
      );
      // 알림 리스너 설정
      await _safe(
        () => NotificationService.initialize(),
        label: 'NotificationService.initialize',
      );

      // 📝 Flutter 프레임워크 에러
      FlutterError.onError = (details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      runApp(
        UncontrolledProviderScope(
          container: container,
          child: const VitamealApp(),
        ),
      );

      // 📝
      AnalyticsService.appOpen();
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

class VitamealApp extends HookConsumerWidget {
  const VitamealApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SyncService 초기화 (앱 시작 시 한 번 동기화)
    ref.read(syncServiceProvider);

    // 위젯 데이터 초기화 (앱 시작 시 위젯에 데이터 전달)
    final supabase = ref.read(supabaseClientProvider);
    final userId = supabase.auth.currentUser?.id;

    if (userId != null) {
      // 앱 시작 시 위젯 초기화
      Future.microtask(() {
        final widgetService = ref.read(widgetServiceProvider);
        widgetService.updateWidgetData(userId);
      });
    }

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
      title: 'VitaMeal',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: ThemeMode.system,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
