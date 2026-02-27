import 'package:vitameal/domain/enum/meal_category_enum.dart';

extension DateTimeFormat on DateTime {
  String get monthLabel => '$year.${month.toString().padLeft(2, '0')}';

  DateTime get dateOnly => DateTime(year, month, day);

  String get logFormat => toIso8601String().substring(0, 10);
}

/// 같은 날짜인지 확인
bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}

/// 날짜 무시하고 시간으로 정렬
int compareTimeOnlyWithCategory(
  DateTime? a,
  DateTime? b,
  MealCategory categoryA,
  MealCategory categoryB,
) {
  // null이면 맨 뒤로
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;

  // 시간 비교
  final aMinutes = a.hour * 60 + a.minute;
  final bMinutes = b.hour * 60 + b.minute;

  final timeCompare = aMinutes.compareTo(bMinutes);
  if (timeCompare != 0) return timeCompare;

  // 시간 같을 경우 카테고리 순서
  return categoryA.order.compareTo(categoryB.order);
}