import 'package:vitameal/domain/entity/diseases_entity.dart';

abstract interface class DiseasesRepository {
  Future<List<DiseasesEntity>> getAllDiseases();
  Future<void> saveUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  });
  Future<List<int>> getUserDiseases(String userId);
}
