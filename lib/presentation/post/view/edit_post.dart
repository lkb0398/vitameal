import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';
import 'package:vitameal/presentation/post/view_model/recipe_step_ui_model.dart';
import 'package:vitameal/presentation/post/view_model/tag_view_model.dart';
import 'package:vitameal/presentation/util/show_gray_snackbar.dart';

class EditPost extends HookConsumerWidget {
  final PostEntity? initialPost;
  const EditPost({super.key, this.initialPost});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎
    final locale =
        ref.watch(localeViewModelProvider) ?? Localizations.localeOf(context);

    // --- [상태 및 컨트롤러 초기화 섹션] ---
    final isEditMode = initialPost != null;

    final titleController = useTextEditingController(text: initialPost?.title);
    final ingredientController = useTextEditingController(
      text: initialPost?.ingredient,
    );

    final titleTextLength = useState<int>(initialPost?.title.length ?? 0);
    final ingredientTextLength = useState<int>(
      initialPost?.ingredient.length ?? 0,
    );

    final selectedImage = useState<File?>(null);
    final existingImageUrl = useState<String?>(initialPost?.imageUrl);
    final selectedTagIds = useState<List<int>>(
      initialPost?.selectedTagIds ?? [],
    );

    final recipeSteps = useState<List<RecipeStepUIModel>>([]);

    final picker = ImagePicker();
    final isSubmitting = useState(false);
    final allTagsAsync = ref.watch(allTagsProvider);

    // --- [데이터 바인딩 및 초기화 로직 섹션] ---
    useEffect(() {
      if (isEditMode && initialPost != null) {
        recipeSteps.value = initialPost!.recipeSteps.map((step) {
          return RecipeStepUIModel(
            controller: TextEditingController(text: step.description),
            existingImageUrl: step.imageUrl,
          );
        }).toList();
      } else if (recipeSteps.value.isEmpty) {
        recipeSteps.value = [
          RecipeStepUIModel(controller: TextEditingController()),
        ];
      }
      return null;
    }, [initialPost]);

