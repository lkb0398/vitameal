import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitameal/domain/enum/date_notation_type_enum.dart';

part 'date_notation_view_model.g.dart';

@riverpod
class DateNotationViewModel extends _$DateNotationViewModel {
  static const _key = 'date_notation';

  // State : 날짜 설정
  @override
  DateNotationType? build() {
    _loadAndSetDateNotation();
    return null;
  }

  // [저장된 값 불러오기]
  Future<void> _loadAndSetDateNotation() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    if (value != null) {
      state = DateNotationType.values.firstWhere((e) => e.name == value);
    }
  }

  // [날짜 형식 설정 + 저장]
  Future<void> setDateNotation(DateNotationType type) async {
    state = type;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, type.name);
  }

  // [자동 설정 (locale 기반) + 저장 제거]
  Future<void> setAutoDateNotation() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
