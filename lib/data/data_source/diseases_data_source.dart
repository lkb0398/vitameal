import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/diseases_dto.dart';

abstract interface class DiseasesDataSource {
  Future<List<DiseasesDto>> readAllDiseases();
  Future<void> upsertUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  });
  Future<List<int>> readUserDiseases(String userId);
}

class DiseasesDataSourceImpl implements DiseasesDataSource {
  DiseasesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<List<DiseasesDto>> readAllDiseases() async {
    try {
      final result = await client.from('diseases').select();
      return (result as List).map((e) => DiseasesDto.fromJson(e)).toList();
    } on PostgrestException catch (e, s) {
      log('DB 오류로 인한 fetchAll 실패 : ${e.message}', error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 fetchAll 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override // R
  Future<List<int>> readUserDiseases(String userId) async {
    try {
      final result = await client
          .from('user_diseases')
          .select('disease_id')
          .eq('user_id', userId);
      return (result as List).map((e) => e['disease_id'] as int).toList();
    } on PostgrestException catch (e, s) {
      log(
        'DB 오류로 인한 getUserDiseaseIds 실패 : ${e.message}',
        error: e,
        stackTrace: s,
      );
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 getUserDiseaseIds 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override // C
  Future<void> upsertUserDiseases({
    required String userId,
    required List<int> diseaseIds,
  }) async {
    try {
      // 기존 전부 삭제
      await client.from('user_diseases').delete().eq('user_id', userId);
      // 새로 insert
      final rows = diseaseIds
          .map((id) => {'user_id': userId, 'disease_id': id})
          .toList();
      if (rows.isNotEmpty) {
        await client.from('user_diseases').insert(rows);
      }
    } on PostgrestException catch (e, s) {
      log(
        'DB 오류로 인한 saveUserDiseases 실패 : ${e.message}',
        error: e,
        stackTrace: s,
      );
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 saveUserDiseases 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }
}
