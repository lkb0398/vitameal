import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/diseases_dto.dart';

abstract interface class DiseasesDataSource {
  Future<List<DiseasesDto>> fetchAll();
  Future<List<int>> findIdsByNames(List<String> names);
  Future<List<String>> findNamesByIds(List<int> ids);
}

class DiseasesDataSourceImpl implements DiseasesDataSource {
  DiseasesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<List<DiseasesDto>> fetchAll() async {
    final result = await client.from('diseases').select('id, name').order('id');

    return (result as List).map((e) => DiseasesDto.fromJson(e)).toList();
  }

  @override
  Future<List<int>> findIdsByNames(List<String> names) async {
    if (names.isEmpty) return [];

    final result = await client
        .from('diseases')
        .select('id')
        .inFilter('name', names);

    return (result as List).map((e) => e['id'] as int).toList();
  }

  @override
  Future<List<String>> findNamesByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    final result = await client
        .from('diseases')
        .select('name')
        .inFilter('id', ids);

    return (result as List).map((e) => e['name'] as String).toList();
  }
}
