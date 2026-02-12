import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';
import 'package:vitameal/presentation/post/view_model/tag_view_model.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';

class PostPage extends HookConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎
    final locale = ref.watch(localeViewModelProvider);

    final currentUserId = ref.watch(userIdProvider);
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
                    hintText: l.search_recipe_hint,
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
              const SizedBox(height: 14),

              // --- 태그 필터 섹션 ---
              allTagsAsync.when(
                data: (tags) {
                  // [추가] 렌더링 직전에 태그 리스트를 이름순(가나다/ABC)으로 정렬한 복사본 생성
                  final sortedTags = [...tags]
                    ..sort(
                      (a, b) => locale == const Locale('ko')
                          ? a.name.compareTo(b.name)
                          : a.nameEn.compareTo(b.nameEn),
                    );

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // [수정] tags 대신 정렬된 sortedTags를 사용하여 맵핑
                      children: sortedTags.map((tag) {
                        final isSelected = selectedTagIds.value.contains(
                          tag.id,
                        );
                        final name = locale == Locale('ko')
                            ? tag.name
                            : tag.nameEn;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            showCheckmark: false,
                            label: Text(
                              "#${name}",
                              style: TextStyle(
                                color: isSelected
                                    ? fxc(context).primary500
                                    : fxc(context).primary400,
                                fontWeight: FontWeight.normal,
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
                            selectedColor: fxc(context).primary200,
                            backgroundColor: vrc(context).background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: isSelected
                                    ? fxc(context).primary500!
                                    : fxc(context).primary400!,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
                loading: () => const SizedBox(height: 42),
                error: (err, _) => Text(
                  l.failed_to_load_tags,
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
                                l.no_search_result,
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
                          final bool isMyPost = post.userId == currentUserId;
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
                                    child: SizedBox(
                                      height: 96,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                post.authorName ??
                                                    l.anonymous_chef,
                                                style: TextStyle(
                                                  color: vrc(context).hint,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              if (!isMyPost) // [추가] 내 글이 아닐 때만 북마크 아이콘 노출
                                                IconButton(
                                                  onPressed: () {
                                                    ref
                                                        .read(
                                                          postViewModelProvider
                                                              .notifier,
                                                        )
                                                        .toggleBookmark(
                                                          post.id!,
                                                        );

                                                    AnalyticsService.event(
                                                      'recipe_action',
                                                      p: {'action': 'bookmark'},
                                                    );
                                                  },
                                                  icon: Icon(
                                                    post.isBookmarked
                                                        ? Icons.bookmark
                                                        : Icons
                                                              .bookmark_outline,
                                                    color: post.isBookmarked
                                                        ? fxc(
                                                            context,
                                                          ).primary400
                                                        : vrc(context).hint,
                                                  ),
                                                )
                                              else // [추가] 내 글일 경우 아이콘이 차지하던 공간을 비워둠
                                                const SizedBox(
                                                  height: 48,
                                                  width: 48,
                                                ), // IconButton의 기본 크기만큼 공간 유지
                                            ],
                                          ),
                                        ],
                                      ),
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
                      'error: $err',
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
