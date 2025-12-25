import 'dart:io';
import 'package:vitameal/data/data_source/profiles_data_source.dart';
import 'package:vitameal/data/data_source/profiles_storage_data_source.dart';
import 'package:vitameal/data/mapper/profiles_mapper.dart';
import 'package:vitameal/domain/entity/allergies_entity.dart';
import 'package:vitameal/domain/entity/user_diseases_entity.dart';
import 'package:vitameal/domain/entity/profiles_entity.dart';
import 'package:vitameal/domain/repository/profiles_repository.dart';

class ProfilesRepositoryImpl implements ProfilesRepository {
  ProfilesRepositoryImpl(this.dataSource, this.storageDataSource);

  final ProfilesDataSource dataSource;
  final ProfilesStorageDataSource storageDataSource;

  @override
  Future<ProfilesEntity?> getMyProfile(String userId) async {
    final dto = await dataSource.getMyProfile(userId);
    if (dto == null) return null;
    return ProfilesMapper.toEntity(dto);
  }

  @override
  Future<String> uploadProfileImage({
    required String userId,
    required File file,
  }) {
    return storageDataSource.uploadProfileImage(userId: userId, file: file);
  }

  @override
  Future<void> updateProfile(ProfilesEntity profile) {
    final dto = ProfilesMapper.toDto(profile);
    return dataSource.updateProfile(dto);
  }

  @override
  Future<bool> isNicknameDuplicated(String nickname) {
    return dataSource.checkNickname(nickname);
  }

  @override
  Future<void> saveUserDiseases(
    String userId,
    List<UserDiseasesEntity> diseases,
  ) {
    return dataSource.replaceUserDiseases(
      userId,
      diseases.map((e) => e.diseaseId).toList(),
    );
  }

  @override
  Future<void> saveUserAllergies(
    String userId,
    List<AllergiesEntity> allergies,
  ) {
    return dataSource.replaceUserAllergies(
      userId,
      allergies.map((e) => e.id).toList(),
    );
  }
}
