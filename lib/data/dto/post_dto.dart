import 'package:freezed_annotation/freezed_annotation.dart';
import 'recipe_step_dto.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

@freezed
abstract class PostDto with _$PostDto {
  const factory PostDto({
    String? id,
    required String title,
    required String ingredient,
    @JsonKey(name: "user_id") required String userId,
    @JsonKey(name: "image_url") String? imageUrl,
    @JsonKey(name: "created_at") DateTime? createdAt,

    @JsonKey(name: "profiles") dynamic profiles,
    @JsonKey(name: "post_tags")
    @Default([])
    List<Map<String, dynamic>> postTags,
    @JsonKey(name: "recipe_steps") @Default([]) List<RecipeStepDto> recipeSteps,
    @JsonKey(name: "post_bookmarks")
    @Default([])
    List<Map<String, dynamic>> postBookmarks,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);
}
