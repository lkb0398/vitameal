import 'package:vitameal/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getProfile(String uid);
  Future<void> updateProfile(UserEntity user);
}
