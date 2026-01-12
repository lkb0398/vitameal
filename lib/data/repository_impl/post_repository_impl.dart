import 'dart:io';
import 'package:vitameal/data/data_source/post_remote_data_source.dart';
import 'package:vitameal/data/dto/post_dto.dart';
import 'package:vitameal/data/mapper/post_mapper.dart';
import 'package:vitameal/data/mapper/tag_mapper.dart';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/domain/entity/tag_entity.dart';
import 'package:vitameal/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _dataSource;

  PostRepositoryImpl(this._dataSource);

  @override
  Future<void> updatePost({
    required String postId,
    required String title,
    required String ingredient,
    String? imageUrl,
    required List<int> selectedTagIds,
    required List<Map<String, dynamic>> steps,
  }) async {
    await _dataSource.updatePost(postId, {
      'title': title,
      'ingredient': ingredient,
      if (imageUrl != null) 'image_url': imageUrl,
    });

    await _dataSource.deletePostTags(postId);
    await _dataSource.deleteRecipeSteps(postId);

    if (selectedTagIds.isNotEmpty) {
      final tagMaps = selectedTagIds
          .map((id) => {'post_id': postId, 'tag_id': id})
          .toList();
      await _dataSource.insertPostTags(tagMaps);
    }

    if (steps.isNotEmpty) {
      final stepsWithId = steps.map((s) => {...s, 'post_id': postId}).toList();
      await _dataSource.insertRecipeSteps(stepsWithId);
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await _dataSource.deletePost(postId);
  }

  @override
  Future<List<TagEntity>> fetchAllTags() async {
    final dtos = await _dataSource.fetchAllTags();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<PostEntity> fetchPostById({
    required String postId,
    required String userId,
  }) async {
    final dto = await _dataSource.fetchPostById(postId);
    final isMine = dto.postBookmarks.any(
      (b) => b['user_id'].toString() == userId.toString(),
    );
    return dto.toEntity(isBookmarked: isMine);
  }

  @override
  Future<List<PostEntity>> fetchPosts({
    required int from,
    required int to,
    required String userId,
    String? query,
    List<int>? tagIds,
    String? authorId, // 🔔 파라미터 추가
  }) async {
    final dtos = await _dataSource.fetchPosts(
      from: from,
      to: to,
      query: query,
      tagIds: tagIds,
      authorId: authorId, // 🔔 DataSource에 authorId 전달
    );

    return dtos.map((dto) {
      final isMine = dto.postBookmarks.any((b) => b['user_id'] == userId);
      return dto.toEntity(isBookmarked: isMine);
    }).toList();
  }

  @override
  Future<bool> toggleBookmark({
    required String userId,
    required String postId,
  }) async {
    final existing = await _dataSource.getBookmark(
      userId: userId,
      postId: postId,
    );
    if (existing != null) {
      await _dataSource.deleteBookmark(userId, postId);
      return false;
    } else {
      await _dataSource.insertBookmark(userId, postId);
      return true;
    }
  }

  @override
  Future<List<PostEntity>> fetchBookmarkedPosts(String userId) async {
    final data = await _dataSource.fetchBookmarkedPosts(userId);
    return data.map((json) {
      final postJson = json['posts'];
      return PostDto.fromJson(postJson).toEntity(isBookmarked: true);
    }).toList();
  }

  @override
  Future<String?> uploadImage(
    File imageFile,
    String bucket,
    String userId,
  ) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final path = '$userId/$fileName';
    return await _dataSource.uploadImage(imageFile, bucket, path);
  }

  @override
  Future<void> createPost({
    required String title,
    required String ingredient,
    String? imageUrl,
    required String userId,
    required List<int> selectedTagIds,
    required List<Map<String, dynamic>> steps,
  }) async {
    final postData = await _dataSource.createPost({
      'title': title,
      'ingredient': ingredient,
      'image_url': imageUrl,
      'user_id': userId,
    });
    final String postId = postData['id'];

    if (selectedTagIds.isNotEmpty) {
      final tagMaps = selectedTagIds
          .map((id) => {'post_id': postId, 'tag_id': id})
          .toList();
      await _dataSource.insertPostTags(tagMaps);
    }

    if (steps.isNotEmpty) {
      final stepsWithId = steps.map((s) => {...s, 'post_id': postId}).toList();
      await _dataSource.insertRecipeSteps(stepsWithId);
    }
  }
}
