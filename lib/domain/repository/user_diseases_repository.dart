abstract class UserDiseasesRepository {
  Future<void> saveUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  });
  Future<List<int>> getUserDiseaseIds(String userId);
}
