/// double > String 소수점 아래 0 일 때 제거
String removeDecimals(double value) {
  return value % 1 == 0 ? value.toInt().toString() : value.toString();
}
