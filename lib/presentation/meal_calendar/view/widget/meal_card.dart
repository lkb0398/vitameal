import 'package:flutter/material.dart';
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 썸네일 영역
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 120,
                      height: 112,
                      color: photoUrl == null ? Colors.black12 : null,
                      child: photoUrl != null
                          ? Image.network(
                              photoUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Center(child: Icon(Icons.image_not_supported_outlined, color: Colors.black26)),
                            )
                          : const Center(child: Icon(Icons.restaurant, size: 28, color: Colors.black26)),
                    ),
                  ),
                  const SizedBox(width:16),
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
                                fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            // 기록한 시간 있으면 출력
                            if (_timeLabel.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Text(
                                _timeLabel,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: vrc(context).border,
                                ),
                              ),
                            ],
                            const Spacer(),
                            // 식단 자세히보기 이동 아이콘
                            const Icon(Icons.chevron_right, color: Colors.black26, size: 24),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // 기록한 식단 내용 (미리보기 3줄)
                        if (_hasContent)
                          Text(
                            content!.trim(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: vrc(context).text, fontWeight: FontWeight.w500),
                          )
                        else
                          Text(
                            '내용이 없습니다',
                            style: TextStyle(fontSize: 14, color: vrc(context).text, fontWeight: FontWeight.w500)
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 하단 구분선
            const Divider(height: 1, thickness: 1, color: Color(0xFFE6E6E6)),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return InkWell(
  //     onTap: onTap,
  //     borderRadius: BorderRadius.circular(14),
  //     child: Container(
  //       margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
  //       padding: const EdgeInsets.all(14),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(color: Colors.black12),
  //         borderRadius: BorderRadius.circular(14),
  //       ),
  //       child: Row(
  //         children: [
  //           // 이미지 없으면 이미지 홀더
  //           Container(
  //             width: 44,
  //             height: 44,
  //             decoration: BoxDecoration(
  //               color: photoUrl != null ? null : Colors.black12,
  //               borderRadius: BorderRadius.circular(12),
  //               image: photoUrl != null
  //                   ? DecorationImage(
  //                       image: NetworkImage(photoUrl!),
  //                       fit: BoxFit.cover,
  //                     )
  //                   : null,
  //             ),
  //             child: photoUrl == null
  //                 ? const Icon(Icons.restaurant, size: 20, color: Colors.black26)
  //                 : null,
  //           ),
  //           const SizedBox(width: 12),
  //           // 식단 카테고리, 먹은 시간 라벨
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Text(
  //                       _categoryLabel,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.w700,
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                     if (_timeLabel.isNotEmpty) ...[
  //                       const SizedBox(width: 6),
  //                       Text(
  //                         '| $_timeLabel',
  //                         style: const TextStyle(
  //                           color: Colors.black45,
  //                           fontSize: 13,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ],
  //                   ],
  //                 ),
  //                 // 기록한 내용
  //                 if (content != null && content!.isNotEmpty) ...[
  //                   const SizedBox(height: 6),
  //                   Text(
  //                     content!,
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: const TextStyle(color: Colors.black54, fontSize: 13),
  //                   ),
  //                 ],
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
