import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supabase Storage 이미지 파일 업로드
abstract interface class ProfilesStorageDataSource {
  Future<String> uploadProfileImage({
    required String userId,
    required File file,
  });
}

class ProfilesStorageDataSourceImpl implements ProfilesStorageDataSource {
  ProfilesStorageDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<String> uploadProfileImage({
    required String userId,
    required File file,
  }) async {
    final fileExt = file.path.split('.').last;
    final filePath = '$userId/profile.$fileExt';

    await client.storage
        .from('profile-images')
        .upload(
          filePath,
          file,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/jpeg',
          ),
        );

    return client.storage.from('profile-images').getPublicUrl(filePath);
  }
}
