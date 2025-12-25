import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class UserDiseasesDataSource {
  Future<void> saveUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  });
  Future<List<int>> getUserDiseaseIds(String userId);
}

class UserDiseasesDataSourceImpl implements UserDiseasesDataSource {
  UserDiseasesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<void> saveUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  }) async {
    // 기존 전부 삭제
    await client.from('user_diseases').delete().eq('user_id', userId);
    // 새로 insert
    final rows = diseaseIds
        .map((id) => {'user_id': userId, 'disease_id': id})
        .toList();
    if (rows.isNotEmpty) {
      await client.from('user_diseases').insert(rows);
    }
  }

  @override
  Future<List<int>> getUserDiseaseIds(String userId) async {
    final result = await client
        .from('user_diseases')
        .select('disease_id')
        .eq('user_id', userId);
    return (result as List).map((e) => e['disease_id'] as int).toList();
  }
}
