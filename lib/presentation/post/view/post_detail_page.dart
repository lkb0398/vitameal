import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';
import 'package:vitameal/presentation/post/view_model/tag_view_model.dart';

class PostDetailPage extends HookConsumerWidget {
  const PostDetailPage({super.key, required this.pId});
  final String pId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postViewModelProvider);

    final postFuture = useMemoized(
      () => ref.read(postViewModelProvider.notifier).getPostById(pId),
      [pId],
    );
    final postAsync = useFuture(postFuture);
    final allTagsAsync = ref.watch(allTagsProvider);

    if (postAsync.connectionState == ConnectionState.waiting &&
        !postAsync.hasData) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (postAsync.hasError ||
        (!postAsync.hasData && postsAsync.value == null)) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("게시글을 불러올 수 없습니다.")),
      );
    }

    final postFromList = postsAsync.value
        ?.where((p) => p.id == pId)
        .firstOrNull;
    final post = postFromList ?? postAsync.data!;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: (value) async {
              if (value == 'delete') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      '삭제하시겠습니까?',
                      style: TextStyle(fontSize: 16),
                    ),
                    content: const Text('삭제된 레시피는 복구할 수 없습니다.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text(
                          '취소',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          '삭제',
                          style: TextStyle(color: Color(0xFFFF506A)),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  try {
                    await ref
                        .read(postViewModelProvider.notifier)
                        .deletePost(post.id!);
                    if (context.mounted) {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('게시글이 삭제되었습니다.')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('삭제에 실패했습니다.')),
                      );
                    }
                  }
                }
              } else if (value == 'modify') {
                context.push(AppRoutePath.editPost, extra: post);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'modify',
                child: Text('수정하기', style: TextStyle(fontSize: 12)),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text(
                  '삭제하기',
                  style: TextStyle(color: Color(0xFFFF506A), fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                post.imageUrl != null
                    ? Image.network(
                        post.imageUrl!,
                        height: 248,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/profile_image.webp",
                        height: 248,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => ref
                        .read(postViewModelProvider.notifier)
                        .toggleBookmark(post.id!),
                    child: Icon(
                      post.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color: post.isBookmarked
                          ? const Color(0xFF89CC00)
                          : Colors.white,
                      size: 27,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    post.ingredient,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    post.createdAt != null
                        ? DateFormat('yyyy.MM.dd').format(post.createdAt!)
                        : "날짜 정보 없음",
                    style: const TextStyle(
                      color: Color(0xFFBCBCBC),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                  allTagsAsync.when(
                    data: (tags) {
                      final displayTags =
                          post.selectedTagIds
                              ?.map(
                                (id) => tags
                                    .firstWhere(
                                      (t) => t.id == id,
                                      orElse: () => tags[0],
                                    )
                                    .name,
                              )
                              .toList() ??
                          [];
                      if (displayTags.isEmpty) return const SizedBox.shrink();
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: displayTags
                            .map(
                              (tagName) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9F9C7),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF89CC00),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "#$tagName",
                                  style: const TextStyle(
                                    color: Color(0xFF89CC00),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                    loading: () => const SizedBox(
                      height: 30,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    error: (err, _) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFFF2F2F2),
                          // 📸 프로필 이미지가 있을 때만 NetworkImage를 사용
                          backgroundImage:
                              (post.authorProfileImage != null &&
                                  post.authorProfileImage!.isNotEmpty)
                              ? NetworkImage(post.authorProfileImage!)
                              : null,
                          // 👤 이미지가 없거나 로드 실패 시 보일 아이콘
                          child:
                              (post.authorProfileImage == null ||
                                  post.authorProfileImage!.isEmpty)
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 24,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          post.authorName ?? "익명 요리사", // 👤 실제 닉네임 표시
                          style: const TextStyle(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),

                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "레시피 순서",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: post.recipeSteps.length,
                    itemBuilder: (context, index) {
                      final step = post.recipeSteps[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Step ${step.stepOrder}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF89CC00),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (step.imageUrl != null &&
                              step.imageUrl!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  step.imageUrl!,
                                  width: double.infinity,
                                  height: 248,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                        "assets/images/profile2.png",
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFBCBCBC),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              step.description,
                              softWrap: true,
                              style: const TextStyle(height: 1.5),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
