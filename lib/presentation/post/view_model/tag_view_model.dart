// lib/presentation/post/view_model/tag_view_model.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/tag_entity.dart';

part 'tag_view_model.g.dart';

@riverpod
Future<List<TagEntity>> allTags(Ref ref) async {
  return await ref.watch(postRepositoryProvider).fetchAllTags();
}
