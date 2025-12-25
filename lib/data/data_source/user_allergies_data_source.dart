import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/user_allergies_dto.dart';

abstract interface class UserAllergiesDataSource {
  Future<void> insertUserAllergies(List<UserAllergiesDto> dtos);
  Future<void> deleteByUserId(String userId);
  Future<List<UserAllergiesDto>> fetchByUserId(String userId);
}

class UserAllergiesDataSourceImpl implements UserAllergiesDataSource {
  UserAllergiesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<void> insertUserAllergies(List<UserAllergiesDto> dtos) async {
    final rows = dtos.map((e) => e.toJson()).toList();
    await client.from('user_allergies').insert(rows);
  }

  @override
  Future<void> deleteByUserId(String userId) async {
    await client.from('user_allergies').delete().eq('user_id', userId);
  }

  @override
  Future<List<UserAllergiesDto>> fetchByUserId(String userId) async {
    final result = await client
        .from('user_allergies')
        .select('allergy_id')
        .eq('user_id', userId);

    return (result as List).map((e) => UserAllergiesDto.fromJson(e)).toList();
  }
}
