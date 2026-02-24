/// Enhanced enum
/// 도메인 enum - db 값 매핑
enum MealCategory {
  breakfast('breakfast'),
  lunch('lunch'),
  dinner('dinner'),
  snack('snack');

  const MealCategory(this.value);

  final String value;

  static MealCategory fromString(String value) {
    return MealCategory.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MealCategory.breakfast,
    );
  }

  /// 정렬 순서
  int get order {
    switch (this) {
      case MealCategory.breakfast:
        return 0;
      case MealCategory.lunch:
        return 1;
      case MealCategory.dinner:
        return 2;
      case MealCategory.snack:
        return 3;
    }
  }
}
