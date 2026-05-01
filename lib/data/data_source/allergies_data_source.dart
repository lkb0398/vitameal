import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/data/dto/allergies_dto.dart';

abstract interface class AllergiesDataSource {
  Future<List<AllergiesDto>> readAllAllergies();
  Future<void> upsertUserAllergies({
    required String userId,
    required List<int> allergyIds,
  });
  Future<List<int>> readUserAllergies(String userId);
}

class AllergiesDataSourceImpl implements AllergiesDataSource {
  AllergiesDataSourceImpl(this.client);

  final SupabaseClient client;

  @override
  Future<List<AllergiesDto>> readAllAllergies() async {
    try {
      final result = await client.from('allergies').select();
      return (result as List).map((e) => AllergiesDto.fromJson(e)).toList();
    } on PostgrestException catch (e, s) {
      log('DB 오류로 인한 fetchAll 실패 : ${e.message}', error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 fetchAll 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override // R
  Future<List<int>> readUserAllergies(String userId) async {
    try {
      final result = await client
          .from('user_allergies')
          .select('allergy_id')
          .eq('user_id', userId);
      return (result as List).map((e) => e['allergy_id'] as int).toList();
    } on PostgrestException catch (e, s) {
      log(
        'DB 오류로 인한 getUserAllergyIds 실패 : ${e.message}',
        error: e,
        stackTrace: s,
      );
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 getUserAllergyIds 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override // C
  Future<void> upsertUserAllergies({
    required String userId,
    required List<int> allergyIds,
  }) async {
    try {
      // 기존 전부 삭제
      await client.from('user_allergies').delete().eq('user_id', userId);
      // 새로 insert
      final rows = allergyIds
          .map((id) => {'user_id': userId, 'allergy_id': id})
          .toList();
      if (rows.isNotEmpty) {
        await client.from('user_allergies').insert(rows);
      }
    } on PostgrestException catch (e, s) {
      log(
        'DB 오류로 인한 saveUserAllergies 실패 : ${e.message}',
        error: e,
        stackTrace: s,
      );
      rethrow;
    } catch (e, s) {
      log('알 수 없는 오류로 인한 saveUserAllergies 실패 : e', error: e, stackTrace: s);
      rethrow;
    }
  }
}
