import 'dart:io';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/domain/entity/tag_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> fetchPosts({
    required int from,
    required int to,
    required String userId,
    String? query,
    List<int>? tagIds,
    String? authorId,
  });

  Future<List<TagEntity>> fetchAllTags();

  Future<PostEntity> fetchPostById({
    required String postId,
    required String userId,
  });

  Future<bool> toggleBookmark({required String userId, required String postId});

  Future<List<PostEntity>> fetchBookmarkedPosts(String userId);

  Future<String?> uploadImage(File imageFile, String bucket, String userId);

  Future<void> createPost({
    required String title,
    required String ingredient,
    String? imageUrl,
    required String userId,
    required List<int> selectedTagIds,
    required List<Map<String, dynamic>> steps,
  });

  Future<void> deletePost(String postId);

  Future<void> updatePost({
    required String postId,
    required String title,
    required String ingredient,
    String? imageUrl,
    required List<int> selectedTagIds,
    required List<Map<String, dynamic>> steps,
  });
}
