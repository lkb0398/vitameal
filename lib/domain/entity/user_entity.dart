class UserEntity {
  final String uid;
  final String? nickname;
  final String? photoUrl;
  final String? gender;
  final double? height;
  final double? weight;

  UserEntity({
    required this.uid,
    this.nickname,
    this.photoUrl,
    this.gender,
    this.height,
    this.weight,
  });
}
