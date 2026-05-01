import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 🔔 FCM token 관리
class FirebaseService {
  static final _messaging = FirebaseMessaging.instance;
  static final _client = Supabase.instance.client;

  // [초기화]
  static Future<void> init() async {
    await saveFcmToken(); // fcm 토큰 저장
    listenTokenRefresh(); // 토큰 갱신 감지
  }

  // [토큰 저장]
  static Future<void> saveFcmToken() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;
    print('userId : 🩷 $userId');

    // 토큰 발급
    if (Platform.isIOS) {
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken == null || apnsToken.isEmpty) return;
    }
    final token = await _messaging.getToken();
    if (token == null) return;
    print('token : 🩷 $token');

    // supabase 저장
    await _client.from('fcm_tokens').upsert({
      'user_id': userId,
      'fcm_token': token,
      'platform': Platform.isIOS ? 'ios' : 'android',
    }, onConflict: 'user_id');
  }

  // [토큰 갱신]
  static void listenTokenRefresh() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    _messaging.onTokenRefresh.listen((token) async {
      await _client.from('fcm_tokens').upsert({
        'user_id': userId,
        'fcm_token': token,
        'platform': Platform.isIOS ? 'ios' : 'android',
      }, onConflict: 'user_id');
    });
  }

  // [토큰 삭제]
  static Future<void> deleteToken() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await Supabase.instance.client
        .from('fcm_tokens')
        .delete()
        .eq('user_id', userId);
  }
}
