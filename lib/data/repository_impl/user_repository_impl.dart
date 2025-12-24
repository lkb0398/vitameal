import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../dto/user_dto.dart';
import '../mapper/user_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient _client;
  UserRepositoryImpl(this._client);

  @override
  Future<UserEntity?> getProfile(String uid) async {
    try {
      // profiles 테이블에서 user_id가 일치하는 단일 행 선택
      final data = await _client
          .from('profiles')
          .select()
          .eq('user_id', uid)
          .maybeSingle();

      if (data == null) return null;
      // Dto 변환 후 Entity로 매핑하여 반환
      return UserDto.fromJson(data).toEntity();
    } catch (e) {
      // 배포시 로그를 남기거나 에러
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
        'updated_at': DateTime.now().toIso8601String(), // 업데이트 시간 추가
      });
    } catch (e) {
      debugPrint('프로필 업데이트중 에러: $e');
      rethrow;
    }
  }
}

// 유저 Repository 프로바이더
final userRepositoryProvider = Provider<UserRepository>((ref) {
  // Supabase.instance.client를 직접 쓸까 하다가 supabaseClientProvider를 만들어 둬서 그걸 watch함
  return UserRepositoryImpl(Supabase.instance.client);
});
