import 'package:vitameal/data/dto/post_dto.dart';
import 'package:vitameal/domain/entity/post_entity.dart';

import 'recipe_step_mapper.dart';

extension PostDtoMapper on PostDto {
  PostEntity toEntity({bool isBookmarked = false}) {
    String name = "익명 요리사";
    String? profileImg;

    // 🔔 profiles 데이터가 Map인지 List인지 체크하여 안전하게 추출
    if (profiles != null) {
      final Map<String, dynamic> profileData =
          (profiles is List && profiles.isNotEmpty)
          ? profiles[0]
          : (profiles is Map ? profiles as Map<String, dynamic> : {});

      name = profileData['nickname'] ?? "익명 요리사";
      profileImg = profileData['photo_url'];
    }

    return PostEntity(
      id: id,
      title: title,
      ingredient: ingredient,
      userId: userId,
      imageUrl: imageUrl,
      createdAt: createdAt,
      authorName: name,
      authorProfileImage: profileImg,
      selectedTagIds: postTags.map((e) => e['tag_id'] as int).toList(),
      recipeSteps: recipeSteps.map((e) => e.toEntity()).toList(),
      isBookmarked: isBookmarked,
    );
  }
}

extension PostEntityMapper on PostEntity {
  Map<String, dynamic> toSupabaseInsertMap() {
    return {
      'title': title,
      'ingredient': ingredient,
      'image_url': imageUrl,
      'user_id': userId,
    };
  }
}
