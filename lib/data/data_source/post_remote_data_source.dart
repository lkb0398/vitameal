import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/post_dto.dart';
import 'package:vitameal/data/dto/tag_dto.dart';

abstract class PostRemoteDataSource {
  Future<List<PostDto>> fetchPosts({
    required int from,
    required int to,
    String? query,
    List<int>? tagIds,
  });

  Future<Map<String, dynamic>?> getBookmark({
    required String userId,
    required String postId,
  });
  Future<void> insertBookmark(String userId, String postId);
  Future<void> deleteBookmark(String userId, String postId);
  Future<List<Map<String, dynamic>>> fetchBookmarkedPosts(String userId);
  Future<String> uploadImage(File file, String bucket, String path);
  Future<Map<String, dynamic>> createPost(Map<String, dynamic> postMap);
  Future<void> insertPostTags(List<Map<String, dynamic>> tagData);
  Future<void> insertRecipeSteps(List<Map<String, dynamic>> stepsData);
  Future<List<TagDto>> fetchAllTags();
  Future<PostDto> fetchPostById(String postId);
  Future<void> deletePost(String postId);
  Future<void> updatePost(String postId, Map<String, dynamic> postMap);
  Future<void> deletePostTags(String postId);
  Future<void> deleteRecipeSteps(String postId);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final SupabaseClient _client;
  PostRemoteDataSourceImpl(this._client);

  @override
  Future<List<PostDto>> fetchPosts({
    required int from,
    required int to,
    String? query,
    List<int>? tagIds,
  }) async {
    final isTagFiltering = tagIds != null && tagIds.isNotEmpty;

    var request = _client.from('posts').select('''
  *,
  recipe_steps(*),
  post_bookmarks(user_id),
  post_tags${isTagFiltering ? '!inner' : ''}(tag_id),
  profiles:user_id(nickname, photo_url) -- 🔔 명칭을 profiles:user_id로 변경
''');

    if (query != null && query.isNotEmpty) {
      request = request.ilike('title', '%$query%');
    }

    if (isTagFiltering) {
      request = request.inFilter('post_tags.tag_id', tagIds!);
    }

    final response = await request
        .order('created_at', ascending: false)
        .range(from, to);

    return (response as List).map((json) => PostDto.fromJson(json)).toList();
  }

  @override
  Future<void> deletePostTags(String postId) async {
    await _client.from('post_tags').delete().eq('post_id', postId);
  }

  @override
  Future<void> deleteRecipeSteps(String postId) async {
    await _client.from('recipe_steps').delete().eq('post_id', postId);
  }

  @override
  Future<void> updatePost(String postId, Map<String, dynamic> postMap) async {
    await _client.from('posts').update(postMap).eq('id', postId);
  }

  @override
  Future<void> deletePost(String postId) async {
    await _client.from('posts').delete().eq('id', postId);
  }

  @override
  Future<List<TagDto>> fetchAllTags() async {
    final response = await _client.from('tags').select().order('id');
    return (response as List).map((json) => TagDto.fromJson(json)).toList();
  }

  @override
  Future<PostDto> fetchPostById(String postId) async {
    final response = await _client
        .from('posts')
        .select('''
    *,
    recipe_steps(*),
    post_bookmarks(user_id),
    post_tags(tag_id),
    profiles:user_id(nickname, photo_url) -- 🔔 여기도 똑같이 profiles:user_id로 변경
  ''')
        .eq('id', postId)
        .single();
    return PostDto.fromJson(response);
  }

  @override
  Future<Map<String, dynamic>?> getBookmark({
    required String userId,
    required String postId,
  }) async {
    return await _client.from('post_bookmarks').select().match({
      'user_id': userId,
      'post_id': postId,
    }).maybeSingle();
  }

  @override
  Future<void> insertBookmark(String userId, String postId) async {
    await _client.from('post_bookmarks').insert({
      'user_id': userId,
      'post_id': postId,
    });
  }

  @override
  Future<void> deleteBookmark(String userId, String postId) async {
    await _client.from('post_bookmarks').delete().match({
      'user_id': userId,
      'post_id': postId,
    });
  }

  @override
  Future<List<Map<String, dynamic>>> fetchBookmarkedPosts(String userId) async {
    final response = await _client
        .from('post_bookmarks')
        .select('posts(*, recipe_steps(*))')
        .eq('user_id', userId);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<String> uploadImage(File file, String bucket, String path) async {
    await _client.storage.from(bucket).upload(path, file);
    return _client.storage.from(bucket).getPublicUrl(path);
  }

  @override
  Future<Map<String, dynamic>> createPost(Map<String, dynamic> postMap) async {
    return await _client.from('posts').insert(postMap).select().single();
  }

  @override
  Future<void> insertPostTags(List<Map<String, dynamic>> tagData) async {
    await _client.from('post_tags').insert(tagData);
  }

  @override
  Future<void> insertRecipeSteps(List<Map<String, dynamic>> stepsData) async {
    await _client.from('recipe_steps').insert(stepsData);
  }
}
