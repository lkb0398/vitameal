import 'dart:async';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health/health.dart';

part 'step_view_model.g.dart';

@Riverpod(keepAlive: true)
class StepViewModel extends _$StepViewModel {
  // Android
  StreamSubscription<StepCount>? _sub;

  // iOS (HealthKit)
  final Health _health = Health();

  Timer? _timer;
  int _initialSteps = 0;
  String _savedDate = "";

  @override
  ({int steps, double calories}) build() {
    ref.onDispose(() {
      _sub?.cancel();
      _timer?.cancel();
    });
    return (steps: 0, calories: 0);
  }

  // [초기화]
  Future<void> init() async {
    if (Platform.isIOS) {
      await _initIOS();
    } else {
      await _initAndroid();
    }
  }

  // [iOS (HealthKit)]
  Future<void> _initIOS() async {
    final types = [HealthDataType.STEPS];

    // 1. 권한 요청
    final granted = await _health.requestAuthorization(types);
    if (!granted) return;

    // 2. 최초 값 로드
    await _loadIOS();

    // 3. 주기 갱신
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _loadIOS();
    });
  }

  Future<void> _loadIOS() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final steps = await _health.getTotalStepsInInterval(start, now) ?? 0;
    final calories = steps * 0.04;

    state = (steps: steps, calories: calories);
  }

  // [Android (Pedometer)]
  Future<void> _initAndroid() async {
    // 권한 요청
    final granted = await Permission.activityRecognition.request();
    if (!granted.isGranted) return;

    final prefs = await SharedPreferences.getInstance();
    _savedDate = prefs.getString("date") ?? "";
    _initialSteps = prefs.getInt("startSteps") ?? 0;

    _sub = Pedometer.stepCountStream.listen((event) async {
      final now = DateTime.now();
      final today = "${now.year}-${now.month}-${now.day}";

      // 자정 초기화
      if (_savedDate != today) {
        _savedDate = today;
        _initialSteps = event.steps;
        await prefs.setString("date", today);
        await prefs.setInt("startSteps", _initialSteps);
      }

      // 최초 실행 보호
      if (_initialSteps == 0) {
        _initialSteps = event.steps;
        await prefs.setInt("startSteps", _initialSteps);
      }

      final todaySteps = event.steps - _initialSteps;
      final calories = todaySteps * 0.04;

      state = (steps: todaySteps, calories: calories);
    });
  }
}
