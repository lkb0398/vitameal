import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/allergies_dto.dart';

abstract interface class AllergiesDataSource {
  Future<List<AllergiesDto>> fetchAll();
  Future<List<int>> findIdsByNames(List<String> names);
  Future<List<String>> findNamesByIds(List<int> ids);
}

class AllergiesDataSourceImpl implements AllergiesDataSource {
  AllergiesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<List<AllergiesDto>> fetchAll() async {
    final result = await client
        .from('allergies')
        .select('id, name')
        .order('id');
    return (result as List).map((e) => AllergiesDto.fromJson(e)).toList();
  }

  @override
  Future<List<int>> findIdsByNames(List<String> names) async {
    if (names.isEmpty) return [];
    final result = await client
        .from('allergies')
        .select('id')
        .inFilter('name', names);
    return (result as List).map((e) => e['id'] as int).toList();
  }

  @override
  Future<List<String>> findNamesByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    final result = await client
        .from('allergies')
        .select('name')
        .inFilter('id', ids);
    return (result as List).map((e) => e['name'] as String).toList();
  }
}
