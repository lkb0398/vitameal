import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class UserAllergiesDataSource {
  Future<void> saveUserAllergies({
    required String userId,
    required List<int> allergyIds,
  });
  Future<List<int>> getUserAllergyIds(String userId);
}

class UserAllergiesDataSourceImpl implements UserAllergiesDataSource {
  UserAllergiesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<void> saveUserAllergies({
    required String userId,
    required List<int> allergyIds,
  }) async {
    // 기존 전부 삭제
    await client.from('user_allergies').delete().eq('user_id', userId);
    // 새로 insert
    final rows = allergyIds
        .map((id) => {'user_id': userId, 'allergy_id': id})
        .toList();
    if (rows.isNotEmpty) {
      await client.from('user_allergies').insert(rows);
    }
  }

  @override
  Future<List<int>> getUserAllergyIds(String userId) async {
    final result = await client
        .from('user_allergies')
        .select('allergy_id')
        .eq('user_id', userId);
    return (result as List).map((e) => e['allergy_id'] as int).toList();
  }
}
