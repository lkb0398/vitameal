import 'package:vitameal/data/data_source/diseases_data_source.dart';
import 'package:vitameal/data/mapper/diseases_mapper.dart';
import 'package:vitameal/domain/entity/diseases_entity.dart';
import 'package:vitameal/domain/repository/diseases_repository.dart';

class DiseasesRepositoryImpl implements DiseasesRepository {
  DiseasesRepositoryImpl(this.dataSource);

  final DiseasesDataSource dataSource;

  @override
  Future<List<DiseasesEntity>> getAllDiseases() async {
    final dtos = await dataSource.fetchAll();
    return dtos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  }) async {
    await dataSource.saveUserDiseases(userId: userId, diseaseIds: diseaseIds);
  }

  @override
  Future<List<int>> getUserDiseases(String userId) async {
    return await dataSource.getUserDiseases(userId);
  }
}
