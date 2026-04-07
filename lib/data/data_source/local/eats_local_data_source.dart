import 'package:vitameal/data/dto/local_cache_dto.dart/eats_cache_dto.dart';
import 'package:vitameal/domain/entity/eats_entity.dart';

abstract interface class EatsLocalDataSource {
  List<EatsEntity>? get(double lat, double lng, int? tagId);
  void save(double lat, double lng, int? tagId, List<EatsEntity> data);
}

/// In-Memory 캐싱
class EatsLocalDataSourceImpl implements EatsLocalDataSource {
  final Map<String, EatsCacheDto<List<EatsEntity>>> _cache = {};

  String _key(double lat, double lng, int? tagId) {
    return "${lat.toStringAsFixed(3)}-${lng.toStringAsFixed(3)}-$tagId";
  }

  // 불러오기
  @override
  List<EatsEntity>? get(double lat, double lng, int? tagId) {
    final key = _key(lat, lng, tagId);
    final item = _cache[key];
    if (item != null && item.isValid) {
      return item.data;
    }
    return null;
  }

  // 저장
  @override
  void save(double lat, double lng, int? tagId, List<EatsEntity> data) {
    final key = _key(lat, lng, tagId);
    _cache[key] = EatsCacheDto(data);
  }
}
