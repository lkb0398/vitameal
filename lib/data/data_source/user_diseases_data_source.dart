import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/user_diseases_dto.dart';

abstract interface class UserDiseasesDataSource {
  Future<void> insertUserDiseases(List<UserDiseasesDto> dtos);
  Future<void> deleteByUserId(String userId);
  Future<List<UserDiseasesDto>> fetchByUserId(String userId);
}

class UserDiseasesDataSourceImpl implements UserDiseasesDataSource {
  UserDiseasesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<void> insertUserDiseases(List<UserDiseasesDto> dtos) async {
    final rows = dtos.map((e) => e.toJson()).toList();
    await client.from('user_diseases').insert(rows);
  }

  @override
  Future<void> deleteByUserId(String userId) async {
    await client.from('user_diseases').delete().eq('user_id', userId);
  }

  @override
  Future<List<UserDiseasesDto>> fetchByUserId(String userId) async {
    final result = await client
        .from('user_diseases')
        .select('disease_id')
        .eq('user_id', userId);

    return (result as List).map((e) => UserDiseasesDto.fromJson(e)).toList();
  }
}
