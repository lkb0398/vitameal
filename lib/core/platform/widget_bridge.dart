import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Method Channel을 통해 위젯 데이터 전송 및 갱신 요청 (Flutter와 Native 간 연결)
class WidgetBridge {
  WidgetBridge._();

  static final WidgetBridge instance = WidgetBridge._();

  // Method Channel 이름, AppDelegate의 채널명과 같아야함
  static const _channel = MethodChannel('com.alldayproject.vitameal.dev/widget');

  /// 위젯 데이터 업데이트 (JSON 전송, AppDelegate에서 App Group의 UserDefaults에 저장)
  Future<void> updateWidgetData(Map<String, dynamic> data) async {
    try {
      final jsonString = jsonEncode(data);
      await _channel.invokeMethod('updateWidgetData', {'data': jsonString});
    } on PlatformException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  /// 위젯 강제 새로고침 (Timeline Reload)
  Future<void> reloadWidget() async {
    try {
      await _channel.invokeMethod('reloadWidget');
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }
}
