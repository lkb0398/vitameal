import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 🔔 Firebase + FCM 기본 세팅
class FirebaseService {
  static final _messaging = FirebaseMessaging.instance;
  static final _client = Supabase.instance.client;

  static Future<void> initialize() async {
    await requestPermission();
    await saveFcmToken();
    listenTokenRefresh();
  }

  // 알림 권한 요청
  static Future<void> requestPermission() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);
  }

  // FCM 토큰 발급 + Supabase 저장
  static Future<void> saveFcmToken() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    // 애뮬레이터에서 실행 하기 위해...
    if (Platform.isIOS) {
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken == null || apnsToken.isEmpty) return;
    }
    final token = await _messaging.getToken();
    if (token == null) return;

    print('my fcm token : 🩷 $token');

    await _client.from('fcm_tokens').upsert({
      'user_id': userId,
      'fcm_token': token,
      'platform': Platform.isIOS ? 'ios' : 'android',
    }, onConflict: 'user_id');
  }

  // 토큰 갱신 감지
  static void listenTokenRefresh() {
    _messaging.onTokenRefresh.listen((token) async {
      final userId = _client.auth.currentUser!.id;
      await _client.from('fcm_tokens').upsert({
        'user_id': userId,
        'fcm_token': token,
        'platform': Platform.isIOS ? 'ios' : 'android',
      }, onConflict: 'user_id');
    });
  }

  static Future<void> deleteToken() async {
    final userId = _client.auth.currentUser!.id;
    await Supabase.instance.client
        .from('fcm_tokens')
        .delete()
        .eq('user_id', userId);
  }
}
