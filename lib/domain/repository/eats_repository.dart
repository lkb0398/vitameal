import 'package:vitameal/domain/entity/eats_entity.dart';

abstract class EatsRepository {
  Future<List<EatsEntity>> fetch({
    required double lat,
    required double lng,
    int? tagId,
  });
}
