import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_id_provider.g.dart';

/// 현재 로그인된 userId 가져오기 Provider
@riverpod
String userId(Ref ref) {
  return Supabase.instance.client.auth.currentUser!.id;
}
