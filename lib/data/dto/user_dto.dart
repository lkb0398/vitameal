class UserDto {
  final String userId;
  final String? nickname;
  final String? photoUrl;
  final String? gender;
  final double? heightCm;
  final double? weightKg;

  UserDto({
    required this.userId,
    this.nickname,
    this.photoUrl,
    this.gender,
    this.heightCm,
    this.weightKg,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      userId: json['user_id'] as String,
      nickname: json['nickname'] as String?,
      photoUrl: json['photo_url'] as String?,
      gender: json['gender'] as String?,

      // Supabase의 numeric 타입 대응 => num으로 받은 후 double 변환
      heightCm: (json['height_cm'] as num?)?.toDouble(),
      weightKg: (json['weight_kg'] as num?)?.toDouble(),
    );
  }
}
