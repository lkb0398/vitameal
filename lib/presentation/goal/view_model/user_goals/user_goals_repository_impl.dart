import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_data_source.dart';
import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_entity.dart';
import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_mapper.dart';
import 'package:vitameal/presentation/goal/view_model/user_goals/user_goals_repository.dart';

class UserGoalsRepositoryImpl implements UserGoalsRepository {
  UserGoalsRepositoryImpl(this.dataSource);

  final UserGoalsDataSource dataSource;

  @override
  Future<void> saveGoal(UserGoalsEntity entity) async {
    final dto = UserGoalsMapper.toDto(entity);
    return dataSource.saveGoal(dto);
  }

  // @override
  // Future<ProfilesEntity?> getMyProfile(String userId) async {
  //   final dto = await dataSource.getMyProfile(userId);
  //   if (dto == null) return null;
  //   return ProfilesMapper.toEntity(dto);
  // }

  // @override
  // Future<String> uploadProfileImage({
  //   required String userId,
  //   required File file,
  // }) {
  //   return dataSource.uploadProfileImage(userId: userId, file: file);
  // }

  // @override
  // Future<void> updateProfile(ProfilesEntity profile) {
  //   return dataSource.updateProfile(profile);
  // }

  // @override
  // Future<bool> isNicknameDuplicated(String nickname) {
  //   return dataSource.checkNickname(nickname);
  // }
}
