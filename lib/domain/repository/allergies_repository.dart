import 'package:vitameal/domain/entity/allergies_entity.dart';

abstract interface class AllergiesRepository {
  Future<List<AllergiesEntity>> getAllAllergies();
  Future<void> saveUserAllergies({
    required String userId,
    required List<int> allergyIds,
  });
  Future<List<int>> getUserAllergies(String userId);
}
