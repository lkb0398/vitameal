import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';

class BookmarkPage extends HookConsumerWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabIndex = useState(0);

    final postsAsync = selectedTabIndex.value == 0
        ? ref.watch(bookmarkedPostsProvider)
        : ref.watch(myPostsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "저장된 레시피",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                buildTabButton(
                  "즐겨찾기",
                  selectedTabIndex.value == 0,
                  () => selectedTabIndex.value = 0,
                ),
                const SizedBox(width: 10),
                buildTabButton(
                  "나의 레시피",
                  selectedTabIndex.value == 1,
                  () => selectedTabIndex.value = 1,
                ),
              ],
            ),
          ),

          Expanded(
            child: postsAsync.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return const Center(child: Text("목록이 비어있습니다."));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1 / 1.1,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return buildRecipeCard(context, posts[index], ref);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text("오류가 발생했습니다: $err")),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF89CC00) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFFBCBCBC),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildRecipeCard(BuildContext context, PostEntity post, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.push('/post/${post.id}'),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: post.imageUrl != null && post.imageUrl!.isNotEmpty
                ? Image.network(
                    post.imageUrl!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Image.asset(
                      "assets/images/profile_image.webp",
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    "assets/images/profile_image.webp",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => ref
                  .read(postViewModelProvider.notifier)
                  .toggleBookmark(post.id!),
              child: Icon(
                post.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                color: post.isBookmarked
                    ? const Color(0xFF89CC00)
                    : Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
