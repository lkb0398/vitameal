import 'package:vitameal/data/data_source/user_allergies_data_source.dart';
import 'package:vitameal/data/dto/user_allergies_dto.dart';
import 'package:vitameal/domain/repository/user_allergies_repository.dart';

class UserAllergiesRepositoryImpl implements UserAllergiesRepository {
  UserAllergiesRepositoryImpl(this.dataSource);

  final UserAllergiesDataSource dataSource;

  @override
  Future<void> saveUserAllergies({
    required String userId,
    required List<int> allergyIds,
  }) async {
    // 수정 모드 대비: 기존 삭제
    await dataSource.deleteByUserId(userId);

    final dtos = allergyIds
        .map((id) => UserAllergiesDto(userId: userId, allergyId: id))
        .toList();

    await dataSource.insertUserAllergies(dtos);
  }

  @override
  Future<List<int>> getUserAllergyIds(String userId) async {
    final result = await dataSource.fetchByUserId(userId);
    return result.map((e) => e.allergyId).toList();
  }
}
