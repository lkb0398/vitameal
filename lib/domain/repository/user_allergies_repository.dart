abstract class UserAllergiesRepository {
  Future<void> saveUserAllergies({
    required String userId,
    required List<int> allergyIds,
  });
  Future<List<int>> getUserAllergyIds(String userId);
}
