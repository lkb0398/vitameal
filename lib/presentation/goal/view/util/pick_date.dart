import 'package:flutter/cupertino.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';

Future<DateTime?> pickDate({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  DateTime selectedDate = DateTime.now();

  return showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (context) {
      final l = L10n.of(context)!; // 🌎

      return Container(
        height: 300,
        color: vrc(context).background,
        child: Column(
          children: [
            // 상단 액션 바
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: fxc(context).textcolor200!),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      l.cancel,
                      style: TextStyle(color: fxc(context).textcolor300),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      l.complete,
                      style: TextStyle(color: fxc(context).secondary400),
                    ),
                    onPressed: () =>
                        Navigator.pop(context, _normalizeDate(selectedDate)),
                  ),
                ],
              ),
            ),

            // Date Picker
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: DateTime(2000),
                maximumDate: DateTime(2100),
                onDateTimeChanged: (date) {
                  selectedDate = date;
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

DateTime _normalizeDate(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}
