import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/profiles_dto.dart';
import 'package:vitameal/data/mapper/profiles_mapper.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';

// profiles 테이블 CRUD
abstract interface class ProfilesDataSource {
  Future<String> uploadProfileImage({
    required String userId,
    required File file,
  });
  Future<ProfilesDto?> getMyProfile(String userId);
  Future<void> updateProfile(ProfilesEntity entity);
  Future<bool> checkNickname(String nickname);
}

class ProfilesDataSourceImpl implements ProfilesDataSource {
  ProfilesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<String> uploadProfileImage({
    required String userId,
    required File file,
  }) async {
    final filePath = '$userId/profileimg.jpg';

    await client.storage
        .from('profile-images')
        .upload(filePath, file, fileOptions: const FileOptions(upsert: true));

    final baseUrl = client.storage
        .from('profile-images')
        .getPublicUrl(filePath);

    return '$baseUrl?t=${DateTime.now().millisecondsSinceEpoch}';
  }

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
  Future<void> updateProfile(ProfilesEntity entity) async {
    final map = ProfilesMapper.toUpdateMap(entity);
    try {
      await client.from('profiles').update(map).eq('user_id', entity.userId);
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        throw DuplicateNicknameException();
      }
      rethrow;
    }
  }

  @override
  Future<bool> checkNickname(String nickname) async {
    final result = await client
        .from('profiles')
        .select('user_id')
        .eq('nickname', nickname)
        .limit(1);
    return result.isNotEmpty;
  }
}

class DuplicateNicknameException implements Exception {
  @override
  String toString() => '이미 사용 중인 닉네임입니다.';
}
