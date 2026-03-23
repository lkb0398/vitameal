extension DateTimeFormat on DateTime {
  // String 'yyyy.mm'
  String get monthLabel => '$year.${month.toString().padLeft(2, '0')}';

  // DateTime (yyyy, m, d)
  DateTime get dateOnly => DateTime(year, month, day);

  // String 'hh:mm'
  String get timeLabel =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
