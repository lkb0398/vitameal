import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';
import 'package:vitameal/presentation/post/view_model/tag_view_model.dart';
import 'package:vitameal/presentation/ui_provider/formatted_date_provider.dart';
import 'package:vitameal/presentation/ui_provider/profiles_provider.dart';
import 'package:vitameal/presentation/util/show_gray_snackbar.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';

class PostDetailPage extends HookConsumerWidget {
  const PostDetailPage({super.key, required this.pId});
  final String pId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎
    final locale =
        ref.watch(localeViewModelProvider) ?? Localizations.localeOf(context);

    // --- 초기 데이터 및 상태 설정 ---
    final currentUserId = ref.watch(userIdProvider);
    final postsAsync = ref.watch(postViewModelProvider);

    final postFuture = useMemoized(
      () => ref.read(postViewModelProvider.notifier).getPostById(pId),
      [pId],
    );
    final postAsync = useFuture(postFuture);
    final allTagsAsync = ref.watch(allTagsProvider);

    // --- 로딩 및 에러 처리 ---
    if (postAsync.connectionState == ConnectionState.waiting &&
        !postAsync.hasData) {
      return Scaffold(
        backgroundColor: vrc(context).background,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (postAsync.hasError ||
        (!postAsync.hasData && postsAsync.value == null)) {
      return Scaffold(
        backgroundColor: vrc(context).background,
        appBar: AppBar(backgroundColor: vrc(context).background),
        body: Center(
          child: Text(
            l.failed_to_load_posts,
            style: TextStyle(color: vrc(context).text),
          ),
        ),
      );
    }

    final postFromList = postsAsync.value
        ?.where((p) => p.id == pId)
        .firstOrNull;
    final post = postFromList ?? postAsync.data!;
    final bool isMyPost = post.userId == currentUserId;

    return Scaffold(
      backgroundColor: vrc(context).background,
      appBar: AppBar(
        backgroundColor: vrc(context).background,
        iconTheme: IconThemeData(color: vrc(context).text),
        actions: [
          // --- 수정/삭제 관리 섹션 (작성자 전용) ---
          if (isMyPost)
            PopupMenuButton<String>(
              color: vrc(context).background,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onSelected: (value) async {
                if (value == 'delete') {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: l.confirm_delete,
                      cancelText: l.cancel,
                      confirmText: l.delete,
                      onConfirm: () => Navigator.pop(context, true),
                      confirmColor: fxc(context).primary400,
                    ),
                  );

                  if (confirm == true) {
                    try {
                      await ref
                          .read(postViewModelProvider.notifier)
                          .deletePost(post.id!);
                      if (context.mounted) {
                        context.pop();
                        showGraySnackBar(context, l.post_deleted);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showGraySnackBar(context, l.failed_to_delete);
                      }
                      // 📝
                      AnalyticsService.event(
                        'recipe_action',
                        p: {'action': 'delete'},
                      );
                    }
                  }
                } else if (value == 'modify') {
                  context.push(AppRoutePath.editPost, extra: post);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'modify',
                  child: Text(
                    l.edit,
                    style: TextStyle(fontSize: 12, color: vrc(context).text),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    l.delete_action,
                    style: TextStyle(
                      color: fxc(context).secondary400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          else
            const SizedBox.shrink(),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 대표 이미지 및 즐겨찾기 섹션 ---
            Stack(
              children: [
                post.imageUrl != null
                    ? Image.network(
                        post.imageUrl!,
                        height: 248,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 248,
                        width: double.infinity,
                        color: Colors.black12,
                        child: Center(
                          child: Icon(
                            Icons.restaurant,
                            size: 40,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                if (!isMyPost)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (isMyPost) {
                          showGraySnackBar(context, l.cannot_bookmark_own_post);
                          return;
                        }
                        ref
                            .read(postViewModelProvider.notifier)
                            .toggleBookmark(post.id!);
                      },
                      child: Icon(
                        post.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: post.isBookmarked
                            ? fxc(context).primary400
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
                  // --- 게시글 기본 정보 섹션 ---
                  Text(
                    post.title,
                    style: TextStyle(
                      color: vrc(context).text,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    post.ingredient,
                    style: TextStyle(color: vrc(context).text, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    post.createdAt != null
                        ? ref.watch(formattedDateProvider(post.createdAt!))
                        // [수정] 날짜 형식 로컬라이제이션
                        // DateFormat('yyyy.MM.dd').format(post.createdAt!)
                        : l.no_date_info,
                    style: TextStyle(color: vrc(context).hint, fontSize: 12),
                  ),
                  const SizedBox(height: 20),

                  // --- 태그 리스트 섹션 ---
                  allTagsAsync.when(
                    data: (tags) {
                      final displayTags = locale == Locale('ko')
                          ? post.selectedTagIds
                                    ?.map(
                                      (id) => tags
                                          .firstWhere(
                                            (t) => t.id == id,
                                            orElse: () => tags[0],
                                          )
                                          .name,
                                    )
                                    .toList() ??
                                []
                          : post.selectedTagIds
                                    ?.map(
                                      (id) => tags
                                          .firstWhere(
                                            (t) => t.id == id,
                                            orElse: () => tags[0],
                                          )
                                          .nameEn,
                                    )
                                    .toList() ??
                                [];

                      displayTags.sort();

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
                                  color: fxc(context).primary100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: fxc(context).primary100!,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "#$tagName",
                                  style: TextStyle(
                                    color: fxc(context).primary400,
                                    fontSize: 12,
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
                  Divider(color: vrc(context).border),

                  // --- 작성자 정보 섹션 ---
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: vrc(context).greyBackground,
                          backgroundImage:
                              (post.authorProfileImage != null &&
                                  post.authorProfileImage!.isNotEmpty)
                              ? NetworkImage(post.authorProfileImage!)
                              : null,
                          child:
                              (post.authorProfileImage == null ||
                                  post.authorProfileImage!.isEmpty)
                              ? Icon(
                                  Icons.person,
                                  color: vrc(context).imagePlusIcon,
                                  size: 24,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          post.authorName ?? l.anonymous_chef,
                          style: TextStyle(
                            color: fxc(context).textcolor400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: vrc(context).border),

                  // --- 레시피 순서 리스트 섹션 ---
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      l.recipe_steps,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: vrc(context).text,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "Step ${step.stepOrder}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: fxc(context).primary400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
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
                              border: Border.all(color: vrc(context).border!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              step.description,
                              softWrap: true,
                              style: TextStyle(
                                height: 1.5,
                                color: vrc(context).text,
                              ),
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
