import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_view_model.g.dart';

@riverpod
class LocaleViewModel extends _$LocaleViewModel {
  @override
  Locale? build() {
    _loadAndSetLocale();
    return null;
  }

  // 저장된 언어 불러오기
  Future<void> _loadAndSetLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('locale');
    if (code != null) {
      state = Locale(code);
    }
  }

  // 언어 설정 + 저장
  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }

  // 시스템 언어로 되돌리기 + 저장 제거
  Future<void> clearLocale() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('locale');
  }
}
