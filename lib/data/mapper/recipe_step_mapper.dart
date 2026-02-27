import 'package:vitameal/data/dto/recipe_step_dto.dart';
import 'package:vitameal/domain/entity/recipe_step_entity.dart';

extension RecipeStepDtoMapper on RecipeStepDto {
  RecipeStepEntity toEntity() {
    return RecipeStepEntity(
      stepOrder: stepOrder,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

extension RecipeStepEntityMapper on RecipeStepEntity {
  Map<String, dynamic> toSupabaseMap(String postId) {
    return {
      'post_id': postId,
      'step_order': stepOrder,
      'description': description,
      'image_url': imageUrl,
    };
  }
}
