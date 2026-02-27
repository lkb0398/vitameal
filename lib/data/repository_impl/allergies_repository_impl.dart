import 'package:vitameal/data/data_source/allergies_data_source.dart';
import 'package:vitameal/data/mapper/allergies_mapper.dart';
import 'package:vitameal/domain/entity/allergies_entity.dart';
import 'package:vitameal/domain/repository/allergies_repository.dart';

class AllergiesRepositoryImpl implements AllergiesRepository {
  AllergiesRepositoryImpl(this.dataSource);

  final AllergiesDataSource dataSource;

  @override
  Future<List<AllergiesEntity>> getAllAllergies() async {
    final dtos = await dataSource.fetchAll();
    return dtos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveUserAllergies({
    required String userId,
    required List<int> allergyIds,
  }) async {
    await dataSource.saveUserAllergies(userId: userId, allergyIds: allergyIds);
  }

  @override
  Future<List<int>> getUserAllergies(String userId) async {
    return await dataSource.getUserAllergies(userId);
  }
}
