import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/core/service/analytics_service.dart';
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: vrc(context).background,
        appBar: AppBar(
          backgroundColor: vrc(context).background,
          actionsPadding: EdgeInsets.only(right: 10),
          actions: [
            IconButton(
              icon: Icon(Icons.bookmark, color: fxc(context).primary400),
              onPressed: () => context.push(AppRoutePath.bookmark),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // --- 검색 섹션 ---
              SizedBox(
                height: 42,
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    ref
                        .read(postViewModelProvider.notifier)
                        .filterPosts(
                          query: value,
                          tagIds: selectedTagIds.value,
                        );

                    // 📝
                    AnalyticsService.event(
                      'recipe_action',
                      p: {'action': 'search'},
                    );
                  },
                  style: TextStyle(color: vrc(context).text),
                  decoration: InputDecoration(
                    hintText: "원하는 레시피를 검색해보세요.",
                    hintStyle: TextStyle(color: vrc(context).hint),
                    suffixIcon: Icon(Icons.search, color: vrc(context).hint),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: vrc(context).border!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: fxc(context).primary400!),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- 태그 필터 섹션 ---
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
                                  ? fxc(context).textcolor0
                                  : fxc(context).primary500,
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
                          selectedColor: fxc(context).primary400,
                          backgroundColor: vrc(context).background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: fxc(context).primary400!),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                loading: () => const SizedBox(height: 42),
                error: (err, _) => Text(
                  "태그 로드 실패",
                  style: TextStyle(color: vrc(context).text),
                ),
              ),
              const SizedBox(height: 10),

              // --- 게시글 리스트 섹션 ---
              Expanded(
                child: postAsync.when(
                  data: (posts) {
                    if (posts.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          ref.invalidate(postViewModelProvider);
                        },
                        color: fxc(context).primary400,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            const SizedBox(height: 100),
                            Center(
                              child: Text(
                                "검색 결과가 없습니다.",
                                style: TextStyle(color: vrc(context).content),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(postViewModelProvider);
                      },
                      color: fxc(context).primary400,
                      child: ListView.separated(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            key: ValueKey(post.id), // 캐시 이미지 꼬임 방지
                            behavior: HitTestBehavior.opaque,
                            onTap: () => context.push('/post/${post.id}'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      width: 96,
                                      height: 96,
                                      color: Colors.black12, // 배경색
                                      child:
                                          post.imageUrl != null &&
                                              post.imageUrl!.isNotEmpty
                                          ? CachedNetworkImage(
                                              // url 이미지 캐싱
                                              imageUrl: post.imageUrl!,
                                              fadeInDuration: const Duration(
                                                milliseconds: 200,
                                              ), // 자연스럽게
                                              fadeOutDuration: const Duration(
                                                milliseconds: 100,
                                              ),
                                              fit: BoxFit.cover,
                                              errorWidget: (c, e, s) =>
                                                  const Center(
                                                    child: Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      color: Colors.black26,
                                                    ),
                                                  ),
                                            )
                                          : const Center(
                                              child: Icon(
                                                Icons.restaurant,
                                                color: Colors.black26,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.title,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: vrc(context).text,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              post.authorName ?? "작성자",
                                              style: TextStyle(
                                                color: vrc(context).hint,
                                                fontSize: 13,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(
                                                      postViewModelProvider
                                                          .notifier,
                                                    )
                                                    .toggleBookmark(post.id!);

                                                // 📝
                                                AnalyticsService.event(
                                                  'recipe_action',
                                                  p: {'action': 'bookmark'},
                                                );
                                              },
                                              icon: Icon(
                                                post.isBookmarked
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_outline,
                                                color: post.isBookmarked
                                                    ? fxc(context).primary400
                                                    : vrc(context).hint,
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
                        separatorBuilder: (context, index) =>
                            Divider(color: vrc(context).border),
                      ),
                    );
                  },
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: fxc(context).primary400,
                    ),
                  ),
                  error: (err, stack) => Center(
                    child: Text(
                      '에러: $err',
                      style: TextStyle(color: vrc(context).text),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // --- 하단 액션 섹션 ---
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(AppRoutePath.editPost),
          elevation: 0,
          shape: const CircleBorder(),
          backgroundColor: fxc(context).primary400,
          child: Icon(
            PhosphorIcons.pencilSimple(),
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
