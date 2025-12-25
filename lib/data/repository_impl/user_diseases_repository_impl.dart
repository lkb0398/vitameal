import 'package:vitameal/data/data_source/user_diseases_data_source.dart';
import 'package:vitameal/data/dto/user_diseases_dto.dart';
import 'package:vitameal/domain/repository/user_diseases_repository.dart';

class UserDiseasesRepositoryImpl implements UserDiseasesRepository {
  UserDiseasesRepositoryImpl(this.dataSource);

  final UserDiseasesDataSource dataSource;

  @override
  Future<void> saveUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  }) async {
    // 수정 모드 대비: 기존 삭제
    await dataSource.deleteByUserId(userId);

    final dtos = diseaseIds
        .map((id) => UserDiseasesDto(userId: userId, diseaseId: id))
        .toList();

    await dataSource.insertUserDiseases(dtos);
  }

  @override
  Future<List<int>> getUserDiseaseIds(String userId) async {
    final result = await dataSource.fetchByUserId(userId);
    return result.map((e) => e.diseaseId).toList();
  }
}
