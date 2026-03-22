import 'package:vitameal/data/data_source/eats_remote_data_source.dart';
import 'package:vitameal/data/data_source/local/eats_local_data_source.dart';
import 'package:vitameal/domain/entity/eats_entity.dart';
import 'package:vitameal/domain/repository/eats_repository.dart';

/// local-remote 조합
class EatsRepositoryImpl implements EatsRepository {
  EatsRepositoryImpl(this.remoteDS, this.localDS);

  final EatsRemoteDataSource remoteDS;
  final EatsLocalDataSource localDS;

  @override
  Future<List<EatsEntity>> fetch({
    required double lat,
    required double lng,
    int? tagId,
  }) async {
    // 1. 캐시 확인
    final cached = localDS.get(lat, lng, tagId);
    if (cached != null) {
      return cached;
    }

    // 2. API 호출
    final result = await remoteDS.fetch(lat, lng, tagId);

    // 3. 캐시 저장
    localDS.save(lat, lng, tagId, result);

    return result;
  }
}
