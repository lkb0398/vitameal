/// In-Memory 캐싱용 Dto
class EatsCacheDto<T> {
  final T data; // 음식점 데이터
  final DateTime createdAt;

  EatsCacheDto(this.data) : createdAt = DateTime.now();

  // 10분간 유효
  bool get isValid => DateTime.now().difference(createdAt).inMinutes < 10;
}
