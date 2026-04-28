import 'package:vitameal/domain/entity/diseases_entity.dart';

abstract interface class DiseasesRepository {
  Future<List<DiseasesEntity>> readAllDiseases();
  Future<void> upsertUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  });
  Future<List<int>> readUserDiseases(String userId);
}
