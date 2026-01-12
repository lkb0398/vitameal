import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class TimeSelector extends StatelessWidget {
  /// 시간 선택
  const TimeSelector({super.key, this.selectedTime, required this.date, required this.onTimeChanged});

  final DateTime? selectedTime;
  final DateTime date;
  final ValueChanged<DateTime?> onTimeChanged;

  /// TimePicker 바텀시트
  Future<void> _showTimePicker(BuildContext context) async {
    final now = DateTime.now();
    DateTime tempTime = selectedTime ?? now;

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            // 드래그 핸들 커스텀
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: fxc(context).textcolor200, borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(height: 30),
            // Cupertino TimePicker (IOS)
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: false,
                initialDateTime: tempTime,
                onDateTimeChanged: (DateTime newTime) {
                  tempTime = newTime;
                },
              ),
            ),

            // 완료 버튼
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    onTimeChanged(DateTime(
                      date.year,
                      date.month,
                      date.day,
                      tempTime.hour,
                      tempTime.minute,
                    ));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fxc(context).primary100,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    '완료',
                    style: TextStyle(color: fxc(context).primary600, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "시간",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: vrc(context).text),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showTimePicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: vrc(context).border!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedTime == null
                      ? "시간 선택"
                      : "${selectedTime!.hour.toString().padLeft(2, '0')} : ${selectedTime!.minute.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedTime == null ? vrc(context).hint : vrc(context).subTitle,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: selectedTime == null ? vrc(context).hint : vrc(context).subTitle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
