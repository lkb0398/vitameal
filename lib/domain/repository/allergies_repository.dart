import 'package:vitameal/domain/entity/allergies_entity.dart';

abstract interface class AllergiesRepository {
  Future<List<AllergiesEntity>> readAllAllergies();
  Future<void> upsertUserAllergies({
    required String userId,
    required List<int> allergyIds,
  });
  Future<List<int>> readUserAllergies(String userId);
}
