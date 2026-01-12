import 'dart:io';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/presentation/post/view_model/recipe_step_ui_model.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

part 'post_view_model.g.dart';

@riverpod
class PostViewModel extends _$PostViewModel {
  bool _hasNextPage = true;
  int _currentPage = 0;
  final int _pageSize = 20;

  String _currentSearchQuery = "";
  List<int> _currentTagIds = [];

  String get currentQuery => _currentSearchQuery;

  @override
  Future<List<PostEntity>> build() async {
    ref.watch(userIdProvider);
    return await _fetchPosts(0);
  }

  Future<void> filterPosts({String? query, List<int>? tagIds}) async {
    if (query != null) _currentSearchQuery = query;
    if (tagIds != null) _currentTagIds = tagIds;

    _currentPage = 0;
    _hasNextPage = true;

    state = const AsyncValue.loading();
    try {
      final results = await _fetchPosts(0);
      state = AsyncValue.data(results);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> searchPosts(String query) async {
    await filterPosts(query: query);
  }

  Future<List<PostEntity>> _fetchPosts(int page) async {
    final repository = ref.read(postRepositoryProvider);
    final userId = ref.read(userIdProvider);

    final from = page * _pageSize;
    final to = from + _pageSize - 1;

    return await repository.fetchPosts(
      from: from,
      to: to,
      userId: userId,
      query: _currentSearchQuery,
      tagIds: _currentTagIds,
    );
  }

  Future<void> fetchNextPage() async {
    if (state.isLoading || !_hasNextPage) return;

    final previousState = state.value ?? [];

    try {
      _currentPage++;
      final nextPosts = await _fetchPosts(_currentPage);

      if (nextPosts.length < _pageSize) {
        _hasNextPage = false;
      }

      state = AsyncValue.data([...previousState, ...nextPosts]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updatePost({
    required String postId,
    required String title,
    required String ingredient,
    File? imageFile,
    required List<int> selectedTagIds,
    required List<RecipeStepUIModel> uiSteps,
  }) async {
    state = const AsyncValue.loading();
    final repository = ref.read(postRepositoryProvider);
    final userId = ref.read(userIdProvider);

    try {
      String? mainImageUrl;
      if (imageFile != null) {
        mainImageUrl = await repository.uploadImage(
          imageFile,
          "post-images",
          userId,
        );
      }

      final List<Map<String, dynamic>> finalSteps = [];
      for (int i = 0; i < uiSteps.length; i++) {
        String? stepImageUrl;
        if (uiSteps[i].image != null) {
          stepImageUrl = await repository.uploadImage(
            uiSteps[i].image!,
            "post-images",
            userId,
          );
        } else {
          stepImageUrl = uiSteps[i].existingImageUrl;
        }
        finalSteps.add(uiSteps[i].toDataMap(i + 1, stepImageUrl));
      }

      // 3. 서버 업데이트
      await repository.updatePost(
        postId: postId,
        title: title,
        ingredient: ingredient,
        imageUrl: mainImageUrl,
        selectedTagIds: selectedTagIds,
        steps: finalSteps,
      );

      ref.invalidateSelf();
      ref.invalidate(bookmarkedPostsProvider);
      ref.invalidate(myPostsProvider);
    } catch (e, stack) {
      debugPrint('수정 에러: $e');
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> deletePost(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    try {
      await repository.deletePost(postId);
      if (state.hasValue) {
        final updatedList = state.value!
            .where((post) => post.id != postId)
            .toList();
        state = AsyncValue.data(updatedList);
      }
      ref.invalidate(bookmarkedPostsProvider);
      ref.invalidate(myPostsProvider);
    } catch (e) {
      debugPrint('삭제 에러: $e');
      rethrow;
    }
  }

  Future<PostEntity> getPostById(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    final userId = ref.read(userIdProvider);
    try {
      return state.value!.firstWhere((p) => p.id == postId);
    } catch (_) {
      return await repository.fetchPostById(postId: postId, userId: userId);
    }
  }

  Future<void> toggleBookmark(String postId) async {
    final userId = ref.read(userIdProvider);
    final repository = ref.read(postRepositoryProvider);
    final previousState = state.value ?? [];

    // 낙관적 업데이트
    state = AsyncValue.data(
      previousState.map((post) {
        if (post.id == postId)
          return post.copyWith(isBookmarked: !post.isBookmarked);
        return post;
      }).toList(),
    );

    try {
      await repository.toggleBookmark(userId: userId, postId: postId);
      ref.invalidate(bookmarkedPostsProvider);
    } catch (e) {
      state = AsyncValue.data(previousState); // 실패 시 복구
    }
  }

  /// [게시글 등록]
  Future<void> addPost({
    required String title,
    required String ingredient,
    File? imageFile,
    required List<int> selectedTagIds,
    required List<RecipeStepUIModel> uiSteps,
  }) async {
    state = const AsyncValue.loading();
    final repository = ref.read(postRepositoryProvider);
    final userId = ref.read(userIdProvider);

    try {
      String? mainImageUrl;
      if (imageFile != null) {
        mainImageUrl = await repository.uploadImage(
          imageFile,
          "post-images",
          userId,
        );
      }

      final List<Map<String, dynamic>> finalSteps = [];
      for (int i = 0; i < uiSteps.length; i++) {
        String? stepImageUrl;
        if (uiSteps[i].image != null) {
          stepImageUrl = await repository.uploadImage(
            uiSteps[i].image!,
            "post-images",
            userId,
          );
        }
        finalSteps.add(uiSteps[i].toDataMap(i + 1, stepImageUrl));
      }

      await repository.createPost(
        title: title,
        ingredient: ingredient,
        imageUrl: mainImageUrl,
        userId: userId,
        selectedTagIds: selectedTagIds,
        steps: finalSteps,
      );
      ref.invalidateSelf();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}

@riverpod
Future<List<PostEntity>> bookmarkedPosts(Ref ref) async {
  final userId = ref.watch(userIdProvider);
  return await ref.watch(postRepositoryProvider).fetchBookmarkedPosts(userId);
}

@riverpod
Future<List<PostEntity>> myPosts(Ref ref) async {
  final userId = ref.watch(userIdProvider);
  final repository = ref.watch(postRepositoryProvider);
  return await repository.fetchPosts(
    from: 0,
    to: 100,
    userId: userId,
    authorId: userId,
  );
}
