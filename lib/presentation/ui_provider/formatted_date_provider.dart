import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/domain/enum/date_notation_type_enum.dart';
import 'package:vitameal/presentation/date_notation/view_model/date_notation_view_model.dart';

part 'formatted_date_provider.g.dart';

/// 사용자가 선택한 날짜 형식에 따른 String 변환 provider
@riverpod
String formattedDate(Ref ref, DateTime date, {bool showYear = true}) {
  // 선택한 날짜 형식 불러오기
  final notation = ref.watch(dateNotationViewModelProvider);

  // notation == null (자동) 이면 locale 기반으로 변환
  final effectiveType =
      notation ?? _getDefaultByLocale(PlatformDispatcher.instance.locale);

  switch (effectiveType) {
    case DateNotationType.yyyyMMdd:
      return showYear
          ? DateFormat('yyyy.MM.dd').format(date)
          : DateFormat('MM.dd').format(date);

    case DateNotationType.mmDDyyyy:
      return showYear
          ? DateFormat('MM.dd.yyyy').format(date)
          : DateFormat('MM.dd').format(date);

    case DateNotationType.ddMMyyyy:
      return showYear
          ? DateFormat('dd.MM.yyyy').format(date)
          : DateFormat('dd.MM').format(date);
  }
}

// 대표적인 locale 기반 기본값
DateNotationType _getDefaultByLocale(Locale locale) {
  switch (locale.countryCode) {
    case 'US':
      return DateNotationType.mmDDyyyy;
    case 'KR':
    case 'JP':
    case 'CN':
      return DateNotationType.yyyyMMdd;
    case 'GB':
    case 'DE':
    case 'FR':
    case 'AU':
    case 'NZ':
      return DateNotationType.ddMMyyyy;
    default:
      return DateNotationType.yyyyMMdd;
  }
}
