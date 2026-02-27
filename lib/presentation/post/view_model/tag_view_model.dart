// lib/presentation/post/view_model/tag_view_model.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/tag_entity.dart';

part 'tag_view_model.g.dart';

@riverpod
Future<List<TagEntity>> allTags(Ref ref) async {
  final repository = ref.watch(postRepositoryProvider);
  final tags = await repository.fetchAllTags();

  tags.sort((a, b) => a.name.compareTo(b.name));
  return tags;
}
