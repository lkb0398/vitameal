import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/enum/meal_category_enum.dart';

class MealCard extends StatelessWidget {
  /// 식단 기록 카드
  const MealCard({
    super.key,
    required this.entryId,
    required this.category,
    this.content,
    this.photoUrl,
    this.eatenAt,
    this.onTap,
  });

  final String entryId;
  final MealCategory category;
  final String? content;
  final String? photoUrl;
  final DateTime? eatenAt;
  final VoidCallback? onTap;

  String get _categoryLabel {
    switch (category) {
      case MealCategory.breakfast:
        return '아침';
      case MealCategory.lunch:
        return '점심';
      case MealCategory.dinner:
        return '저녁';
      case MealCategory.snack:
        return '간식';
    }
  }

  String get _timeLabel {
    if (eatenAt == null) return '';
    final hour = eatenAt!.hour;
    final minute = eatenAt!.minute;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  bool get _hasContent => (content ?? '').trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!; // 🌎

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 썸네일 영역
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 96,
                    height: 96,
                    color: photoUrl == null ? Colors.black12 : null,
                    child: photoUrl != null
                        ? CachedNetworkImage(
                            imageUrl: photoUrl!,
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 200),
                            fadeOutDuration: const Duration(milliseconds: 100),
                            errorWidget: (_, __, ___) => const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.black26,
                              ),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.restaurant,
                              size: 28,
                              color: Colors.black26,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                // 우측 텍스트 영역
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 아침 점심 저녁 등 식단의 카테고리
                          Text(
                            _categoryLabel,
                            style: TextStyle(
                              color: vrc(context).text,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // 기록한 시간 있으면 출력
                          if (_timeLabel.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Text(
                              _timeLabel,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: vrc(context).hint,
                              ),
                            ),
                          ],
                          const Spacer(),
                          // 식단 자세히보기 이동 아이콘
                          Icon(
                            Icons.chevron_right,
                            color: vrc(context).hint,
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // 기록한 식단 내용 (미리보기 3줄)
                      if (_hasContent)
                        Text(
                          content!.trim(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: vrc(context).content,
                          ),
                        )
                      else
                        Text(
                          l.no_content,
                          style: TextStyle(
                            fontSize: 14,
                            color: vrc(context).content,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
