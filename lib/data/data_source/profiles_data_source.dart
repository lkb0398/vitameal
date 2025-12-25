import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/profiles_dto.dart';

// profiles 테이블 CRUD
abstract interface class ProfilesDataSource {
  Future<ProfilesDto?> getMyProfile(String userId);
  Future<void> updateProfile(ProfilesDto dto);
  Future<bool> checkNickname(String nickname);
  Future<void> replaceUserDiseases(String userId, List<int> diseaseIds);
  Future<void> replaceUserAllergies(String userId, List<int> allergyIds);
}

class ProfilesDataSourceImpl implements ProfilesDataSource {
  ProfilesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<ProfilesDto?> getMyProfile(String userId) async {
    final data = await client
        .from('profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (data == null) return null;
    return ProfilesDto.fromJson(data);
  }

  @override
  Future<void> updateProfile(ProfilesDto dto) {
    return client
        .from('profiles')
        .update(dto.toJson())
        .eq('user_id', dto.userId);
  }

  @override
  Future<bool> checkNickname(String nickname) async {
    final result = await client
        .from('profiles')
        .select('user_id')
        .eq('nickname', nickname)
        .maybeSingle();
    return result != null;
  }

  @override
  Future<void> replaceUserDiseases(String userId, List<int> diseaseIds) async {
    await client.from('user_diseases').delete().eq('user_id', userId);
    await client
        .from('user_diseases')
        .insert(
          diseaseIds
              .map((id) => {'user_id': userId, 'disease_id': id})
              .toList(),
        );
  }

  @override
  Future<void> replaceUserAllergies(String userId, List<int> allergyIds) async {
    await client.from('user_allergies').delete().eq('user_id', userId);
    await client
        .from('user_allergies')
        .insert(
          allergyIds
              .map((id) => {'user_id': userId, 'allergy_id': id})
              .toList(),
        );
  }
}
