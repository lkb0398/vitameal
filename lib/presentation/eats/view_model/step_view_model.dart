import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'step_view_model.g.dart';

// TODO : 클린 아키텍처로 리팩토링 하기

@riverpod
class StepViewModel extends _$StepViewModel {
  StreamSubscription<StepCount>? _sub;
  int _initialSteps = 0;
  String _savedDate = "";
  bool _initialized = false;

  @override
  ({int steps, double calories}) build() {
    if (!_initialized) {
      _initialized = true;
      _init();
    }

    ref.onDispose(() {
      _sub?.cancel();
    });

    return (steps: 0, calories: 0);
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  Future<void> _init() async {
    // 권한 요청 (수동)
    final granted = await Permission.activityRecognition.request();
    if (!granted.isGranted) return;

    final prefs = await SharedPreferences.getInstance();
    _savedDate = prefs.getString("date") ?? "";
    _initialSteps = prefs.getInt("startSteps") ?? 0;
    _sub = Pedometer.stepCountStream.listen((event) async {
      final now = DateTime.now();
      final today = _formatDate(now);

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
