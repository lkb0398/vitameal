import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';
import 'package:vitameal/presentation/post/view_model/recipe_step_ui_model.dart';
import 'package:vitameal/presentation/post/view_model/tag_view_model.dart';

class EditPost extends HookConsumerWidget {
  final PostEntity? initialPost;
  const EditPost({super.key, this.initialPost});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            isEditMode ? "레시피 수정" : "레시피 작성",
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("제목을 입력해주세요.")),
                        );
                        return;
                      }

                      // 2. 메인 이미지 유효성 검사
                      if (selectedImage.value == null &&
                          existingImageUrl.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("대표 이미지를 등록해주세요.")),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("모든 단계의 이미지와 설명을 등록해주세요."),
                          ),
                        );
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

                          // ... Analytics 로직 동일 ...
                        }
                        if (context.mounted) context.pop();
                      } catch (e) {
                        isSubmitting.value = false;
                        debugPrint("처리 오류: $e");
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
                      "완료",
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
                                    '대표 이미지 추가',
                                    style: TextStyle(
                                      color: vrc(context).hint,
                                      fontSize: 13,
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
                    Text(
                      "제목",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: vrc(context).text,
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
                        hintText: "제목을 입력해주세요",
                        hintStyle: TextStyle(color: vrc(context).hint),
                        counterStyle: TextStyle(color: vrc(context).content),
                        counterText: "${titleTextLength.value}/20자",
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
                    Text(
                      "재료",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: vrc(context).text,
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
                        hintText: "재료 정보를 입력해주세요",
                        hintStyle: TextStyle(color: vrc(context).hint),
                        counterStyle: TextStyle(color: vrc(context).content),
                        counterText: "${ingredientTextLength.value}/300자",
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
                    Text(
                      "태그",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: vrc(context).text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    allTagsAsync.when(
                      data: (tags) => Wrap(
                        spacing: 8.0,
                        children: tags.map((tag) {
                          final isSelected = selectedTagIds.value.contains(
                            tag.id,
                          );
                          return ChoiceChip(
                            showCheckmark: false,
                            label: Text(
                              "#${tag.name}",
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
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
                            selectedColor: fxc(context).primary400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: fxc(context).primary400!),
                            ),
                          );
                        }).toList(),
                      ),
                      loading: () => LinearProgressIndicator(
                        color: fxc(context).primary400,
                      ),
                      error: (e, _) => Text(
                        "태그 로딩 실패",
                        style: TextStyle(color: vrc(context).text),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // --- [레시피 상세 단계 섹션] ---
                    Text(
                      "레시피 순서",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: vrc(context).text,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...recipeSteps.value.asMap().entries.map((entry) {
                      final index = entry.key;
                      final step = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Step ${index + 1}",
                                    style: TextStyle(
                                      color: fxc(context).primary400,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (recipeSteps.value.length > 1)
                                    TextButton(
                                      onPressed: () {
                                        final newList = [...recipeSteps.value];
                                        newList.removeAt(index);
                                        recipeSteps.value = newList;
                                      },
                                      child: Text(
                                        "삭제",
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
                                      hintText: "Step ${index + 1} 설명을 입력하세요",
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
                              "레시피 순서 추가",
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
