import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vitameal/domain/entity/eats_entity.dart';

abstract interface class EatsRemoteDataSource {
  Future<List<EatsEntity>> fetch(double lat, double lng, int? tagId);
}

/// supabase Edge Functions (search-eats) 사용
class EatsRemoteDataSourceImpl implements EatsRemoteDataSource {
  // 태그별 필터링된 음식점 검색해서 불러오기
  @override
  Future<List<EatsEntity>> fetch(double lat, double lng, int? tagId) async {
    final response = await http.post(
      Uri.parse(
        "https://ykqdcgrimdsvuincvmtu.supabase.co/functions/v1/search-eats",
      ),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlrcWRjZ3JpbWRzdnVpbmN2bXR1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgyNjY2MTgsImV4cCI6MjA4MzYyNjYxOH0.96DbUzoiQnftYE8QeFZeb71dvBIRn_8o6gnbntTTMFU",
      },
      body: jsonEncode({"lat": lat, "lng": lng, "tagId": tagId}),
    );
    if (response.statusCode != 200) {
      throw Exception("API Error: ${response.body}");
    }
    final data = jsonDecode(response.body);

    return (data['results'] as List)
        .map((e) => EatsEntity.fromJson(e))
        .toList();
  }
}