    // --- [이미지 선택 유틸리티 섹션] ---
    Future<File?> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      return pickedFile != null ? File(pickedFile.path) : null;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: vrc(context).background,
        // --- [AppBar 섹션] ---
        appBar: AppBar(
          backgroundColor: vrc(context).background,
          title: Text(
            isEditMode ? l.edit_recipe : l.create_recipe,
            style: TextStyle(color: vrc(context).text),
          ),
          leading: IconButton(
            icon: Icon(Icons.close, color: vrc(context).text),
            onPressed: () => context.pop(),
          ),
          actions: [
            TextButton(
              onPressed: isSubmitting.value
                  ? null
                  : () async {
                      // 1. 제목 입력 검사
                      if (titleController.text.trim().isEmpty) {
                        showGraySnackBar(context, l.enter_title);
                        return;
                      }

                      // 2. 메인 이미지 유효성 검사
                      if (selectedImage.value == null &&
                          existingImageUrl.value == null) {
                        showGraySnackBar(
                          context,
                          l.register_representative_image,
                        );
                        return;
                      }

                      // 3. 레시피 각 단계(Step) 유효성 검사 [추가]
                      // - 이미지(새 파일 혹은 기존 URL)가 없는 단계가 있는지 확인
                      // - 설명(TextField)이 비어있는 단계가 있는지 확인
                      bool hasInvalidStep = recipeSteps.value.any((step) {
                        final bool hasNoImage =
                            step.image == null && step.existingImageUrl == null;
                        final bool hasNoDescription = step.controller.text
                            .trim()
                            .isEmpty;
                        return hasNoImage || hasNoDescription;
                      });

                      if (hasInvalidStep) {
                        showGraySnackBar(context, l.register_all_steps);
                        return;
                      }

                      isSubmitting.value = true;
                      try {
                        if (isEditMode) {
                          await ref
                              .read(postViewModelProvider.notifier)
                              .updatePost(
                                postId: initialPost!.id!,
                                title: titleController.text,
                                ingredient: ingredientController.text,
                                imageFile: selectedImage.value,
                                selectedTagIds: selectedTagIds.value,
                                uiSteps: recipeSteps.value,
                              );
                        } else {
                          await ref
                              .read(postViewModelProvider.notifier)
                              .addPost(
                                title: titleController.text,
                                ingredient: ingredientController.text,
                                imageFile: selectedImage.value,
                                selectedTagIds: selectedTagIds.value,
                                uiSteps: recipeSteps.value,
                              );

                          // 📝
                          AnalyticsService.event(
                            'recipe_action',
                            p: {'action': 'create'},
                          );
                        }
                        if (context.mounted) context.pop();
                      } catch (e) {
                        isSubmitting.value = false;
                        debugPrint("error: $e");
                      }
                    },
              child: isSubmitting.value
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: fxc(context).primary400,
                      ),
                    )
                  : Text(
                      l.complete,
                      style: TextStyle(
                        color: fxc(context).primary400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // --- [대표 이미지 업로드 영역 섹션] ---
              GestureDetector(
                onTap: () async => selectedImage.value = await pickImage(),
                child: Container(
                  width: double.infinity,
                  height: 248,
                  decoration: BoxDecoration(color: vrc(context).greyBackground),
                  child: selectedImage.value != null
                      ? Image.file(selectedImage.value!, fit: BoxFit.cover)
                      : (existingImageUrl.value != null
                            ? Image.network(
                                existingImageUrl.value!,
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    PhosphorIcons.plus(),
                                    size: 44,
                                    color: vrc(context).border,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    l.add_cover_image,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: vrc(context).hint,
                                    ),
                                  ),
                                ],
                              )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- [제목 입력 섹션] ---
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        l.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: vrc(context).text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleController,
                      maxLength: 20,
                      onChanged: (value) =>
                          titleTextLength.value = value.length,
                      style: TextStyle(color: vrc(context).text),
                      decoration: InputDecoration(
                        hintText: l.enter_title_hint,
                        hintStyle: TextStyle(color: vrc(context).hint),
                        counterStyle: TextStyle(color: vrc(context).content),
                        counterText: "${titleTextLength.value}/20",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: vrc(context).border!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: fxc(context).primary400!,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // --- [재료 입력 섹션] ---
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        l.ingredients,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: vrc(context).text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: ingredientController,
                      maxLength: 300,
                      onChanged: (value) =>
                          ingredientTextLength.value = value.length,
                      maxLines: 5,
                      style: TextStyle(color: vrc(context).text),
                      decoration: InputDecoration(
                        hintText: l.enter_ingredients_hint,
                        hintStyle: TextStyle(color: vrc(context).hint),
                        counterStyle: TextStyle(color: vrc(context).content),
                        counterText: "${ingredientTextLength.value}/300",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: vrc(context).border!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: fxc(context).primary400!,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33),
                    // --- [태그 선택 섹션] ---
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        l.tags,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: vrc(context).text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    allTagsAsync.when(
                      data: (tags) {
                        // [추가] 렌더링 직전에 태그 리스트를 이름순(가나다/ABC)으로 정렬한 복사본 생성
                        final sortedTags = [...tags]
                          ..sort(
                            (a, b) => locale == const Locale('ko')
                                ? a.name.compareTo(b.name)
                                : a.nameEn.compareTo(b.nameEn),
                          );
                        return Wrap(
                          spacing: 8.0,
                          // [수정] tags 대신 정렬된 sortedTags를 사용하여 맵핑
                          children: sortedTags.map((tag) {
                            final isSelected = selectedTagIds.value.contains(
                              tag.id,
                            );
                            final name = locale == Locale('ko')
                                ? tag.name
                                : tag.nameEn;
                            return ChoiceChip(
                              showCheckmark: false,
                              label: Text(
                                "#$name",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? fxc(context).primary500
                                      : fxc(context).primary400,
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected) {
                                  selectedTagIds.value = [
                                    ...selectedTagIds.value,
                                    tag.id,
                                  ];
                                } else {
                                  selectedTagIds.value = selectedTagIds.value
                                      .where((id) => id != tag.id)
                                      .toList();
                                }
                              },
                              backgroundColor: vrc(context).background,
                              selectedColor: fxc(context).primary200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: isSelected
                                      ? fxc(context).primary500!
                                      : fxc(context).primary400!,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                      loading: () => LinearProgressIndicator(
                        color: fxc(context).primary400,
                      ),
                      error: (e, _) => Text(
                        l.failed_to_load_tags,
                        style: TextStyle(color: vrc(context).text),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // --- [레시피 상세 단계 섹션] ---
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
                    const SizedBox(height: 12),
                    ...recipeSteps.value.asMap().entries.map((entry) {
                      final index = entry.key;
                      final step = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Text(
                                      "Step ${index + 1}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: fxc(context).primary400,
                                      ),
                                    ),
                                  ),
                                  if (recipeSteps.value.length > 1)
                                    GestureDetector(
                                      onTap: () {
                                        final newList = [...recipeSteps.value];
                                        newList.removeAt(index);
                                        recipeSteps.value = newList;
                                      },
                                      child: Text(
                                        l.delete,
                                        style: TextStyle(
                                          color: fxc(context).secondary400,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final img = await pickImage();
                                    if (img != null) {
                                      final newList = [...recipeSteps.value];
                                      newList[index].image = img;
                                      recipeSteps.value = newList;
                                    }
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: vrc(context).greyBackground,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: step.image != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.file(
                                              step.image!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : (step.existingImageUrl != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    step.existingImageUrl!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Icon(
                                                  Icons.camera_alt,
                                                  color: vrc(
                                                    context,
                                                  ).imagePlusIcon,
                                                )),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: step.controller,
                                    maxLines: 3,
                                    maxLength: 200,
                                    style: TextStyle(color: vrc(context).text),
                                    decoration: InputDecoration(
                                      hintText: l.step_description_hint(
                                        index + 1,
                                      ),
                                      hintStyle: TextStyle(
                                        color: vrc(context).hint,
                                      ),
                                      counterStyle: TextStyle(
                                        color: vrc(context).content,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: vrc(context).border!,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: fxc(context).primary400!,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // --- [순서 추가 버튼 섹션] ---
                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: fxc(context).primary400!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          recipeSteps.value = [
                            ...recipeSteps.value,
                            RecipeStepUIModel(
                              controller: TextEditingController(),
                            ),
                          ];
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: fxc(context).primary400,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l.add_recipe_step,
                              style: TextStyle(
                                color: fxc(context).primary400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
