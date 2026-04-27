import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/enum/date_notation_type_enum.dart';
import 'package:vitameal/presentation/date_notation/view_model/date_notation_view_model.dart';
import 'package:vitameal/presentation/widget/setting_select_menu_item.dart';

class DateNotationPage extends HookConsumerWidget {
  const DateNotationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final v = vrc(context);
    final l = L10n.of(context)!; // 🌎

    // 날짜 설정
    final notation = ref.watch(dateNotationViewModelProvider);
    final notationVM = ref.read(dateNotationViewModelProvider.notifier);

    var selected = useState<String>(l.auto_date);
    useEffect(() {
      if (notation == null) {
        selected.value = l.auto_date;
      } else if (notation == DateNotationType.yyyyMMdd) {
        selected.value = 'YYYY-MM-DD';
      } else if (notation == DateNotationType.mmDDyyyy) {
        selected.value = 'MM-DD-YYYY';
      } else if (notation == DateNotationType.ddMMyyyy) {
        selected.value = 'DD-MM-YYYY';
      }
      return null;
    }, [notation]);

    return Scaffold(
      /// 앱바
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l.date_setting,
          style: TextStyle(fontSize: 22, color: v.text),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// 날짜 자동 설정
              SettingSelectMenuItem(
                selected: selected.value,
                title: l.auto_date,
                onTap: () {
                  selected.value = l.auto_date;
                  notationVM.setAutoDateNotation();
                },
              ),

              /// 연-월-일
              SettingSelectMenuItem(
                selected: selected.value,
                title: 'YYYY-MM-DD',
                onTap: () {
                  selected.value = 'YYYY-MM-DD';
                  notationVM.setDateNotation(DateNotationType.yyyyMMdd);
                },
              ),

              /// 월-일-연
              SettingSelectMenuItem(
                selected: selected.value,
                title: 'MM-DD-YYYY',
                onTap: () {
                  selected.value = 'MM-DD-YYYY';
                  notationVM.setDateNotation(DateNotationType.mmDDyyyy);
                },
              ),

              /// 일-월-연
              SettingSelectMenuItem(
                selected: selected.value,
                title: 'DD-MM-YYYY',
                onTap: () {
                  selected.value = 'DD-MM-YYYY';
                  notationVM.setDateNotation(DateNotationType.ddMMyyyy);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
