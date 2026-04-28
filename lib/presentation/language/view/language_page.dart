import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/widget/setting_select_menu_item.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';

class LanguagePage extends HookConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    // 언어 설정
    final locale = ref.watch(localeViewModelProvider);
    final localeVM = ref.read(localeViewModelProvider.notifier);

    var selected = useState<String>(l.auto_language);
    useEffect(() {
      if (locale == null) {
        selected.value = l.auto_language;
      } else if (locale.languageCode == 'ko') {
        selected.value = '한국어';
      } else if (locale.languageCode == 'en') {
        selected.value = 'English';
      }
      return null;
    }, [locale]);

    return Scaffold(
      /// 앱바
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l.language_setting,
          style: TextStyle(fontSize: 22, color: v.text),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// 언어 자동 설정
              SettingSelectMenuItem(
                selected: selected.value,
                title: l.auto_language,
                onTap: () {
                  selected.value = l.auto_language;
                  localeVM.clearLocale();
                },
              ),

              /// 한국어
              SettingSelectMenuItem(
                selected: selected.value,
                title: '한국어',
                onTap: () {
                  selected.value = '한국어';
                  localeVM.setLocale(const Locale('ko'));
                },
              ),

              /// 영어
              SettingSelectMenuItem(
                selected: selected.value,
                title: 'English',
                onTap: () {
                  selected.value = 'English';
                  localeVM.setLocale(const Locale('en'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
