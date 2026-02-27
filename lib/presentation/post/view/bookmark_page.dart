import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';

class BookmarkPage extends HookConsumerWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    // --- 초기 상태 및 데이터 로드 섹션 ---
    final selectedTabIndex = useState(0);
    final postsAsync = selectedTabIndex.value == 0
        ? ref.watch(bookmarkedPostsProvider)
        : ref.watch(myPostsProvider);

    return Scaffold(
      backgroundColor: vrc(context).background,
      appBar: AppBar(
        backgroundColor: vrc(context).background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: vrc(context).text),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l.saved_recipes,
          style: TextStyle(color: vrc(context).text),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // --- 탭 전환 버튼 섹션 ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                buildTabButton(
                  context,
                  l.favorites,
                  selectedTabIndex.value == 0,
                  () => selectedTabIndex.value = 0,
                ),
                const SizedBox(width: 10),
                buildTabButton(
                  context,
                  l.my_recipes,
                  selectedTabIndex.value == 1,
                  () => selectedTabIndex.value = 1,
                ),
              ],
            ),
          ),

          // --- 레시피 그리드 리스트 섹션 ---
          Expanded(
            child: postsAsync.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return Center(
                    child: Text(
                      l.empty_list,
                      style: TextStyle(color: vrc(context).content),
                    ),
                  );
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
                    return buildRecipeCard(
                      context,
                      posts[index],
                      ref,
                      isMyRecipeTab: selectedTabIndex.value == 1,
                    );
                  },
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: fxc(context).primary400,
                ),
              ),
              error: (err, _) => Center(
                child: Text(
                  "error: $err",
                  style: TextStyle(color: vrc(context).text),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 위젯 빌더 섹션 ---
  Widget buildTabButton(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? fxc(context).primary400
              : fxc(context).textcolor50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : fxc(context).textcolor400,
          ),
        ),
      ),
    );
  }

  Widget buildRecipeCard(
    BuildContext context,
    PostEntity post,
    WidgetRef ref, {
    required bool isMyRecipeTab,
  }) {
    return GestureDetector(
      key: ValueKey(post.id),
      onTap: () => context.push('/post/${post.id}'),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12,
              child: post.imageUrl != null && post.imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: post.imageUrl!,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 200),
                      fadeOutDuration: const Duration(milliseconds: 100),
                      errorWidget: (c, e, s) => const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.black26,
                      ),
                    )
                  : const Icon(Icons.restaurant, color: Colors.black26),
            ),
          ),
          if (!isMyRecipeTab)
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
                      ? fxc(context).primary400
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
