import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitameal/domain/entity/post_entity.dart';
import 'package:vitameal/presentation/post/view_model/post_view_model.dart';
import 'package:vitameal/presentation/post/view_model/recipe_step_ui_model.dart';
import 'package:vitameal/presentation/post/view_model/tag_view_model.dart';

class EditPost extends HookConsumerWidget {
  final PostEntity? initialPost;
  const EditPost({super.key, this.initialPost});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    Future<File?> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      return pickedFile != null ? File(pickedFile.path) : null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "레시피 수정" : "레시피 작성"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: isSubmitting.value
                ? null
                : () async {
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
                      }
                      if (context.mounted) context.pop();
                    } catch (e) {
                      isSubmitting.value = false;
                      debugPrint("처리 오류: $e");
                    }
                  },
            child: isSubmitting.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    "완료",
                    style: TextStyle(
                      color: Color(0xFF89CC00),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 대표 이미지 영역
            GestureDetector(
              onTap: () async => selectedImage.value = await pickImage(),
              child: Container(
                width: double.infinity,
                height: 248,
                decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                child: selectedImage.value != null
                    ? Image.file(selectedImage.value!, fit: BoxFit.cover)
                    : (existingImageUrl.value != null
                          ? Image.network(
                              existingImageUrl.value!,
                              fit: BoxFit.cover,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add, size: 40, color: Colors.grey),
                                Text("대표 이미지 추가"),
                              ],
                            )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "제목",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleController,
                    onChanged: (value) => titleTextLength.value = value.length,
                    decoration: InputDecoration(
                      hintText: "제목을 입력해주세요",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 33),
                  const Text(
                    "재료",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: ingredientController,
                    onChanged: (value) =>
                        ingredientTextLength.value = value.length,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "재료 정보를 입력해주세요",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 33),
                  const Text(
                    "태그",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            style: const TextStyle(color: Color(0xFF89CC00)),
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
                          backgroundColor: Colors.white,
                          selectedColor: const Color(0xFFD2F291),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xFF89CC00)),
                          ),
                        );
                      }).toList(),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => const Text("태그 로딩 실패"),
                  ),
                  const SizedBox(height: 40),

                  const Text(
                    "레시피 순서",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),

                  ...recipeSteps.value.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Stack(
                        children: [
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
                                    color: const Color(0xFFF2F2F2),
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
                                            : const Icon(
                                                Icons.camera_alt,
                                                color: Colors.grey,
                                              )),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: step.controller,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: "Step ${index + 1} 설명을 입력하세요",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (recipeSteps.value.length > 1)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  final newList = [...recipeSteps.value];
                                  newList.removeAt(index);
                                  recipeSteps.value = newList;
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.cancel,
                                    color: Color(0xFFFF506A),
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),

                  // 순서 추가 버튼
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF89CC00)),
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
                        children: const [
                          Icon(Icons.add, color: Color(0xFF89CC00), size: 16),
                          SizedBox(width: 8),
                          Text(
                            "레시피 순서 추가",
                            style: TextStyle(
                              color: Color(0xFF89CC00),
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
    );
  }
}
