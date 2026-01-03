import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String uid,
    String? nickname,
    String? photoUrl,
    String? gender,
    double? height,
    double? weight,
  }) = _UserEntity;
}
