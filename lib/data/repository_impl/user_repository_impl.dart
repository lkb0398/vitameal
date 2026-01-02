import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/domain/entity/user_entity.dart';
import 'package:vitameal/domain/repository/user_repository.dart';
import 'package:vitameal/data/dto/user_dto.dart';
import 'package:vitameal/data/mapper/user_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient _client;
  UserRepositoryImpl(this._client);

  @override
  Future<UserEntity?> getProfile(String uid) async {
    try {
      final data = await _client
          .from('profiles')
          .select()
          .eq('user_id', uid)
          .maybeSingle();

      if (data == null) return null;
      return UserDto.fromJson(data).toEntity();
    } catch (e) {
      debugPrint('프로필을 가져오던중 오류: $e');
      return null;
    }
  }

  @override
  Future<void> updateProfile(UserEntity user) async {
    try {
      await _client.from('profiles').upsert({
        'user_id': user.uid,
        'nickname': user.nickname,
        'photo_url': user.photoUrl,
        'gender': user.gender,
        'height_cm': user.height,
        'weight_kg': user.weight,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('프로필 업데이트중 에러: $e');
      rethrow;
    }
  }
}
