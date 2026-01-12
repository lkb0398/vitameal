import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';
import 'package:vitameal/presentation/post/view_model/tag_view_model.dart';

class PostPage extends HookConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postViewModelProvider);
    final allTagsAsync = ref.watch(allTagsProvider);

    final scrollController = useScrollController();
    final selectedTagIds = useState<List<int>>([]);
    final searchController = useTextEditingController();

    useEffect(() {
      void listener() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          ref.read(postViewModelProvider.notifier).fetchNextPage();
        }
      }

      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark, color: Color(0xFF89CC00)),
            onPressed: () => context.push(AppRoutePath.bookmark),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 42,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  ref
                      .read(postViewModelProvider.notifier)
                      .filterPosts(query: value, tagIds: selectedTagIds.value);
                },
                decoration: InputDecoration(
                  hintText: "원하는 레시피를 검색해보세요.",
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            allTagsAsync.when(
              data: (tags) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tags.map((tag) {
                    final isSelected = selectedTagIds.value.contains(tag.id);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        showCheckmark: false,
                        label: Text(
                          "#${tag.name}",
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF669900),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          List<int> newList;
                          if (selected) {
                            newList = [...selectedTagIds.value, tag.id];
                          } else {
                            newList = selectedTagIds.value
                                .where((id) => id != tag.id)
                                .toList();
                          }
                          selectedTagIds.value = newList;

                          ref
                              .read(postViewModelProvider.notifier)
                              .filterPosts(
                                query: searchController.text,
                                tagIds: newList,
                              );
                        },
                        selectedColor: const Color(0xFF89CC00),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFF89CC00)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              loading: () => const SizedBox(height: 42),
              error: (err, _) => const Text("태그 로드 실패"),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: postAsync.when(
                data: (posts) {
                  if (posts.isEmpty) {
                    return const Center(child: Text("검색 결과가 없습니다."));
                  }
                  return ListView.separated(
                    controller: scrollController,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => context.push('/post/${post.id}'),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child:
                                    post.imageUrl != null &&
                                        post.imageUrl!.isNotEmpty
                                    ? Image.network(
                                        post.imageUrl!,
                                        width: 96,
                                        height: 96,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                                  "assets/images/profile2.png",
                                                  width: 96,
                                                  height: 96,
                                                ),
                                      )
                                    : Image.asset(
                                        "assets/images/profile_image.webp",
                                        width: 96,
                                        height: 96,
                                      ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // 🔔 post.authorName을 사용하여 닉네임 표시
                                        Text(
                                          post.authorName ?? "작성자",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => ref
                                              .read(
                                                postViewModelProvider.notifier,
                                              )
                                              .toggleBookmark(post.id!),
                                          icon: Icon(
                                            post.isBookmarked
                                                ? Icons.bookmark
                                                : Icons.bookmark_outline,
                                            color: post.isBookmarked
                                                ? const Color(0xFF89CC00)
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('에러: $err')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutePath.editPost),
        backgroundColor: const Color(0xFF89CC00),
        shape: const CircleBorder(),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
