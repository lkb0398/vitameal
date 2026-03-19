import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/service/analytics_service.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/enum/meal_category_enum.dart';
import 'package:vitameal/presentation/auth/view_model/auth_view_model.dart';
import 'package:vitameal/presentation/meal_calendar/view_model/meal_calendar_viewmodel.dart';
import 'package:vitameal/presentation/meal_editor/view/widget/category_selector.dart';
import 'package:vitameal/presentation/meal_editor/view/widget/description_input.dart';
import 'package:vitameal/presentation/meal_editor/view/widget/image_upload_card.dart';
import 'package:vitameal/presentation/meal_editor/view/widget/time_selector.dart';
import 'package:vitameal/presentation/meal_editor/view_model/meal_editor_viewmodel.dart';
import 'package:vitameal/presentation/ui_provider/formatted_date_provider.dart';
import 'package:vitameal/presentation/util/show_gray_snackbar.dart';
import 'package:vitameal/presentation/widget/dialog/custom_dialog.dart';

class MealEditorPage extends HookConsumerWidget {
  const MealEditorPage({
    super.key,
    this.mealEntryId,
    this.mealDayId,
    required this.date,
  });

  final String? mealEntryId; // null이면 생성 모드
  final String? mealDayId;
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    // 수정 모드 여부
    final isEditMode = mealEntryId != null;

    // 뷰 모델 - 상태 안다루고 메서드만 사용
    final viewModel = ref.watch(mealEditorViewModelProvider.notifier);

    // 상태
    final selectedCategory = useState<MealCategory>(MealCategory.breakfast);
    final contentController = useTextEditingController();
    final selectedTime = useState<DateTime?>(null);
    final imageFile = useState<File?>(null);
    final photoUrl = useState<String?>(null);
    final isLoading = useState(false);
    final isImageUploading = useState(false);

    // 수정 모드일 경우 기존 데이터 로드
    useEffect(() {
      if (isEditMode && mealDayId != null && mealEntryId != null) {
        viewModel
            .loadEntry(mealDayId: mealDayId!, entryId: mealEntryId!)
            .then((entry) {
              if (entry != null) {
                selectedCategory.value = entry.category;
                contentController.text = entry.content ?? '';
                selectedTime.value = entry.eatenAt;
                photoUrl.value = entry.photoUrl;
              }
            })
            .catchError((e) {
              if (context.mounted) {
                showGraySnackBar(context, l.failed_to_load_data);
              }
            });
      }
      return null;
    }, []);

    /// 이미지 선택
    Future<void> pickImage() async {
      try {
        final pickedFile = await viewModel.pickImage();
        if (pickedFile != null) {
          imageFile.value = pickedFile;
        }
      } catch (e) {
        if (context.mounted) {
          showGraySnackBar(context, l.failed_to_select_image);
        }
      }
    }

    /// 이미지 제거
    void removeImage() {
      imageFile.value = null;
      photoUrl.value = null;
    }

    /// 완료 버튼
    Future<void> done() async {
      if (isLoading.value || isImageUploading.value) return;

      // 로그인 검증
      final session = ref.read(authViewModelProvider);
      final userId = session?.user.id;
      if (userId == null) {
        showGraySnackBar(context, l.login_required);
        return;
      }

      // 이미지 있을경우 이미지 로딩 플래그
      final shouldUpload = imageFile.value != null;
      if (shouldUpload) isImageUploading.value = true;
      isLoading.value = true;

      try {
        // 저장
        await viewModel.save(
          userId: userId,
          date: date,
          category: selectedCategory.value,
          content: contentController.text,
          selectedTime: selectedTime.value,
          imageFile: imageFile.value,
          existingPhotoUrl: photoUrl.value,
          mealDayId: mealDayId,
          entryId: mealEntryId,
        );

        // MealDay 없을때 식단 추가 하면 UI갱신 안되는 문제 해결
        // Provider 갱신해서 MealDay가 갱신되도록
        ref.invalidate(mealCalendarViewModelProvider);

        // 성공 시 뒤로가기
        if (context.mounted) {
          context.pop();
        }

        // 📝
        AnalyticsService.event('meal_action', p: {'action': 'create'});
      } catch (e) {
        if (context.mounted) {
          showGraySnackBar(context, l.enter_image_or_content);
        }
      } finally {
        if (shouldUpload) isImageUploading.value = false;
        isLoading.value = false;
      }
    }

    // 삭제 버튼
    Future<void> deleteMeal() async {
      if (mealEntryId == null) return;

      final confirmed = await showDialog<bool>(
        context: context,

        builder: (context) => CustomDialog(
          title: l.confirm_delete_meal,
          cancelText: l.cancel,
          confirmText: l.delete,
          onConfirm: () => Navigator.pop(context, true),
          confirmColor: fxc(context).primary400,
        ),
      );

      if (confirmed == true) {
        isLoading.value = true;
        try {
          await viewModel.delete(entryId: mealEntryId!);

          // MealDay 없을때 식단 추가 하면 UI갱신 안되는 문제 해결
          // Provider 갱신해서 MealDay가 갱신되도록
          ref.invalidate(mealCalendarViewModelProvider);

          // 성공 시 뒤로가기
          if (context.mounted) {
            context.pop();
          }

          // 📝
          AnalyticsService.event('meal_action', p: {'action': 'delete'});
        } catch (e) {
          if (context.mounted) {
            showGraySnackBar(context, l.failed_to_delete);
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBody: true, // bottomNavigationBar 영역까지 body 깔아주기
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: vrc(context).text),
            onPressed: () => context.pop(),
          ),
          actions: [
            if (isEditMode)
              TextButton(
                onPressed: deleteMeal,
                child: Text(
                  l.delete,
                  style: TextStyle(
                    color: vrc(context).content,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(width: 6),
          ],
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.meal_date(ref.watch(formattedDateProvider(date))),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: vrc(context).text,
                  ),
                ),
                const SizedBox(height: 16),

                // 이미지 업로드 카드
                ImageUploadCard(
                  imageFile: imageFile.value,
                  photoUrl: photoUrl.value,
                  isUploading: isImageUploading.value,
                  onPickImage: pickImage,
                  onRemoveImage: removeImage,
                ),

                const SizedBox(height: 22),

                // 카테고리 선택
                CategorySelector(
                  selectedCategory: selectedCategory.value,
                  onCategoryChanged: (category) =>
                      selectedCategory.value = category,
                ),

                const SizedBox(height: 22),

                // 설명 입력
                DescriptionInput(controller: contentController),

                const SizedBox(height: 22),

                // 시간 선택
                TimeSelector(
                  selectedTime: selectedTime.value,
                  date: date,
                  onTimeChanged: (time) => selectedTime.value = time,
                ),

                const SizedBox(height: 22),
              ],
            ),
          ),
        ),

        // 하단 완료 버튼
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading.value ? null : done,
                style: ElevatedButton.styleFrom(
                  backgroundColor: fxc(context).primary400,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        l.complete,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
